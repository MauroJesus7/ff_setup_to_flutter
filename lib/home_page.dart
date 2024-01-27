import 'package:ff_setup_to_flutter/disease_reports_screen1.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:ff_setup_to_flutter/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
  
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  
  late HomeModel _model;
  late TabController _tabController;
  late Future<List<DiseaseReport>> _reportsFuture;

  final scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _reportsFuture = Provider.of<ApiService>(context, listen: false).getUserReports();
        });
      }
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final homeModel = Provider.of<HomeModel>(context);

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 44, 16, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color.fromARGB(255, 10, 187, 166),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            'assets/Mauro-ProfilePhoto.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeModel.fullName,
                            style: GoogleFonts.outfit(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                            child: Text(
                              'Team #673241-CB',
                              style: GoogleFonts.outfit(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Start an activity...',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(),
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
                      child: Container(
                        width: 220,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[50],
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x34090F13),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ReportDiseasesScreen1Widget(),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[50],
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.asset(
                                        'assets/small_Example_of_Shot_Hole_Disease_b1f61159b2.webp',
                                      ).image,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 170,
                                child: Divider(
                                  thickness: 1,
                                  color: Color(0xFF366B35),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Report Diseases',
                                    style: GoogleFonts.outfit(
                                      color: const Color(0xFF366B35),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 12, 12, 12),
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x34090F13),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {},
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image.asset(
                                          'assets/rega-system.jpg',
                                        ).image,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 170,
                                  child: Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 197, 149, 3),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Report Anomalies',
                                      style: GoogleFonts.outfit(
                                        color: const Color.fromARGB(
                                            255, 197, 149, 3),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 12, 12, 12),
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x34090F13),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {},
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: Image.asset(
                                          'assets/pests-image.jpg',
                                        ).image,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 170,
                                  child: Divider(
                                    thickness: 1,
                                    color: Colors.green[900],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Report Pest',
                                      style: GoogleFonts.outfit(
                                        color: Colors.green[900],
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16, 12, 12, 12),
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x34090F13),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {},
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[50],
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: Image.asset(
                                          'assets/urban-farm.jpg',
                                        ).image,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0),
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 170,
                                  child: Divider(
                                    thickness: 1,
                                    color: Color(0xFF85693D),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Report Suggestions',
                                      style: GoogleFonts.outfit(
                                        color: const Color(0xFF85693D),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Reports List',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x1B090F13),
                        offset: Offset(0, -2),
                      )
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: const Alignment(0, 0),
                          child: TabBar(
                            isScrollable: true,
                            labelColor: const Color.fromARGB(255, 10, 187, 166),
                            unselectedLabelColor: Colors.black,
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor:
                                const Color.fromARGB(255, 10, 187, 166),
                            indicatorWeight: 2,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Diseases",
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Anomalies",
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Pests",
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Suggestions",
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                            controller: _tabController,
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                               buildDiseaseReportsTab(context), // Aba de relatórios de doenças
                              Container(), // Substitua por conteúdo real para as outras abas
                              Container(), // Substitua por conteúdo real para as outras abas
                              Container(), // Substitua por conteúdo real para as outras abas
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDiseaseReportsTab(BuildContext context) {
  return FutureBuilder<List<DiseaseReport>>(
    future: Provider.of<ApiService>(context, listen: false).getUserReports(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        print('Error loading reports: ${snapshot.error}');
        return Center(child: Text("Error: ${snapshot.error.toString()}"));
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No reports found"));
      }

      List<DiseaseReport> reports = snapshot.data!;
      return ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          DiseaseReport report = reports[index];

          // Formatando a data
          String formattedDate = DateFormat('EEE, MMM d, yyyy - h:mm a').format(report.createdAt);

          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.code, // Nome do report
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        report.description,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Divider(
                      height: 24,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                    Text(
                      "$formattedDate",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 10, 187, 166),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // Ação ao clicar no botão
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 10, 187, 166),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            'See detail',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

    },
  );
}

  
}
