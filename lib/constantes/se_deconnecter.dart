import 'package:kpn_confort_plan/vues/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

se_deconnecter(context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove("id_producteur");
  sharedPreferences.remove("nom_complet_producteur");
  sharedPreferences.remove("email_producteur");

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => SplashView()),
  );
}