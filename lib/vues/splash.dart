
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:kpn_confort_plan/constantes/constantes.dart';
import 'package:kpn_confort_plan/vues/DashboardView.dart';
import 'package:kpn_confort_plan/vues/OperationsView.dart';
import 'package:kpn_confort_plan/vues/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() {
    // TODO: implement createState
    return new _SplashViewState();
  }

}
class _SplashViewState extends State<SplashView> {

  @override
  initState(){
    super.initState();

    new Future.delayed(const Duration(seconds: 3), () {
      this.checkIfLogged();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash View',
      home:Scaffold(
        appBar: null,
        body: Builder(
          builder: (context) => Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png",),
                Text("CONFORT PLAN",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: vertForet),
                  ),
            ],
          )
        ),
      ),
    ),
    );
  }

  checkIfLogged() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.get(cle_id_producteur);
    print("-------------------------- $id");
    if(id != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardView()),);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeView()),);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginView()),);
    }
  }

}

