import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  // Champs de texte
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Erreur
  String? error;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final String backgroundImage = "assets/images/background.png"; // Remplacez le chemin par le vôtre

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                       Container(
                        width: 360,
                        height: 550,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.0), // Opacité de 0.8 (ajustez selon vos besoins)
                          //borderRadius: BorderRadius.circular(16),
                        ),
                         child: Card(
                                           child: Container(
                          color: Colors.white.withOpacity(1.0), // Opacité de 0.8 (ajustez selon vos besoins)
                                           //height: 300,
                                           child: Center(
                                             child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('Connexion', style: TextStyle(
                                fontSize: 24,)),
                            SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Email',
                                    hintText: 'Email',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 300,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    labelText: 'Mot de passe',
                                    //hintText: 'Mot de passe',
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                              width: 300, // Largeur du bouton
                              height: 40,
                              margin: const EdgeInsets.only(top: 10, bottom: 10), // Marge supérieure
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromRGBO(253, 139, 139, 1),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                    String email = emailController.text;
                                    String password = passwordController.text;

                                    if (email.isEmpty || password.isEmpty) {
                                      error = 'Veuillez remplir tous les champs';
                                    } else {
                                      _auth.signInWithEmailAndPassword(email: email, password: password)
                                        .then((user) {
                                          Navigator.pop(context);
                                        })
                                        .catchError((e) {
                                          error = e.message;
                                        });
                                    }

                                    if (error != null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(error!),
                                        ),
                                      );
                                    }
                                  },
                                child: const Text('Connexion',
                                style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                //fontFamily: 'Poppins',
                              ),
                              ),
                              ),
                                                      ),
                            ),
                         
                          SizedBox(height: 30,),
                          // Bouton de connexion avec Google
                                     Container(
                                      width: 250,
                                      height: 35,
                                       child: ElevatedButton(
                                                onPressed: () async {
                                                  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
                                                  if (googleUser != null) {
                                                    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
                                                    final OAuthCredential credential = GoogleAuthProvider.credential(
                                                      accessToken: googleAuth?.accessToken,
                                                      idToken: googleAuth?.idToken,
                                                    );

                                                    await _auth.signInWithCredential(credential);
                                                    Navigator.pop(context);
                                                  }

                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/google.png', 
                                                      height: 24, 
                                                      width: 24, 
                                                    ),
                                                    SizedBox(width: 8), 
                                                    const Text(
                                                      'Connexion avec Google',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                     )

                                              ],
                                             ),
                                           ),
                                         ),
                                       ),
                       ),
            ],
          )
                  ),
      )
                );
                
                }
                }