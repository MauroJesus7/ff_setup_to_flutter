
import 'package:ff_setup_to_flutter/disease_manual_reports_screen.dart';
import 'package:styled_divider/styled_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportDiseasesScreen1Widget extends StatefulWidget {
  const ReportDiseasesScreen1Widget({super.key});

  @override
  State<ReportDiseasesScreen1Widget> createState() => _ReportDiseasesScreen1WidgetState();
}

class _ReportDiseasesScreen1WidgetState extends State<ReportDiseasesScreen1Widget> {
 
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    
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
          backgroundColor: Colors.white10,
          automaticallyImplyLeading: false,
          leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF606A85),
                size: 30,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
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
            padding: EdgeInsetsDirectional.fromSTEB(10, 12, 10, 0),
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      'Automatic identification of the disease',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
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
                  padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    icon: Icon(
                      Icons.photo_camera,
                      size: 40,
                    ),
                    label: Text('Scan with camera', 
                              style: GoogleFonts.outfit(
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color.fromARGB(255, 10, 187, 166), // Substitua pela cor desejada
                      foregroundColor: Colors.white,
                      elevation: 4,
                      minimumSize: Size(double.infinity, 54),
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '- OR -',
                            style: GoogleFonts.outfit(
                                  fontSize: 30,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 12),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        icon: Icon(
                          Icons.photo_library_outlined,
                          size: 40,
                        ),
                        label: Text('Choose from gallery', 
                                  style: GoogleFonts.outfit(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:Color.fromARGB(255, 10, 187, 166),
                          foregroundColor: Colors.white,
                          elevation: 4,
                          minimumSize: Size(double.infinity, 54),
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
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
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Click the button below to create a Manual Report',
                              style: GoogleFonts.outfit(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                            ),
                          ],
                        ),
                      ),

                    Container(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ManualReportDiseasesScreenWidget(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            backgroundColor: Color.fromARGB(255, 182, 124, 7),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_task,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Create Manual Report',
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
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
