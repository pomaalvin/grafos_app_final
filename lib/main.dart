import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:flutter/gestures.dart';
void main(){
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }

}

class _MyApp extends State<MyApp>{
  LangawGame game;
  @override
  void iniciar()async{

    WidgetsFlutterBinding.ensureInitialized();
    game=new LangawGame(context);
    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
    HorizontalDragGestureRecognizer hdr=HorizontalDragGestureRecognizer();
    
    Flame.util.addGestureRecognizer(hdr
    ..onUpdate=(startDetails)=>game.ondragstart(startDetails.globalPosition)
    );
    Flame.util..addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown=(TapDownDetails tapdetails)=>game.onTapDon(tapdetails.globalPosition)
    );
  }
  void initState() {
    iniciar();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body: game.widget!=null?game.widget:Container(),
    );
  }
}

