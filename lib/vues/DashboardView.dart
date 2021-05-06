import 'dart:convert';

import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/constantes/menu_deroulant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/login.dart';
import 'package:kpn_confort_plan/vues/new_operation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() {
    // TODO: implement createState
    return new _DashboardViewState();
  }
}

class _DashboardViewState extends State<DashboardView> {
  int id_producteur = 500;
  String email_producteur = "votre_adresse@email";
  String nom_complet_producteur = "Votre Nom";
  bool cahrgement_en_cours = false;
  bool probleme_avec_la_requete = false;

  @override
  initState() {
    super.initState();
    this.recuperer_info_utilisateur().whenComplete(() async{
      this.recuperer_info_dashboard(context,id_producteur);
    });
  }

  Items item_attente = new Items(
    title: "Livraisons non debutées",
    valeur: "0",
    img: "assets/icones_operation/en_attente.png",
    route: OperationsView('en_attente','Livraisons non debutées'),
  );
  Items item_en_cours = new Items(
      title: "Livraisons en cours",
      valeur: "0",
      img: "assets/icones_operation/camion_charger.png",
      route: OperationsView('livraison_en_cours','Livraisons en cours'),
  );

  Items item_recue = new Items(
    title: "Livraisons reçue",
    valeur: "0",
    img: "assets/icones_operation/recolte_peser.png",
    route: OperationsView('livraison_effectuer','Livraisons reçues'),
  );
  Items item_maluce = new Items(
    title: "Maluces",
    valeur: "0",
    img: "assets/icones_operation/maluces.png",
    route: OperationsView('maluces','Maluces'),
  );
  Items item_disponible = new Items(
    title: "Cash Disponible",
    valeur: "0",
    img: "assets/icones_operation/paiement_disponible.png",
    route: OperationsView('paiement_disponible','Cash disponible'),
  );
  Items item_retirer = new Items(
    title: "Cash Retirer",
    valeur: "0",
    img: "assets/icones_operation/paiement_effectuer.png",
    route: OperationsView('paiement_effectuer','Cash Retirer'),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item_attente, item_en_cours, item_recue, item_maluce, item_disponible, item_retirer];
    return MaterialApp(
      theme: ThemeData(fontFamily: famille_par_defaut),
      title: 'Tableau de bord',
      home: Scaffold(
        // appBar: BarreDeMenu(context),
        drawer: menu_deroulant(context, nom_complet_producteur, email_producteur),
        body: Builder(
            builder: (context) => SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(25),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Image.asset("assets/images/logo.png", height: 60,),
                          ],
                        ) ,
                      ),
                      SizedBox(
                      height: 30,
                    ),
                      Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewOperation()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width *1,
                            decoration: BoxDecoration(
                                color: vertForetTransparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/icones_operation/commencer.png",
                                  width: 42,
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  " Commencer une livraison ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.count(
                            childAspectRatio: 1.0,
                            padding: EdgeInsets.only(left: 16, right: 16),
                            crossAxisCount: 3,
                            crossAxisSpacing: 18,
                            mainAxisSpacing: 18,
                            children: myList.map((data) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> data.route ));
                                },
                               child: Container(
                                 decoration: BoxDecoration(
                                     color: vertForetTransparent,
                                     borderRadius: BorderRadius.circular(10)),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     Image.asset(
                                       data.img,
                                       width: 30,
                                     ),
                                     SizedBox(height: 5,),
                                     Text( data.title, textAlign: TextAlign.center, style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 10,
                                         fontWeight: FontWeight.w600),
                                     ),
                                     SizedBox(height: 5,),
                                     Text(data.valeur, style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 16,
                                         fontWeight: FontWeight.w600)),
                                   ],
                                 ),
                               ),
                              );
                            }).toList()),
                      ),
                      cahrgement_en_cours ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          color: gris,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Chargement en cours...")
                              )
                          )
                      ): SizedBox(height: 0,),
                      probleme_avec_la_requete ? Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          color: gris,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Probleme de connexion",
                                        style: TextStyle(
                                            color: rougeGraine, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      ),
                                      InkWell(
                                        child: RaisedButton(child:Text("rééssayer",style: TextStyle(color: blanc),),onPressed: null,),
                                        onTap: () {
                                          recuperer_info_dashboard(context, id_producteur);
                                        },
                                      ),
                                    ],
                                  )))) : SizedBox(height: 0,),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          color: vertForet,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Icon(
                                          Icons.menu,
                                          color: blanc,
                                        ),
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                      ),
                                      Text(
                                        "Bienvenue $nom_complet_producteur",
                                        style: TextStyle(
                                            color: blanc, fontSize: 13),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  )))),
                    ],
                  ),
                )),
      ),
    );
  }



//********************************************************methode******
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

  Future<void> recuperer_info_dashboard(context,int id_producteur) async {

    setState(() {
      probleme_avec_la_requete = false;
      cahrgement_en_cours = true;
    });
    
      try{
        var queryParameter = {
          'action': 'dashboard',
          'id_producteur': '$id_producteur',
        };

        // var url = Uri.https("$adresse:$port","/operations/$id_producteur");
        var url = Uri.https("$adresse","$complement",queryParameter);

        print("************(###*&#(-------$url");
        var reponse = await http.get(url);

        if(reponse.statusCode==200){
          print(reponse.body);
          var resultat = json.decode(reponse.body);

          print(" 00web response == $resultat");
          setState(() {
            cahrgement_en_cours =false;
            item_attente.valeur = resultat['en_attente'];
            item_en_cours.valeur = resultat['livraison_en_cours'];
            item_recue.valeur = resultat['livraison_effectuer'];
            item_maluce.valeur = resultat['maluces'];
            item_disponible.valeur = resultat['paiement_disponible'];
            item_retirer.valeur = resultat['paiement_effectuer'];
          });

        }else{
          setState(() {
            cahrgement_en_cours =false;
            probleme_avec_la_requete = true;
          });
        }
      }catch(e){
        print("erreur de connexion");
        print("err -- $e");
        setState(() {
          cahrgement_en_cours =false;
          probleme_avec_la_requete = true;
        });
        return false;
      }
  }



}



class Items {
  String title;
  String valeur;
  String img;
  var route;

  Items({this.title, this.valeur, this.img, this.route});
}
