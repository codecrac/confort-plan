import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';

class ExplicationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: null,
      // appBar: AppBar(
      //   title: Text("",style: TextStyle(color: Colors.white),),
      //   backgroundColor: vertForet,
      // ),
      body: SafeArea(
        child: Center(
          // child: ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("LE PROJET CONFORT PLAN", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(
                        "Le Palmier à Huile est une filière très importante dans le développement économique de la Côte d’Ivoire."
                            "Cependant, nous constatons que les planteurs de palmiers à huile rencontre de nombreux problèmes (productivité et financiers)."
                            "Dans le souci d’aider les planteurs dans leur quotidien, KPN VISA DIGITAL EXPERT, invite tous les planteurs de la zone de l’Agnéby à rejoindre son réseau."
                    ),
                    SizedBox(height: 10,),
                    Text("COMBIEN DEVRONT PAYER LES PLANTEURS POUR ADHERER ?", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(
                        "Le Palmier à Huile est une filière très importante dans le développement économique de la Côte d’Ivoire."
                            "Cependant, nous constatons que les planteurs de palmiers à huile rencontre de nombreux problèmes (productivité et financiers)."
                            "Dans le souci d’aider les planteurs dans leur quotidien, KPN VISA DIGITAL EXPERT, invite tous les planteurs de la zone de l’Agnéby à rejoindre son réseau."
                    ),
                    SizedBox(height: 10,),
                    Text("QUELS AUTRES INTERETS ONT LES PLANTEURS D’ADHERER AU RESEAU DE KPN VISA DIGITAL EXPERT ?", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(
                        "Dès que les planteurs adhèrent au réseau, il sera mis à leur disposition un expert du domaine qui les aidera à :"
                            "Améliorer leurs plants,"
                            "Mettre en place de bonnes pratiques culturales,"
                            "Augmenter leurs productivités."
                    ),
                    SizedBox(height: 10,),
                    Text("Y’A-T-IL UN BONUS POUR LES PLANTEURS QUI FERONT ENTRER D’AUTRES PLANTEURS DANS LE RESEAU ?", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(
                        "Oui."
                            "Tout planteur qui fera entrer un ou plusieurs autres planteurs dans le réseau (une fois que la production de ces derniers est supérieure ou égale à 50 tonnes) aura comme prix d’achat de sa production : le prix national (AIPH) + 1 000 F et même jusqu’à plus 5 000 F. En plus ce planteur bénéficiera aussi de l’engrais de très bonne qualité."
                    ),
                    SizedBox(height: 5,),
                  ],
                )
            ),
          ),
        ),
      )
      // ),
    );
  }
}