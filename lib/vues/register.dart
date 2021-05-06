
import 'dart:convert';

import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/vues/DashboardView.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/explication_projet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class Register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RegisterState();

}

class RegisterState extends State<Register> {

  bool chargement = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Inscription",style: TextStyle(color: Colors.white),),
        backgroundColor: vertForet,
      ),
      body:Scaffold(
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("Mes Informations",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: vertForet),
                  ),
                ),
                // inputIdentifiant,
                //Nom complet
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Nom Complet"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: NomController,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Ex : yves Ladde',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),

                //email
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Adresse email"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Ex : yvesladde@gmail.com',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),

                //Telephone
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Telephone"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: TelephoneController,
                    keyboardType: TextInputType.phone,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Ex : 0778735784',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),

                //Adresse
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Adresse"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: adresse_producteurController,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Ex : Abidjan, Cocody rivera 3 ',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),

                //Identifiant
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Identifiant"),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    controller: identifiantController,
                    cursorColor: vertForet,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: vertForet,width: 1.5),
                        ),
                        hintText: 'Ex : yvesLadde123 ',
                        contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: vertForet),
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                  ),
                ),

                //Mot de passe
                Container(
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.centerLeft,
                  child:Text("Mot de passe"),
                ),
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

                chargement_en_cours(),

                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: ButtonTheme(
                    minWidth: 150,
                    height: 56,
                    child: RaisedButton(
                      child: Text(" Je m'enregistre  ", style: TextStyle(color: Colors.white, fontSize: 20)),
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
              ],
            ),
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
    var nom = NomController.text;
    var email = emailController.text;
    var telephone = TelephoneController.text;
    var adresse_producteur = adresse_producteurController.text;
    var identifiant = identifiantController.text;
    var password = passwordController.text;

    setState(() { chargement = true; });

    // Await the http get response, then decode the json-formatted response.
    if(nom.isEmpty || email.isEmpty || telephone.isEmpty || adresse_producteur.isEmpty || identifiant.isEmpty || password.isEmpty){
      _showToast(context,"Vous devez remplir tous les champs ci-dessus");
      setState(() {
        chargement = false;
      });

    }else{

         try{
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
           var id_producteur = sharedPreferences.get("id_producteur");
            var queryParameter = {
              'action': 'enregistrer_producteur',
              'nom': "$nom",
              'email': "$email",
              'adresse': "$adresse_producteur",
              'telephone': "$telephone",
              'identifiant': "$identifiant",
              'password': "$password",
            };

            var url = Uri.https("$adresse","$complement",queryParameter);

            print("************(###*&#(-------$url");
            var response = await http.get(url);

            if (response.statusCode == 200) {
              /*setState(() {
                NomController.text ="";
                emailController.text ="";
                TelephoneController.text ="";
                adresse_producteurController.text ="";
              });*/
              print("reponse : " + response.body);
              var jsonResponse = jsonDecode(response.body);
              print(jsonResponse['notif']);
              _showToast(context,"${jsonResponse['notif']}");

              if(jsonResponse['id_producteur']!='-1'){
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                sharedPreferences.setInt("id_producteur", int.parse(jsonResponse['id_producteur']));
                sharedPreferences.setString("nom_complet_producteur", nom);
                sharedPreferences.setString("email_producteur", email);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView()),
                );
              }

            }
            else {
              print('Echec de la requete code: ${response.statusCode}.');
              _showToast(context,"Echec de connexion... verifier votre connection et reesayer");
            }
        }catch(e){
          _showToast(context,"err -- $e-- Echec de connexion... verifier votre connection et reesayer");
           print('Echec de la requete code: $e.');
          // _showToast(context,"err -- Echec de connexion... verifier votre connection et reesayer");
        }


        setState(() {
          chargement = false;
        });


      }

  }

  //**************************************************************
  TextEditingController NomController = new TextEditingController();
  TextEditingController adresse_producteurController = new TextEditingController();
  TextEditingController TelephoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController identifiantController = new TextEditingController();

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

  chargement_en_cours() {
    if(chargement){
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text("Traitement en cours..."),
      );
    }else{
      return Text("");
    }

  }
}

