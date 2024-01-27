import 'package:ff_setup_to_flutter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ff_setup_to_flutter/services/ApiService.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {

  final ApiService apiService = ApiService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();    
  }

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(      
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 1,
          decoration: BoxDecoration(),
          child: Align(
            alignment: AlignmentDirectional(0.00, 1.00),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Smart AGRI App',
                    style: GoogleFonts.outfit(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              
              Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (Theme.of(context).brightness == Brightness.dark)
                          Image.asset(
                            'assets/images/uiLogo_robinLight@3x.png',
                            width: 240,
                            height: 60,
                            fit: BoxFit.fitWidth,
                          ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/indian-farmer.webp',
                    width: 300,
                    height: 270,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x24000000),
                          offset: Offset(0, -1),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                       Padding(
                        padding:  EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                  'Welcome Back,',
                                  style: GoogleFonts.outfit(
                                    fontSize: 30,
                                    color: Color(0xFF0F1113),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                 border: Border.all(
                                  color: Colors.white,
                                  width: 1.0,
                                  ),
                              ),
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.lock,
                                  color: Color(0xFF57636C),
                                  size: 34,
                                ), 
                                onPressed: () {  },
                              ),           
                            ),
                          ],
                        ),
                      ),

                    // EMAIL TEXT BOX
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: emailController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: const TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your email here...',
                                    hintStyle: const TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                           borderRadius: BorderRadius.circular(8),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                            16, 24, 0, 24),),
                                style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF0F1113),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                       maxLines: null,
                              ),
                              ),
                          ],
                        ),
                        ),

                    // PASSWORD TEXTBOX

                     Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        hintText: 'Enter your password here...',
                                    hintStyle: const TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                        color: Color(0xFFF1F4F8),
                                        width: 2,
                                          ),
                                           borderRadius: BorderRadius.circular(8),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0x00000000),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            16, 24, 0, 24),
                                        
                                ),
                                style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Color(0xFF0F1113),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                       maxLines: null,
                              ),
                              ),
                          ],
                        ),
                        ),
                    
                    Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                 style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20,),
                                primary: Color.fromARGB(255, 23, 23, 23),
                              ),
                                onPressed: () {},
                              child:  const Text('Forgot Password?'),),
                              
                              ElevatedButton(
                                style: 
                                ElevatedButton.styleFrom(
                                  minimumSize: Size(130, 40),
                                  backgroundColor: Colors.teal
                                ),                                  
                                onPressed: () async {
                                  String email = emailController.text;
                                  String password = passwordController.text;                                

                                  var result = await apiService.login(email, password);
                                  if (result['status'] == "Success") {

                                    Provider.of<HomeModel>(context, listen: false).setUserData(
                                      result['fullName'],
                                      result['userId'].toString(),
                                    );
                                    // Mostrar um alerta de sucesso com o nome e ID do usuário
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Login Successfully",
                                            style: GoogleFonts.outfit(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          content: Text("Welcome ${result['fullName']} to AGRISmart Pro App. Your ID is ${result['userId']}."),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) => HomeWidget(), // Substitua HomeWidget() pelo nome correto da sua página inicial
                                                  ),
                                                );                                                
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    // Mostrar mensagem de erro com detalhes adicionais, se houver
                                    String errorMessage = 'Falha no Login';
                                    if (result.containsKey('message')) {
                                      errorMessage += ': ${result['message']}';
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(errorMessage)),
                                    );
                                  }

                                }, 
                                child: const Text('Login',
                                style: TextStyle(fontSize: 18,
                                color: Colors.white),
                                )
                                
                              )
                             
                            ],
                          ),
                        ),

                    ],
                  ),
                ),              
               ]
              ),
            ),
          ),
        ),

      ),
    );
  }
}
