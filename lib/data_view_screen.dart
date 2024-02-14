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
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(9.0), // Adicione o espaçamento desejado
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              constraints: BoxConstraints(
                                maxWidth: 370,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [                
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Reports Completed',
                                            style: GoogleFonts.outfit(
                                                  fontSize: 16
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '255',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_upward_rounded,
                                                color: Color.fromARGB(255, 10, 187, 166), // Cor do ícone
                                                size: 20,
                                              ),                         
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0), // Adicione o espaçamento desejado
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              constraints: const BoxConstraints(
                                maxWidth: 370,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white, // Cor de fundo
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black12, // Cor da borda
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [                
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Upcoming Tasks',
                                            style: GoogleFonts.outfit(
                                                  fontSize: 16
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '67',
                                                style: GoogleFonts.outfit(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_upward_rounded,
                                                color: Color.fromARGB(255, 10, 187, 166), // Cor do ícone
                                                size: 20,
                                              ),
                                              
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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


}
