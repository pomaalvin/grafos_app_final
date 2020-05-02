import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:flutter/gestures.dart';
import 'package:grafos/Johnson/main_johnson.dart';
class Grafos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Grafos();
  }

}

class _Grafos extends State<Grafos>{
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
  Size ScreenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
                    child: Center(child: Text("Grafos",style: TextStyle(color: Colors.white,fontFamily: 'CenturyGothic',fontSize: ScreenSize.width*0.05),),
                        )
                  ),
                  Container(
                    width:ScreenSize.width*0.2,
                    padding: EdgeInsets.only(left: (ScreenSize.width*0.2-ScreenSize.width/9)/2,right: (ScreenSize.width*0.2-ScreenSize.width/9)/2),

                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        game.bloqueototal=true;
                        Navigator.push(context,MaterialPageRoute(builder: (BuildContext context){
                            return Main_john(game);
                        }));
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                      minWidth: ScreenSize.width/9,
                      height: ScreenSize.width/9,
                      color: Color(0xff084C61),
                      child: Center(heightFactor: 1,child: Icon(Icons.grain,color: Colors.white,),),
                    ),
                  )
                ],
              )
            ),
            Container(
              height: ScreenSize.height*0.9,
             child: game.widget!=null?game.widget:Container(child: Text("Cargando")),
            )
          ],
        ),
      ),
    );
  }
}

