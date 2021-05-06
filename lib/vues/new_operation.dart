
import 'dart:convert';

import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/explication_projet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NewOperation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => NewOperationState();

}

class NewOperationState extends State<NewOperation> {

  bool chargement = false;
  String statut = 'livraison_en_cours';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BarreDeMenu(context),
      body:Scaffold(
        body: Builder(
          builder: (context) => SafeArea(
              child: SingleChildScrollView(
                  child:Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children:[
                              Image.asset("assets/images/logo.png",height: 42,),
                            ],
                          ) ,
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Nouvelle Livraison",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: vertForet),
                          ),
                        ),
                        // inputIdentifiant,
                        chargement_en_cours(),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child:Text("Quel est votre offre ?"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: TextField(
                            controller: OffreController,
                            cursorColor: vertForet,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: vertForet,width: 1.5),
                                ),
                                hintText: '15 Tonnes de palmier à huile',
                                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: vertForet),
                                    borderRadius: BorderRadius.circular(10.0)
                                )
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.centerLeft,
                          child:Text("Le camion est-il deja en direction de l'usine ? "),
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'livraison_en_cours',
                              groupValue: statut,
                              onChanged: (nw_statut){
                                setState(() {
                                  statut=nw_statut;
                                });
                                print('#---- $statut');
                              },
                            ),
                            Text(" Oui, Le camion est en route pour l'usine.")
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 'en_attente',
                              groupValue: statut,
                              onChanged: (nw_statut){
                                setState(() {
                                  statut=nw_statut;
                                });
                                print('#---- $statut');
                              },
                            ),
                            Text(" Non,Le camion n'a pas encore demmaré.")
                          ],
                        ),

                        //bouton
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: ButtonTheme(
                            minWidth: 150,
                            height: 56,
                            child: RaisedButton(
                              child: Text(' Enregistrer l\'operation ', style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  )
              )
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
    var offre = OffreController.text;

    setState(() { chargement = true; });

    // Await the http get response, then decode the json-formatted response.
    if(offre.isEmpty){
      _showToast(context,"Vous devez remplir le champ ci-dessus");
      setState(() {
        chargement = false;
      });

    }else{

         try{
           SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
           var id_producteur = sharedPreferences.get("id_producteur");
            var queryParameter = {
              'action': 'nouvelle_operation',
              'offre': "$offre",
              'id_producteur': "$id_producteur",
              'statut': "$statut",
            };

            var url = Uri.https("$adresse","$complement",queryParameter);
            print("offre : $offre");

            print("************(###*&#(-------$url");
            var response = await http.get(url);

            if (response.statusCode == 200) {
              setState(() {
                OffreController.text ="";
              });
              print("reponse : " + response.body);
              var jsonResponse = jsonDecode(response.body);
              print(jsonResponse['notif']);
              _showToast(context,"${jsonResponse['notif']}");
            }
            else {
              print('Echec de la requete code: ${response.statusCode}.');
              _showToast(context,"Echec de connexion... verifier votre connection et reesayer");
            }
        }catch(e){
          // _showToast(context,"err -- $e-- Echec de connexion... verifier votre connection et reesayer");
           print('Echec de la requete code: $e.');
          _showToast(context,"err -- Echec de connexion... verifier votre connection et reesayer");
        }


        setState(() {
          chargement = false;
        });


      }

  }

  //**************************************************************
  TextEditingController OffreController = new TextEditingController();
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

  chargement_en_cours() {
    if(chargement){
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text("Enregistrement en cours..."),
      );
    }else{
      return Text("");
    }

  }
}

