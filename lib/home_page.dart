import 'package:ff_setup_to_flutter/disease_report_details_screen.dart';
import 'package:ff_setup_to_flutter/disease_reports_screen1.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';
import 'package:ff_setup_to_flutter/models/PestReport.dart';
import 'package:ff_setup_to_flutter/pest_reports_screen.dart';
import 'package:ff_setup_to_flutter/report_anomalies_screen.dart';
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
  late Future<ReportsResponse> _reportsFuture;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    Future<ReportsResponse?>? _reportsFuture;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _reportsFuture = Provider.of<ApiService>(context, listen: false).getUserReports();
        });
      }
    });
  }

  void reloadData() {
    setState(() {
      _reportsFuture = Provider.of<ApiService>(context, listen: false).getUserReports();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _logout() async {
    await ApiService().logout();

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            // Verifica novamente antes de fechar o diálogo
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, '/login');
          }
        });

        return AlertDialog(
          title: Text(
            "Logout Successful",
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(fontSize: 20),
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "You have been successfully logged out.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
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
                padding: const EdgeInsetsDirectional.fromSTEB(16, 40, 16, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () => reloadData(),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: const Color.fromARGB(240, 10, 180, 160),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
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
                    ),

                    Expanded( 
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              homeModel.fullName,
                              style: GoogleFonts.outfit(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: Text(
                                homeModel.teamCode ?? "No associated team",
                                style: GoogleFonts.outfit(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // await ApiService().logout();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            
                            Future.delayed(const Duration(seconds: 2), () {
                              if (mounted) {
                                // Verifica se o widget ainda está montado
                                Navigator.of(context)
                                    .pop(); // Fecha a caixa de diálogo
                                Navigator.pushReplacementNamed(context,
                                    '/login'); 
                              }
                            });

                            return AlertDialog(
                              title: Text(
                                "Logout Successful",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(fontSize: 20),
                              ),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      "You have been successfully logged out.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.signOut,
                        color: Color.fromARGB(255, 243, 54, 54),
                        size: 28,
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
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
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
                            onTap: () async {
                              Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ReportAnomaliesScreenWidget(),
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
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ReportPetsScreenWidget(),
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
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: const Alignment(0, 0,),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                              child: TabBar(
                              isScrollable: false,                            
                              labelColor: const Color(0xFF249689),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle: TextStyle(),
                              indicatorColor: const Color(0xFF249689),
                              indicatorWeight: 2,
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Diseases",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Anomalies",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Pests",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Suggests.",
                                    style: GoogleFonts.outfit(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                              controller: _tabController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              buildDiseaseReportsTab(context), // Aba de relatórios de doenças
                              const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, 
                                  children: [
                                    Icon(Icons.info_outline, size: 50, color: Colors.grey),
                                    Text(
                                      "No reports associated with this tab at the moment.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              buildPestReportsTab(context), // Aba de relatórios de pragas
                              const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.info_outline, size: 50, color: Colors.grey),
                                    Text(
                                      "No reports associated with this tab at the moment.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
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
    return FutureBuilder<ReportsResponse>(
      future: Provider.of<ApiService>(context, listen: false).getUserReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('Error loading reports: ${snapshot.error}');
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        }

        List<DiseaseReport>? reports = snapshot.data?.reports;
        if (reports == null || reports.isEmpty) {
          return const Center(
              child: Text("No disease reports found for current user."));
        }

        return Padding(
          padding: const EdgeInsets.all(9.0),
          child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            DiseaseReport report = reports[index];

            // Formatando a data
            String formattedDate = DateFormat('EEE, MMM d, yyyy - h:mm a')
                .format(report.createdAt);

            return Container(              
              width: 20,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 214, 212, 212), // Cor da borda
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
              ),              
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,                  
                  children: [
                    Text(
                      report.code,
                      style: GoogleFonts.outfit(
                        fontSize: 21,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        report.description,
                        style: GoogleFonts.outfit(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 114, 113, 113),
                        fontWeight: FontWeight.w500
                      ),
                      ),
                    ),
                    const Divider(
                      height: 22,
                      thickness: 1,
                      color: Color.fromARGB(255, 195, 193, 193),
                    ),
                    Text(
                      "$formattedDate",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: const Color(0xFF249689),
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DiseaseReportDetailWidget(report: report),
                              ),
                            );
                          },

                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF249689), // Cor de fundo do botão
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            'See detail',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        );
        
      },
    );
  }

  Widget buildPestReportsTab(BuildContext context) {
    return FutureBuilder<PestReportsResponse>(
      future: Provider.of<ApiService>(context, listen: false).getUserPestReports(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          print('Error loading reports: ${snapshot.error}');
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        }

        List<PestReport>? reports = snapshot.data?.pestReports;
        if (reports == null || reports.isEmpty) {
          return const Center(
              child: Text("No pest reports found for current user."));
        }

        return Padding(
          padding: const EdgeInsets.all(9.0),
          child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            PestReport report = reports[index];

            // Formatando a data
            String formattedDate = DateFormat('EEE, MMM d, yyyy - h:mm a')
                .format(report.createdAt);

            return Container(              
              width: 20,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 214, 212, 212), // Cor da borda
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
              ),              
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,                  
                  children: [
                    Text(
                      report.code, // Nome do report
                      style: GoogleFonts.outfit(
                        fontSize: 21,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        report.description,
                        style: GoogleFonts.outfit(
                        fontSize: 17,
                        color: const Color.fromARGB(255, 114, 113, 113),
                        fontWeight: FontWeight.w500
                      ),
                      ),
                    ),
                    const Divider(
                      height: 22,
                      thickness: 1,
                      color: Color.fromARGB(255, 195, 193, 193),
                    ),
                    Text(
                      "$formattedDate",
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        color: const Color(0xFF249689),
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          // Ação ao clicar no botão
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF249689), // Cor de fundo do botão
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Text(
                            'See detail',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        );
        
      },
    );
  }

}
