import 'package:ff_setup_to_flutter/home_page.dart';
import 'package:ff_setup_to_flutter/main.dart';
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

  bool _passwordVisible = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  OutlineInputBorder emailFieldErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red, // Alterado para vermelho
      width: 2,
    ),
    borderRadius: BorderRadius.circular(8),
  );

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
                    decoration: const BoxDecoration(
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
                        padding:  const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
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
                                icon: const FaIcon(
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
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
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
                                  labelStyle: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF57636C),
                                  ),
                                  hintText: 'Enter your email here...',
                                  hintStyle: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF57636C),
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
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, // Alterado para vermelho
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.red, // Alterado para vermelho
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 24, 0, 24),
                                  ),
                                  style: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  maxLines: null,
                                ),
                              ),
                            ],
                          ),
                        ),

                    // PASSWORD TEXTBOX
                     Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.outfit(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    color: const Color.fromARGB(255, 99, 98, 98)
                                  ),
                                  hintText: 'Enter your password here...',
                                  hintStyle: GoogleFonts.outfit(
                                    fontSize: 16,
                                    color: const Color(0xFF57636C),
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
                                  contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Color(0xFF57636C),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                style: const TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF0F1113),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                              ),

                              ),
                          ],
                        ),
                      ),
                    
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                style: TextButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 16,),
                              foregroundColor: const Color.fromARGB(255, 23, 23, 23),
                            ),
                              onPressed: () {},
                            child:  Text('Forgot Password?',
                              style: GoogleFonts.outfit(
                                fontSize: 18
                              ),
                            ),
                            ),                              
                            ElevatedButton(
                              style: 
                              ElevatedButton.styleFrom(
                                minimumSize: const Size(140, 50),
                                backgroundColor: const Color(
                                0xFF249689),
                                
                              ),                             
                              
                              onPressed: () async {
                                String email = emailController.text;
                                String password = passwordController.text;

                                var result = await apiService.login(email, password);

                                if (result['status'] == "Success") {
                                  Provider.of<HomeModel>(context, listen: false).setUserData(
                                    result['fullName'],
                                    result['teamCode'],
                                    result['userId'].toString(),
                                  );

                                  // Mostrar um alerta de sucesso com o nome e ID do usuário
                                 showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle, // Ícone de sucesso
                                              color: Colors.green, // Cor do ícone
                                              size: 40.0, // Tamanho do ícone
                                            ),
                                            SizedBox(height: 10), // Espaçamento entre o ícone e o texto
                                            Text(
                                              "Login Successfully",
                                              textAlign: TextAlign.center, // Centraliza o texto
                                              style: GoogleFonts.outfit(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Text(
                                          "Welcome to AGRISmart Pro App, ${result['fullName']}! Your Team Code is ${result['teamCode']}.",
                                          textAlign: TextAlign.center, // Centraliza o conteúdo
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Go to home", textAlign: TextAlign.center,),
                                            onPressed: () {
                                              Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(builder: (context) => NavBarApp()), // Navega para NavBarApp
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                } else {
                                  // Mostrar mensagem de erro com detalhes adicionais, se houver
                                  String errorMessage = 'Login failed';

                                  if (result['status'] == "Error") {
                                    errorMessage = result['message'];

                                    if (errorMessage.contains("not assigned to any team")) {
                                      // Mostra uma caixa de diálogo para o caso específico do TeamCode null
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Icon(
                                              Icons.error_outline, // Ícone de erro
                                              color: Colors.red, // Cor do ícone
                                              size: 40.0, // Tamanho do ícone
                                            ),
                                            content: Text(
                                              errorMessage,
                                              textAlign: TextAlign.center, // Centraliza o conteúdo
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text("Contact Admin"),
                                                onPressed: () {                                                  
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      // Mostra uma SnackBar para outros erros
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(errorMessage)),
                                      );
                                    }
                                  }

                                }
                              },                            
                                                                
                              child: Text('Login',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                              ),
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
        ),

      ),
    );
  }
}
