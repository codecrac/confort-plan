import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constantes.dart';

bool message_erreur_de_connexion =false;

ChargementView(){
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: message_erreur_de_connexion ?
                  Container(
                    padding: EdgeInsets.all(10),
                    color: gris,
                    child: Text("Echec... verifier votre connexion internet ",style: TextStyle(color: rougeGraine),) ,
                  ) :
                  Text(" Chargement en cours... ")

    )
  );
}