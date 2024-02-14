import 'dart:convert';
import 'package:ff_setup_to_flutter/services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:ff_setup_to_flutter/models/DiseaseReport.dart';

class DiseaseReportDetailWidget extends StatefulWidget {
  final DiseaseReport report;

  const DiseaseReportDetailWidget({Key? key, required this.report}) : super(key: key);

  @override
  State<DiseaseReportDetailWidget> createState() => _DiseaseReportDetailWidgetState();
}

class _DiseaseReportDetailWidgetState extends State<DiseaseReportDetailWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF15161E)),
        title: Text(
          'Report Details',
          style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: ApiService.getCropNameById(widget.report.cropId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Failed to load crop name. Please try again later.'));
                }
                // Aqui você construiria a UI com os dados do relatório
                return Container(
                  width: 400,
                  margin: const EdgeInsets.all(16.0), // Adiciona margem ao redor do container
                  padding: const EdgeInsets.all(16.0), // Adiciona espaçamento interno
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300), // Define a cor da borda para cinza claro
                    borderRadius: BorderRadius.circular(12), // Arredonda os cantos da borda
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // Sombra leve para um efeito elevado
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2), // Posição da sombra
                      ),
                    ],
                    color: Colors.white, // Cor de fundo do container
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Report Code: ${widget.report.code}',
                        style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description: ${widget.report.description}',
                        style: GoogleFonts.outfit(fontSize: 18),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Crop: ${snapshot.data ?? 'Unknown'}',
                        style: GoogleFonts.outfit(fontSize: 18, color: Colors.green[700], fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),                  
                      
                      FutureBuilder<String>(
                        future: ApiService.getDiseaseNameById(widget.report.diseaseId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Failed to load disease name. Please try again later.'));
                          }
                          return Text(
                            'Disease: ${snapshot.data ?? 'Unknown'}',
                            style: GoogleFonts.outfit(fontSize: 18, color: Colors.red[700], fontWeight: FontWeight.bold),
                          );
                        },
                      ),

                      FutureBuilder<String>(
                        future: ApiService.getPhotoUrlByReportCode(widget.report.code),
                        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                              return Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  width: 200,
                                  height: 200,
                                  child: Image.network(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.error,
                                          size: 50,
                                          color: Colors.red, // Cor do ícone de erro
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: const Icon(
                                    Icons.image,
                                    size: 50,
                                  ),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: Text('Something went wrong.'),
                            );
                          }
                        },
                      ),                     
                      // Adicione mais detalhes do relatório conforme necessário
                    ],
                  ),
                );
              },
            ),
            // Adicione mais Widgets aqui conforme necessário
          ],
        ),
      ),
    );
  }
}
