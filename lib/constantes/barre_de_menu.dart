import 'package:flutter/material.dart';
import 'package:kpn_confort_plan/vues/DashboardView.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/InformationView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constantes.dart';
import 'se_deconnecter.dart';
import 'package:kpn_confort_plan/main.dart';

var info_non_lu =0;
var op_non_lu =0;


BarreDeMenu(context){
  recupererLeNombreDeNotifNonLu();
  return AppBar(
    backgroundColor: vertForet,
    title: Padding(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Text('Confort plan',style: TextStyle(fontSize: 17),),
    ),
    actions: <Widget>[
        //operation
         /* Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IconButton(
                  icon: Icon(Icons.transit_enterexit,size: 25 ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeView()),);
                  },
                ),
                op_non_lu > 0 ? bouttonDorer(op_non_lu) : Text(""),
              ],
            )
          ),*/
      //information
          /*Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_active_outlined,size: 25 ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => InformationView()),);
                  },
                ),
                info_non_lu>0 ? bouttonDorer(info_non_lu) : Text(""),
              ],
            )
          ),*/
      //dashboard
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                IconButton(
                  icon: Icon(Icons.home,size: 25 ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardView()),);
                  },
                ),
                info_non_lu>0 ? bouttonDorer(info_non_lu) : Text(""),
              ],
            )
          ),

      //deconnexion
          Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              IconButton(
                icon: Icon(Icons.logout,size: 25,),
                onPressed: () {
                  se_deconnecter(context);
                },
              ),
            ],
          )
      ),
    //   RaisedButton(
    //         onPressed: (){
    //           recupererLeNombreDeNotifications();
    //         },
    //         child: Text("tn"),
    //       )
    ],
  );
}

Widget bouttonDorer(nb) {
  return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dorer
      ),
    child: Text("$nb",textAlign: TextAlign.center,),
  );
}


recupererLeNombreDeNotifNonLu() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  info_non_lu = sharedPreferences.get(cle_info);
  if(info_non_lu == null){
    info_non_lu=0;
    sharedPreferences.setInt(cle_info,0);
  }

  op_non_lu = sharedPreferences.get(cle_operation);
  if(op_non_lu == null){
    op_non_lu=0;
    sharedPreferences.setInt(cle_operation,0);
  }

  print("##info == $info_non_lu  ### opertion $op_non_lu)");
}
