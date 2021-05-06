import 'dart:convert';

import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/chargement.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/constantes/menu_deroulant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class InformationView extends StatefulWidget{
  @override
  _InformationViewState createState() {
    // TODO: implement createState
    return new _InformationViewState();
  }

}

class _InformationViewState extends State<InformationView> {



  int id_producteur =500;
  String email_producteur="votre_adresse@email";
  String nom_complet_producteur="Votre Nom";
  bool chargement_en_cours = true;


  @override
  initState(){
    super.initState();
    this.recuperer_info_utilisateur().whenComplete(() async{
      this.recuperer_liste_informations(id_producteur);
    });

  }
  List liste_informations =[];
  var resultat =[];

  recuperer_liste_informations(id_producteur) async {
      setState(() {
        message_erreur_de_connexion = false;
        liste_informations = [];
        chargement_en_cours = true;
      });

      try{
          // var url = Uri.https("$adresse:$port2","/informations/$id_producteur");
          // var url = Uri.https("$adresse:$port","/informations/$id_producteur");

        var queryParameter = {
          'action': 'informations',
          'id_producteur': '$id_producteur',
        };

        // var url = Uri.https("$adresse:$port","/operations/$id_producteur");
        var url = Uri.https("$adresse","$complement",queryParameter);

          var reponse = await http.get(url);
          // print( " corps du resultat " + reponse.body);
           resultat = json.decode(reponse.body);
          print( "----------------");

      }catch(e){
          print("erreur de connexion");
          setState(() {
            message_erreur_de_connexion = true;
          });
          return false;
      }


      //on a tous recuperer il est cense tout lire donc on remet a 0
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      id_producteur = sharedPreferences.setInt(cle_info,0);

    // print(resultat);
      setState(() {
        liste_informations = resultat;
        chargement_en_cours = false;
      });
  }


  Future recuperer_info_utilisateur() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.get("id_producteur") !=null){
      setState(() {
        id_producteur = sharedPreferences.get("id_producteur");
        nom_complet_producteur = sharedPreferences.get("nom_complet_producteur");
        email_producteur = sharedPreferences.get("email_producteur");
      });
    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InformationView()),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: famille_par_defaut),
      title: 'Informations',
      
      home:Scaffold(
        appBar: BarreDeMenu(context),
        drawer: menu_deroulant(context,nom_complet_producteur,email_producteur),
        body: Builder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: vertForet,
                  padding: EdgeInsets.all(10),
                  child : Row(
                    children: [
                      Text("Historique des informations",style: TextStyle(fontSize: 16),),
                      IconButton(icon: Icon(Icons.refresh),
                          onPressed: (){
                            recuperer_liste_informations(id_producteur);
                          }
                      ),
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text("selectable field"),
                ],
              ),

              choose_interface(),
            ],
          ),
        ),
      ),
    );
  }

  //********************************************************methode******

  _showBottomModal(context,item_information,date_formater) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return new Container(
            // height: 800,
            color: Colors.transparent,
            child:  new Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0, // has the effect of softening the shadow
                      spreadRadius: 0.0, // has the effect of extending the shadow
                    )
                  ],
                ),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Text(
                            "${item_information['titre']}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5, right: 5),
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff999999),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      constraints: BoxConstraints(
                        minHeight: 180
                      ),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        // color: vertForet,
                        border: Border(
                          top: BorderSide(
                            color: const Color(0xfff8f8f8),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxHeight: 170,
                                minWidth: MediaQuery.of(context).size.width * 1
                            ),
                            padding: EdgeInsets.all(8),
                            // color: vertForet,
                            decoration: BoxDecoration(
                              // color: vertForet,
                              border: Border(
                                right: BorderSide(
                                  color: gris,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  text:"${item_information['description']}",
                                  // text:"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black,
                                    wordSpacing: 1,
                                  ),

                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             FlatButton(
                               onPressed: (){},
                               color: gris,
                               child:  Text(date_formater,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
                             )
                           ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

          );
        });
  }

  _showToast(BuildContext context,String le_texte) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          content:  Text(le_texte,textAlign: TextAlign.center,style: TextStyle(color: Colors.amber),)
      ),
    );
  }


  Widget choose_interface(){
    if(chargement_en_cours){
      return ChargementView();
    }else{
      return liste_des_informations();
    }
  }


  liste_des_informations(){
    return Expanded(child: ListView.builder(
        itemCount: liste_informations.length,
        itemBuilder: (context,index){
          var item_information = liste_informations[index];
          var date_formater = item_information['timestamp'].toString();
          return Card(
            child: InkWell(
              onTap: (){ _showBottomModal(context,item_information,date_formater); },
              child: Padding(
                padding: EdgeInsets.all(5),
                child:ListTile(
                    title: Text(item_information['titre']),
                    trailing: Container(
                      child:  FlatButton(
                        onPressed: (){},
                        color: gris,
                        child: Text(date_formater,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
                      ),
                    )
                ),
              ),
            ),

          );
        }
    ));
  }
}

