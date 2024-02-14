import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:ff_setup_to_flutter/services/ApiService.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ReportAnomaliesScreenWidget extends StatefulWidget {
  const ReportAnomaliesScreenWidget({super.key});

  @override
  State<ReportAnomaliesScreenWidget> createState() =>
      _ManualReportDiseasesScreenWidgetState();
}

class _ManualReportDiseasesScreenWidgetState
    extends State<ReportAnomaliesScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  double? latitude;
  double? longitude;
  bool isReportPrivate = false;

  

  @override
  void initState() {
    super.initState();   

    _determinePosition();
  } 

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services disabled.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions denied.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions permanently denied.");
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: ImageSource
            .gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No images selected.');
      }
    });
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF606A85),
                size: 30,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/Mauro-ProfilePhoto.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Create Report',
                    style: GoogleFonts.outfit(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Create a report choosing options',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: 330,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 197, 199, 203),
                        width: 0.7,
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: null, // Substitua por um valor inicial se desejar
                      onChanged: (String? newValue) {
                        
                      },
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Option 1',
                          child: Text('Option 1'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Option 2',
                          child: Text('Option 2'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Option 3',
                          child: Text('Option 3'),
                        ),
                      ],
                      hint: Text('Choose an option...',
                        style: GoogleFonts.outfit(
                          fontSize: 18
                        ),
                      ),
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: InputBorder.none, 
                      ),
                    ),
                  ),


                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                           
                                                        
                            TextFormField(
                              controller: null,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText:
                                    'Short Description of what is going on...',
                                hintStyle: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 10, 187, 166),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(
                                        0xFFFF5963), 
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(
                                        0xFFFF5963), // Cor de erro de foco aleatória
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        16, 24, 16, 12),
                              ),
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 10,
                              minLines: 6,
                              cursorColor:
                                  const Color.fromARGB(255, 10, 187, 166),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _image == null
                                        ? const Icon(Icons.image,
                                            size: 100.0,
                                            color: Colors
                                                .grey) 
                                        : Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Raio da borda
                                              border: Border.all(
                                                color:
                                                    Colors.grey, // Cor da borda
                                                width: 1.0, // Largura da borda
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.file(
                                                _image!,
                                                fit: BoxFit.cover,
                                                width: 100.0,
                                                height: 100.0,
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton.icon(
                                    onPressed: _image == null
                                        ? _pickImage
                                        : _removeImage,
                                    icon: Icon(
                                      _image == null
                                          ? Icons.add_photo_alternate
                                          : Icons.delete,
                                      color: _image == null
                                          ? Colors.blue
                                          : Colors.red,
                                      size: 30,
                                    ),
                                    label: Text(
                                      _image == null
                                          ? 'Choose image'
                                          : 'Remove image',
                                      style: GoogleFonts.outfit(
                                          fontSize: 15, color: Colors.black),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: SwitchListTile(
                                title: Text(
                                  'Is Private Report',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                  ),
                                ),
                                value: isReportPrivate,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    isReportPrivate = newValue;
                                  });
                                },
                                activeColor: const Color.fromARGB(255, 10, 187, 166),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                                controlAffinity: ListTileControlAffinity.trailing, // Coloque o controle na extremidade direita
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
                              child: ElevatedButton.icon(
                                onPressed: () async {                                 
                                },
                                icon: const Icon(
                                  Icons.add_circle_sharp,
                                  size: 25,
                                ),
                                label: Text(
                                  'Create',
                                  style: GoogleFonts.outfit(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 10, 187, 166),
                                  foregroundColor: Colors.white,
                                  elevation: 4,
                                  minimumSize: const Size(double.infinity, 54),
                                  padding: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),                          
                          ]
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
