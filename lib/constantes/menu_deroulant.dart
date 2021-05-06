import 'package:kpn_confort_plan/vues/DashboardView.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/InformationView.dart';
import 'package:kpn_confort_plan/vues/contact_entreprise.dart';
import 'package:kpn_confort_plan/vues/explication_projet.dart';
import 'package:flutter/material.dart';
import 'package:kpn_confort_plan/vues/new_operation.dart';

import 'constantes.dart';
import 'se_deconnecter.dart';

menu_deroulant (context,nom_complet_producteur,email_producteur){
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: vertForet,
          ),
          accountName: Text(nom_complet_producteur),
          accountEmail: Text(email_producteur),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(nom_complet_producteur[0].toString().toUpperCase(),style: TextStyle(color: vertForet)),
          ),
          otherAccountsPictures: [
            CircleAvatar(
              backgroundColor: Colors.white,
              // child: Text("Logo",style: TextStyle(color: vertForet),),
              child: Image.asset("assets/images/logo.png",width: 50,),
            )
          ],
        ),
        ListTile(
          title: Text("Tableau de bord"),
          trailing: Icon(Icons.home),
          onTap: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardView()),
          );
        },
        ),
        ListTile(
          title: Text("Commencer une livraison"),
          trailing: Icon(Icons.arrow_circle_up_sharp),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewOperation()),
            );
          },
        ),
        ListTile(
          title: Text("Informations"),
          trailing: Icon(Icons.notifications_active_outlined),
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InformationView()),
            );
          },
        ),
        ListTile(
          title: Text("A propos de CONFORT PLAN"),
          trailing: Icon(Icons.help),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExplicationView()),
            );
          },
        ),
        ListTile(
          title: Text("Contactez Nous"),
          trailing: Icon(Icons.support_agent_outlined),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactEntrepriseView()),
            );
          },
        ),
        ListTile(
          title: Text("Se deconnecter"),
          trailing: Icon(Icons.logout),
          onTap: (){
            se_deconnecter(context);
          },
        ),
      ],
    ),
  );
}

