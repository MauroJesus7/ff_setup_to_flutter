
import 'package:ff_setup_to_flutter/disease_manual_reports_screen.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';

class ReportDiseasesScreen1Widget extends StatefulWidget {
  const ReportDiseasesScreen1Widget({super.key});

  @override
  State<ReportDiseasesScreen1Widget> createState() => _ReportDiseasesScreen1WidgetState();
}

class _ReportDiseasesScreen1WidgetState extends State<ReportDiseasesScreen1Widget> {
 
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? selectedCrop;

  File? _image;
  final imagePicker = ImagePicker();
  bool _loading = true;
  List<dynamic> _predictions = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      print("Error loading TFLite model: $e");
    }
  }

  Future detect_image(File image) async {
    var prediction = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true
    );

    setState(() {
      _loading = false;
      if (prediction != null) {
        _predictions = prediction;
        if (selectedCrop != null && !_predictions[0]['label'].toString().toLowerCase().contains(selectedCrop!.toLowerCase())) {
          // Se a doença detectada não corresponder à crop selecionada
          _predictions = []; // Limpa as previsões
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Crop Mismatch",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  "Detected disease does not match the selected crop. Please select the correct crop.",
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: Text(
                      "OK",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    });
  }

  void clearCropSelection() {
    setState(() {
      selectedCrop = null;
    });
  }

  Future _loadImage(ImageSource source) async {
    var image = await imagePicker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _loading = true;
      });
      detect_image(_image!);
    }
  }

  @override
  void dispose() { 
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white10,
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
            // Localize o widget da foto do perfil
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              child: GestureDetector(
                onTap: clearCropSelection,  // Chama clearCropSelection quando a foto do perfil é clicada
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
            ),

          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 30),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(2, 2,),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/plant-scan.jpg',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                  ),
                                  Text(
                                      'Take a picture',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  ),
                                ]
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/leaf-diagnostic.png',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Get disease result',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  ),
                                  ]
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        'assets/map-icon-png-free-3.png',
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      'Get Geolocalization',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  ),
                                  ]
                              ),
                            ]
                          ),
                        ]
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Choose a Crop for automatic identification',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),                  

                _buildCropSelection(),
                if (selectedCrop != null) ...[                

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 12),
                      child: SizedBox(
                        width: 280,
                        child: ElevatedButton.icon(
                          onPressed: () => _loadImage(ImageSource.camera),
                          icon: const Icon(
                            Icons.photo_camera,
                            size: 30,
                          ),
                          label: Text(
                            'Scan with camera',
                            style: GoogleFonts.outfit(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 10, 187, 166),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            minimumSize: Size(double.infinity, 50),
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '- OR -',
                            style: GoogleFonts.outfit(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 12),
                      child: SizedBox(
                        width: 280,
                        child: ElevatedButton.icon(
                          onPressed: () => _loadImage(ImageSource.gallery),
                          icon: const Icon(
                            Icons.photo_library_outlined,
                            size: 30,
                          ),
                          label: Text(
                            'Choose from gallery',
                            style: GoogleFonts.outfit(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 10, 187, 166),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            minimumSize: Size(double.infinity, 50),
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),


                    _loading == false && _image != null
                      ? Container(
                          child: Column(
                            children: [
                              Image.file(_image!),
                              _buildPredictionText(),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Implemente a ação para "Reportar"
                                    },
                                    icon: const Icon(Icons.add),
                                    label: Text(
                                      'Save',
                                      style: GoogleFonts.outfit(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 10, 187, 166),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _loading = true;
                                        _image = null;
                                        _predictions = [];
                                      });
                                    },
                                    icon: const Icon(Icons.cancel),
                                    label: Text(
                                      'Cancelar',
                                      style: GoogleFonts.outfit(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),                                   
                    ],                    

                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const SizedBox(
                      width: 300,
                      child: StyledDivider(
                        thickness: 1,
                        color: Colors.black,
                        lineStyle: DividerLineStyle.dashed,
                      ),
                    ),
                  ),   

                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Click the button below to report your task',
                              style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            ),
                          ],
                        ),
                      ),

                    Container(
                      width: 280,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ManualReportDiseasesScreenWidget(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            backgroundColor: const Color.fromARGB(255, 182, 124, 7),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.checklist,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Create Report',
                                style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )

                    ],
                  ),

              ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildCropOption(String crop, String assetName) {
  bool isSelected = selectedCrop == crop; // Verifica se a crop está selecionada

    return InkWell(
      onTap: () => setState(() => selectedCrop = crop),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(assetName, width: 60, height: 60), // Substitua Icon por Image.asset
          Text(crop, style: GoogleFonts.outfit()),
          SizedBox(height: 4), // Espaçamento entre o texto e o indicador
          isSelected
            ? Container(
                height: 2, // Altura do traço
                width: 60, // Largura do traço
                color: const Color.fromARGB(255, 10, 187, 166), // Cor do traço
              )
            : Container(), // Se não estiver selecionado, não mostra nada
        ],
      ),
    );
  }


  Widget _buildCropSelection() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCropOption("Potato", "assets/potato_crop_icon.png"),
          _buildCropOption("Tomato", "assets/tomato_crop_icon.png"),
          _buildCropOption("Pepper bell", "assets/pepper_bell_icon.png"),
        ],
      ),
    );
  }

Widget _buildPredictionText() {
    if (_predictions.isNotEmpty && _predictions[0]['label'] != null && _predictions[0]['confidence'] != null) {
      return Column(
        children: [
          Text(
            'Detected: ${_predictions[0]['label'].toString().substring(_predictions[0]['label'].toString().indexOf(' ') + 1)}',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Precision: ${( _predictions[0]['confidence'] * 100).toStringAsFixed(0)}%',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            'No detection',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Precision: N/A',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      );
    }
  }

}
