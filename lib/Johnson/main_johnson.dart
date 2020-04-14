import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:flutter/gestures.dart';
import 'package:grafos/Johnson/grafos_john.dart';
class Main_john extends StatefulWidget{
  LangawGame gameant;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Main_john(gameant);
  }
  Main_john(this.gameant);

}

class _Main_john extends State<Main_john>{
 Johnson game;
 LangawGame gameant;
 _Main_john(this.gameant);
  @override
  void iniciar()async{

    WidgetsFlutterBinding.ensureInitialized();
    game=new Johnson(context);
    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  }
  void initState() {
    iniciar();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    Size ScreenSize=MediaQuery.of(context).size;
    return Scaffold(
      body:

      GestureDetector(
        onTapDown: (d){
          game.onTapDon(d.globalPosition);
        },
        onHorizontalDragUpdate: (d){
          game.ondragstart(d.globalPosition);
        },
        child: Container(
          height: ScreenSize.height,
          width: ScreenSize.width,
          child:ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                  height: ScreenSize.height/10,
                  width: ScreenSize.width,
                  color: Color(0xff323031),
                  child: Row(
                    children: <Widget>[
                      Container(

                          width:ScreenSize.width*0.8,
                          child: Center(child: Text("Johnson",style: TextStyle(color: Colors.white,fontFamily: 'CenturyGothic',fontSize: ScreenSize.width*0.05),),
                          )
                      ),
                      Container(
                        width:ScreenSize.width*0.2,
                        padding: EdgeInsets.only(left: (ScreenSize.width*0.2-ScreenSize.width/9)/2,right: (ScreenSize.width*0.2-ScreenSize.width/9)/2),

                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            gameant.bloqueototal=false;
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                          minWidth: ScreenSize.width/9,
                          height: ScreenSize.width/9,
                          color: Color(0xffFFC857),
                          child: Center(heightFactor: 1,child: Icon(Icons.keyboard_backspace,color: Color(0xff323031),),),
                        ),
                      )
                    ],
                  )
              ),
              Container(
                height: ScreenSize.height*0.9,
                width: ScreenSize.width,
                child: Scaffold(
                  body: game.widget!=null?game.widget:Container(child: Text("Cargando")),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

