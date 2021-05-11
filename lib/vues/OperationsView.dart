import 'dart:convert';
import 'dart:io';

import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/chargement.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/constantes/menu_deroulant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class OperationsView extends StatefulWidget{

  String statut_operation;
  String type_operation;

  OperationsView(this.statut_operation,this.type_operation);

  @override
  _OperationsViewState createState() {
    // TODO: implement createState
    return new _OperationsViewState(statut_operation,type_operation);
  }

}

class _OperationsViewState extends State<OperationsView> {

  String statut_operation;
  String type_operation;
  _OperationsViewState(this.statut_operation,this.type_operation);

  int id_producteur =-1;
  String email_producteur="votre_adresse@email";
  String nom_complet_producteur="Votre Nom";
  bool chargement_en_cours = true;
  @override
  initState(){
    super.initState();
    this.recuperer_info_utilisateur().whenComplete(() async{
      this.recuperer_liste_operations(id_producteur);
    });
  }



  List liste_operations =[];
  var resultat =[];
  recuperer_liste_operations(id_producteur) async {
    // var url = Uri.https("$adresse:$port2","/operations/$id_producteur");

    try{

      var queryParameter = {
        'action': 'operations',
        'id_producteur': '$id_producteur',
        'statut': '$statut_operation',
      };

      // var url = Uri.https("$adresse:$port","/operations/$id_producteur");
      var url = Uri.https("$adresse","$complement",queryParameter);

      print("************(###*&#(-------$url");
      var response = await http.get(url);
      print("###--------------------------##");
      print(response.body);

      print(" route information $url ");

      setState(() {
        message_erreur_de_connexion = false;
        liste_operations = [];
        chargement_en_cours = true;
      });

      var reponse = await http.get(url);
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
    id_producteur = sharedPreferences.setInt(cle_operation,0);

    setState(() {
      liste_operations = resultat;
      chargement_en_cours = false;
    });
  }

  Future recuperer_info_utilisateur() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print(" id_producteur recuperer dans sharepreferences $id_producteur ");

    if(await sharedPreferences.get("id_producteur") !=null){
      setState(() {
        id_producteur = sharedPreferences.get("id_producteur");
        nom_complet_producteur = sharedPreferences.get("nom_complet_producteur");
        email_producteur = sharedPreferences.get("email_producteur");
      });

    }else{
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var front_statut = statut_operation.replaceAll('_',' ').toString().toUpperCase();
    return MaterialApp(
      theme: ThemeData(fontFamily: famille_par_defaut),
      title: 'Operations',
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
                      Text("$type_operation",style: TextStyle(fontSize: 16),),
                      IconButton(icon: Icon(Icons.refresh),
                          onPressed: (){
                            recuperer_liste_operations(id_producteur);
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
              choose_interface()
            ],
          ),
        ),
      ),
    );
  }
    var cash;
  //********************************************************methode******

  _showBottomModal(context,item_operation,date_formater) {
    (item_operation['commentaire'] ==null )? item_operation['commentaire'] ="-" : item_operation['commentaire']=item_operation['commentaire'];
    (item_operation['commentaire'] =="" )? item_operation['commentaire'] ="-" : item_operation['commentaire']=item_operation['commentaire'];
    var front_statut = item_operation['statut'].replaceAll('_',' ').toString().toUpperCase();
     if(item_operation['cash'] =='-'){
       cash = item_operation['cash'];
     }else{
       cash = " ${item_operation['cash']} FCFA";
     }

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
                          "${item_operation['titre']}",
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
                   height: MediaQuery.of(context).size.height * 0.45,
                  child: SingleChildScrollView(
                      child : Container(
                        constraints: BoxConstraints(
                            minHeight: 180
                        ),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          // color: vertForet,
                          border: Border(
                            top: BorderSide(
                              // color: const Color(0xfff8f8f8),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                constraints: BoxConstraints(
                                    minHeight: 170,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Desc : ${item_operation['description']} \n"),
                                    Text("Statut : $front_statut \n", style: TextStyle(fontWeight: FontWeight.bold),),
                                    SingleChildScrollView(
                                      child: RichText(
                                        textAlign: TextAlign.justify,
                                        text: statut_operation!='en_attente' ?
                                          TextSpan( text:"Commentaire : ${item_operation['commentaire']}",style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  wordSpacing: 1,
                                                ),
                                              )
                                          :TextSpan( text:"Commentaire : Contactez l'un des numeros suivants ( +225 25 22 00 81 02 / +225 01 40 15 15 90 ) pour signaler le depart de vos camions",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      wordSpacing: 1,
                                                    ),

                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(" Cash : $cash",style: TextStyle(fontSize: 12),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  onPressed: (){},
                                  color: item_operation['statut']=="paiement_effectuer" ? succesGreen : gris,
                                  child:  Text(front_statut,style:TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                 )
                ],
              ),
            ),

          );
        });
  }

  set_date(){
    return Container(
      child: TextField(
        // controller: passwordController,
        keyboardType: TextInputType.datetime,
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
    );
  }

  void _showToast(BuildContext context,String le_texte) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          content:  Text(le_texte,textAlign: TextAlign.center,style: TextStyle(color: Colors.amber),)
      ),
    );
  }

  liste_des_operation(){
    return Expanded(child: ListView.builder(
        itemCount: liste_operations.length,
        itemBuilder: (context,index){
          var item_operation = liste_operations[index];
          var date_formater = item_operation['timestamp'].toString();
          return Card(
            child: InkWell(
              onTap: (){ _showBottomModal(context,item_operation,date_formater); },
              child: Padding(
                padding: EdgeInsets.all(5),
                child:ListTile(
                    title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children : [
                          Text("${item_operation['titre']} | ${item_operation['description']} "),
                          Text(date_formater,style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold),),
                        ]
                    ),
                    trailing: Container(
                      child: Image.asset("assets/icones_operation/${item_operation['statut']}.png", width: 25),
                    )
                ),
              ),
            ),

          );
        }
    ));
  }

  Widget choose_interface(){
    if(chargement_en_cours){
      return ChargementView();
    }else{
      return liste_des_operation();
    }
  }



}

