import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:workmanager/workmanager.dart';

import 'package:kpn_confort_plan/vues/splash.dart';
import 'constantes/constantes.dart';

/*
void callbackDispatcher() {

  Workmanager.executeTask((task, inputData) async {
    if (task == 'kpn_confort_plan_uniqueKey') {
        await recupererLeNombreDeNotifications();
    }
    return Future.value(true);
  });
}
*/

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
  final MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode:
      false);

  Workmanager.registerPeriodicTask(
    "kpn_confort_plan_uniqueName",
    "kpn_confort_plan_uniqueKey",
    frequency: Duration(minutes: 15),
  );*/
  runApp(MyApp());
}

/*Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

mettreAjourInfo(nb_info,nb_operation) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setInt(cle_info,nb_info);
  sharedPreferences.setInt(cle_operation,nb_operation);

  var info = sharedPreferences.get("information_non_lu");
  var op = sharedPreferences.get("operations_non_lu");

  print("****** info = ${info.toString()}  ***** operation = ${op.toString()} ");
}


recupererLeNombreDeNotifications() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var id_producteur = sharedPreferences.get(cle_id_producteur);
  print("the id = $id_producteur");

  if(id_producteur!=null){
      try{

        // var url = Uri.https("$adresse:$port","/get-notif-number/$id_producteur");

        var queryParameter = {
          'action': 'get-notif-number',
          'id_producteur': '$id_producteur',
        };

        var url = Uri.https("$adresse","$complement",queryParameter);

            var response = await http.get(url);
            Map dataComingFromTheServer = json.decode(response.body);
            print("###----11-------- $dataComingFromTheServer");
            print("###----data-------- ${dataComingFromTheServer['data']['op_non_lu']} operations -- ${dataComingFromTheServer['data']['info_non_lu']} informations-- ");

            var nb_operation_non_lu = dataComingFromTheServer['data']['op_non_lu'];
            var nb_informations_non_lu =dataComingFromTheServer['data']['info_non_lu'];
            await mettreAjourInfo(nb_informations_non_lu,nb_operation_non_lu);

            var contenu_information ="";
            var contenu_operation ="";

            if(nb_informations_non_lu > 0){
              print("to string 1-- ookk");
              contenu_information = "${nb_informations_non_lu.toString()} nouvelle(s) information(s)";
            }

            if(nb_operation_non_lu>0){
              contenu_operation = "${nb_operation_non_lu.toString()} nouvelle(s) operation(s)";
            }

            var titre = "ACTIVITE SUR CONFORT PLAN";
            var contenu = " $contenu_operation \n$contenu_information ";

            final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
            const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails('kpn_confort_plan_id', 'kpn_confort_plan_name',
              'kpn_confort_plan_description',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false,
              styleInformation: BigTextStyleInformation(''),
            );

            const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

            var nb_nouvelle_infos = nb_informations_non_lu + nb_operation_non_lu;
            print("0000000---------------------$nb_nouvelle_infos---------------");
            if( nb_nouvelle_infos> 0){
              await flutterLocalNotificationsPlugin.show(
                  0,
                  titre,
                  contenu,
                  platformChannelSpecifics,
                  payload: 'item x'
              );
            }
            print("to string 1--");
              contenu_information = " ${nb_informations_non_lu.toString()} nouvelle(s) informations";

      }catch(e){
          print("--------error----------------- $e --------------------");
      }
  }else{
    print("l'id es null");
  }
}*/

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();

}

class MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(fontFamily: famille_par_defaut),
      home: SplashView(),
    );
  }

}


/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RaisedButton(
            onPressed: (){
              recupererLeNombreDeNotifications();
            },
            child: Text("'Testing Notification in Background'"),
        ),
      ),
    );
  }
}
*/


