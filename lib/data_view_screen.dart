// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class DataViewScreenWidget extends StatefulWidget {
// //   const DataViewScreenWidget({super.key});

// //   @override
// //   State<DataViewScreenWidget> createState() => _DataViewScreenWidgetState();
// // }

// // class _DataViewScreenWidgetState extends State<DataViewScreenWidget> {

// //   final scaffoldKey = GlobalKey<ScaffoldState>();

// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return Scaffold(
// //   //     body: Center(
// //   //       child: Column(
// //   //         mainAxisAlignment: MainAxisAlignment.center,
// //   //         children: [
// //   //           const Align(
// //   //             alignment: Alignment.center, // Centraliza horizontalmente
// //   //             child: Text(
// //   //               'Data Visualization Screen!',
// //   //               style: TextStyle(
// //   //                 fontSize: 20.0,
// //   //                 fontWeight: FontWeight.bold,
// //   //               ),
// //   //             ),
// //   //           ),
// //   //           const SizedBox(height: 20.0),
// //   //           const Icon(
// //   //             Icons.data_usage,
// //   //             size: 100.0,
// //   //             color: Colors.blue,
// //   //           ),
// //   //           const SizedBox(height: 20.0),
// //   //           ElevatedButton(
// //   //             onPressed: () {
// //   //               // Adicione a lógica para ação do botão, se necessário
// //   //             },
// //   //             child: const Text('Executar Ação'),
// //   //           ),
// //   //         ],
// //   //       ),
// //   //     ),
// //   //   );
// //   // }

// import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
// import 'package:ff_setup_to_flutter/services/ApiService.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';

// class DataViewScreenWidget extends StatefulWidget {
//   const DataViewScreenWidget({Key? key}) : super(key: key);

//   @override
//   _DataViewScreenWidgetState createState() => _DataViewScreenWidgetState();
// }

// // class DataViewScreenWidget extends StatefulWidget {
// //   final List<DiseaseReport> reports; // Lista de relatórios de doenças
// //   const DataViewScreenWidget({Key? key, required this.reports}) : super(key: key);

// //   @override
// //   _DataViewScreenWidgetState createState() => _DataViewScreenWidgetState();
// // }


// class _DataViewScreenWidgetState extends State<DataViewScreenWidget> {
//   LatLng? _currentLatLng; // Inicializado como nulo
//   late Future<List<DiseaseReport>> _reportsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _determinePosition();
//     // _reportsFuture = Provider.of<ApiService>(context, listen: false).getUserReports();
//   }

//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Verifica se os serviços de localização estão ativados
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _showSnackBar('Location services are disabled.');
//       return;
//     }

//     // Verifica a permissão da localização
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _showSnackBar('Location permissions are denied.');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       _showSnackBar('Location permissions are permanently denied.');
//       return;
//     }

//     // Obtém a posição atual
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//           forceAndroidLocationManager: true);

//       setState(() {
//         _currentLatLng = LatLng(position.latitude, position.longitude);
//       });
//     } catch (e) {
//       _showSnackBar('Error getting location: $e');
//       setState(() {
//         // Defina aqui uma localização padrão caso haja erro
//         _currentLatLng = LatLng(0.0, 0.0);
//       });
//     }
//   }

//   void _showSnackBar(String message) {
//     final snackBar = SnackBar(content: Text(message));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Data Visualization Screen',
//   //       style: GoogleFonts.outfit(
//   //         fontSize: 20,
//   //         fontWeight: FontWeight.w500,
//   //       ),),
//   //     ),
//   //     body: Column(
//   //       children: <Widget>[
//   //         // Expanded(
//   //         //   child: _currentLatLng == null
//   //         //       ? const Center(child: CircularProgressIndicator())
//   //         //       : Container(
//   //         //           padding: const EdgeInsets.all(16.0),
//   //         //           child: ClipRRect(
//   //         //             borderRadius: BorderRadius.circular(12.0), // Raio da borda para o mapa
//   //         //             child: GoogleMap(
//   //         //               initialCameraPosition: CameraPosition(
//   //         //                 target: _currentLatLng!,
//   //         //                 zoom: 14.0,
//   //         //               ),
//   //         //               mapType: MapType.normal,
//   //         //               markers: {
//   //         //                 Marker(
//   //         //                   markerId: const MarkerId('MyLocation'),
//   //         //                   position: _currentLatLng!,
//   //         //                   infoWindow: const InfoWindow(title: 'My Location'),
//   //         //                 ),
//   //         //               },
//   //         //             ),
//   //         //           ),
//   //         //         ),
//   //         // ),
//   //         Expanded(
//   //           child: _currentLatLng == null
//   //               ? const Center(child: CircularProgressIndicator())
//   //               : Container(
//   //                   padding: const EdgeInsets.all(16.0),
//   //                   child: ClipRRect(
//   //                     borderRadius: BorderRadius.circular(12.0), // Raio da borda para o mapa
//   //                     child: GoogleMap(
//   //                       initialCameraPosition: CameraPosition(
//   //                         target: _currentLatLng!,
//   //                         zoom: 14.0,
//   //                       ),
//   //                       mapType: MapType.normal,
//   //                       markers: {
//   //                         Marker(
//   //                           markerId: const MarkerId('MyLocation'),
//   //                           position: _currentLatLng!,
//   //                           infoWindow: const InfoWindow(title: 'My Location'),
//   //                         ),
//   //                       },
//   //                     ),
//   //                   ),
//   //                 ),
//   //         ),
//   //         const Center(
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Align(
//   //                 alignment: Alignment.center,
//   //                 child: Text(
//   //                   'Some charts...',
//   //                   style: TextStyle(
//   //                     fontSize: 20.0,
//   //                     fontWeight: FontWeight.w500,
//   //                   ),
//   //                 ),
//   //               ),
//   //               SizedBox(height: 20.0),
//   //               Icon(
//   //                 Icons.data_usage,
//   //                 size: 100.0,
//   //                 color: Colors.blue,
//   //               ),
//   //               SizedBox(height: 20.0),
//   //               ElevatedButton(
//   //                 onPressed: null, // Adicione a lógica para ação do botão aqui
//   //                 child: Text('Executar Ação'),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Data Visualization Screen',
//         style: GoogleFonts.outfit(
//           fontSize: 20,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     ),
//     body: FutureBuilder<ReportsResponse>(
//       future: Provider.of<ApiService>(context, listen: false).getUserReports(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text("Error: ${snapshot.error.toString()}"));
//         }
//         if (!snapshot.hasData || snapshot.data!.reports.isEmpty) {
//           return const Center(child: Text("No disease reports found."));
//         }

//         List<DiseaseReport> reports = snapshot.data!.reports;
//         Set<Marker> markers = _createMarkersFromReports(reports);

//         // ... Restante do código ...
//       },
//     ),
//   );
// }

// Set<Marker> _createMarkersFromReports(List<DiseaseReport> reports) {
//   return reports.map((report) {
//     double lat = double.tryParse(report.latitude) ?? 0.0;
//     double lng = double.tryParse(report.longitude) ?? 0.0;
//     return Marker(
//       markerId: MarkerId(report.code.toString()),
//       position: LatLng(lat, lng),
//       infoWindow: InfoWindow(title: report.code, snippet: report.description),
//     );
//   }).toSet();
// }


// }


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
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10.0),
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

                return Container(
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
                );
              },
            ),
          ),
          // ... outros componentes da UI ...
        ],
      ),
    );
  }

}
