
import 'dart:convert';

import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/vues/DashboardView.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/explication_projet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kpn_confort_plan/vues/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginViewState();

}

class LoginViewState extends State<LoginView> {

  bool chargement = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(fontFamily: famille_par_defaut),
      title: 'Identification',
      home:Scaffold(
        appBar: null,
        body: Builder(
          builder: (context) =>
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children :[
                SingleChildScrollView(
                  child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("CONFORT PLAN",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: vertForet),
                  ),
                ),
                // inputIdentifiant,
                chargement_en_cours(),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: IdentifiantController,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                      // enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //       color: Colors.red, width: 5.0),
                      // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Identifiant',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
                // inputPassword,
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Mot de passe',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: ButtonTheme(
                    minWidth: 150,
                    height: 56,
                    child: RaisedButton(
                      child: Text(" S'Identifier ", style: TextStyle(color: Colors.white, fontSize: 20)),
                      color: vertForet,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed:(){
                        test_http(context);
                      },
                    ),
                  ),
                ),
                buttonDecouvrir(context),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 15, 5),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push( context, MaterialPageRoute(builder: (context) => Register()),);
                    },
                    child: new Text("Pas encore menbre ? Je m'inscris"),
                  ),
                ),
              ],
            ),
                )
              ],
          ),
      ),
    ),
    );
  }

  //********************************************************methode******

  void _showToast(BuildContext context,String le_texte) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(le_texte,textAlign: TextAlign.center,style: TextStyle(color: dorer),)
      ),
    );
  }

  void test_http(context) async {
    print("http test was calling");
    // var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var identifiant = IdentifiantController.text;
    var password = passwordController.text;

    setState(() { chargement = true; });

    // Await the http get response, then decode the json-formatted response.
    if(identifiant.isEmpty || password.isEmpty){
      _showToast(context,"Vous devez remplir les champs ci-dessus");
      setState(() {
        chargement = false;
      });

    }else{

        try{

            var queryParameter = {
              'action': 'login',
              'pseudo': identifiant,
              'mdp': password,
            };

            var url = Uri.https("$adresse","$complement",queryParameter);
            print("id : "+ identifiant + " pass : "+password);

            print("************(###*&#(-------$url");
            var response = await http.get(url);

            if (response.statusCode == 200) {
              print("reponse : " + response.body);
              var jsonResponse = jsonDecode(response.body);
              print(jsonResponse['id']);
              if(jsonResponse['id'] != -1){
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                sharedPreferences.setInt("id_producteur", jsonResponse['id']);
                sharedPreferences.setString("nom_complet_producteur", jsonResponse['nom']);
                sharedPreferences.setString("email_producteur", jsonResponse['email']);


                _showToast(context,"connection reussie");
                Navigator.pushReplacement(
                  context,
                  // MaterialPageRoute(builder: (context) => HomeView()),
                  MaterialPageRoute(builder: (context) => DashboardView()),
                );
              }else {
                _showToast(context,"identifiant ou mot de passe Incorrect");
              }
            }
            else {
              print('Echec de la requete code: ${response.statusCode}.');
              _showToast(context,"Echec de connexion... verifier votre connection et reesayer");
            }
        }catch(e){
          // _showToast(context,"err -- $e-- Echec de connexion... verifier votre connection et reesayer");
          _showToast(context,"err --$e-- Echec de connexion... verifier votre connection et reesayer");
        }


        setState(() {
          chargement = false;
        });


      }

  }

  //**************************************************************
  TextEditingController IdentifiantController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final avatar = Padding(
    padding: EdgeInsets.all(20),
    child: Hero(
        tag: 'logo',
        child: SizedBox(
          height: 160,
          child: Image.asset('assets/images/logo_temporaire.png'),
        )
    ),
  );
  buttonDecouvrir(context){
    return FlatButton(
        child: Text('Decouvrir le projet', style: TextStyle(color: Colors.grey, fontSize: 16),),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExplicationView()),
          );
        }
    );
  }

  chargement_en_cours() {
    if(chargement){
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text("connection en cours..."),
      );
    }else{
      return Text("");
    }

  }
}

