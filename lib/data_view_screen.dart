import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:ff_setup_to_flutter/services/ApiService.dart';

class DataViewScreenWidget extends StatefulWidget {
  const DataViewScreenWidget({Key? key}) : super(key: key);

  @override
  _DataViewScreenWidgetState createState() => _DataViewScreenWidgetState();
}

class _DataViewScreenWidgetState extends State<DataViewScreenWidget> {
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se os serviços de localização estão ativados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showSnackBar('Location services are disabled.');
      return;
    }

    // Verifica a permissão da localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showSnackBar('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showSnackBar('Location permissions are permanently denied.');
      return;
    }

    // Obtém a posição atual
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);

      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      _showSnackBar('Error getting location: $e');
      setState(() {
        _currentLatLng = LatLng(0.0, 0.0); // Localização padrão em caso de erro
      });
    }
  }

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Set<Marker> _createMarkersFromReports(List<DiseaseReport> reports) {
    return reports.map((report) {
      double lat = double.tryParse(report.latitude) ?? 0.0;
      double lng = double.tryParse(report.longitude) ?? 0.0;
      return Marker(
        markerId: MarkerId(report.code.toString()),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: report.code, snippet: report.description),
      );
    }).toSet();
  }

  Map<String, int> _getReportCounts(List<DiseaseReport> reports) {
    Map<String, int> counts = {};
    for (var report in reports) {
      counts[report.description] = (counts[report.description] ?? 0) + 1;
    }
    return counts;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho personalizado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10.0),
            //color: Theme.of(context).primaryColor, // Ou use uma cor específica
            child: SafeArea(
              child: Text(
                'Data Visualization Screen',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 13, 13, 13), // Cor do texto
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<ReportsResponse>(
              future: Provider.of<ApiService>(context, listen: false).getUserReports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error.toString()}"));
                }
                if (snapshot.data?.reports?.isEmpty ?? true) {
                  return const Center(child: Text("No disease reports found."));
                }

                List<DiseaseReport> reports = snapshot.data?.reports ?? [];
                Set<Marker> markers = _createMarkersFromReports(reports);

                if (_currentLatLng != null) {
                  markers.add(Marker(
                    markerId: const MarkerId('MyLocation'),
                    position: _currentLatLng!,
                    infoWindow: const InfoWindow(title: 'My Location'),
                  ));
                }

                return Column(
                  children: [
                    Expanded(
                      flex: 2, // Ajuste conforme necessário
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _currentLatLng ?? LatLng(0.0, 0.0),
                              zoom: 14.0,
                            ),
                            mapType: MapType.normal,
                            markers: markers,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1, // Ajuste conforme necessário
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: _buildChart(reports), // Certifique-se de que esta função está implementada
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildChart(List<DiseaseReport> reports) {
    var counts = _getReportCounts(reports);
    List<PieChartSectionData> sections = counts.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.blue, // Você pode querer usar cores diferentes para cada seção
        value: entry.value.toDouble(),
        title: '${entry.value}', // Ou pode formatar isso de forma mais sofisticada
        radius: 50,
      );
    }).toList();

    return PieChart(
      PieChartData(sections: sections),
    );
  }


}
