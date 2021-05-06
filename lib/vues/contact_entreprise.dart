import 'package:kpn_confort_plan/constantes/barre_de_menu.dart';
import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactEntrepriseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: vertForetTransparent,
      // appBar:BarreDeMenu(context),
      appBar: AppBar(
        title: Text("A Propos de Nous",style: TextStyle(color: Colors.white),),
        backgroundColor: vertForet,
      ),
      body: SafeArea(
        child :  Center(
          child: SingleChildScrollView(
           child: Container(
             // height: 400,
             margin: EdgeInsets.all(10),
             decoration: BoxDecoration(
                 color: vertForet,
                 borderRadius: BorderRadius.circular(10.0),
                 boxShadow: [
                 BoxShadow(
                   color: vertForetTransparent,
                   offset: Offset(10.0, 10.0), //(x,y)
                   blurRadius: 6.0,
                 ),
             ]
            ),
             child: Center(
               child : Padding(
                 padding: EdgeInsets.all(8),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     CircleAvatar(
                       radius: 55,
                       backgroundColor: Color(0xffFDCF09),
                       child: CircleAvatar(
                         radius: 50,
                         backgroundImage: AssetImage('assets/images/logo.png'),
                       ),
                     ),
                     SizedBox(height: 10,),
                     Text("Kpn Visa Digital Expert",style: TextStyle(color: blanc,fontSize: 18),),
                     SizedBox(height: 15,),
                     Text(
                       "Entreprise ivoirienne avec 5 annees d'experience ouvre un pod Agriculture pour offrir au producteur  "
                           "la possiblité d'ecoulé leur stock beaucoup plus facilement! \n Vous etes interesse ? Contactez-nous"
                       ,style: TextStyle(color: blanc,fontSize: 18),textAlign: TextAlign.center,
                     ),
                     SizedBox(height: 15,),
                     Text("+225 25 22 00 81 02",style: TextStyle(color: blanc,fontSize: 18),),
                     Text("+225 01 40 15 15 90",style: TextStyle(color: blanc,fontSize: 18),),
                     SizedBox(height: 5,),
                     Text("kpnvisa@gmail.com",style: TextStyle(color: blanc,fontSize: 18),),
                     SizedBox(height: 15,),
                     InkWell(
                         child: Text("Visiter notre page facebook",style: TextStyle(color: blanc,fontSize: 18),),
                         onTap: () => launch('https://www.facebook.com/kpnvisadigitalexpert/')
                     ),
                     SizedBox(width: 55,),

                   ],
                 ),
               ),
             ),
           ),
          )
            )
        ),
    );
  }
}