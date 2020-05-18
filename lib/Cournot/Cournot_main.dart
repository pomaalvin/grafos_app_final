import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafos/Cournot/Cournot_graph.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:flutter/gestures.dart';
import 'package:grafos/Johnson/grafos_john.dart';
import 'package:grafos/componentes/Nodo_Arbol.dart';
import 'package:zoom_widget/zoom_widget.dart';
class Main_Cournot extends StatefulWidget{
  @override

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Main_Cournot(lista);
  }

  List<List<double>> lista;
  Main_Cournot(this.lista);

}

class _Main_Cournot extends State<Main_Cournot>{
  Cournot_graph game;
  List<Nodo_Arbol> nodosl;
  List<Nodo_Arbol> pila1;
  ScrollController listc;
  List<List<double>> lista;
  List<double> medioR=List();
  _Main_Cournot(this.lista);
  @override
  void iniciar()async{
    WidgetsFlutterBinding.ensureInitialized();
    game=new Cournot_graph(context,lista);

    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  }
  void initState() {

    iniciar();
    listc=ScrollController(initialScrollOffset: 250);
    if(listc.hasClients){
    }
  }
  void sacarPunto(){
    List<List<double>> medios=List();
    for(int i=0;i<lista.length-1;i++){
      double xm=(lista[i][0]+lista[i+1][0])/2;
      double ym=(lista[i][1]+lista[i+1][1])/2;
      medios.add([xm,ym]);
    }
    double xm=(lista[lista.length-1][0]+lista[0][0])/2;
    double ym=(lista[lista.length-1][1]+lista[0][1])/2;
    medios.add([xm,ym]);
    while(true)
      {
        print(medios);
        int c=0;
        for(int i=1;i<medios.length;i++){
          if(medios[i][0].toStringAsExponential(2)==medios[i-1][0].toStringAsExponential(2)&&medios[i-1][1].toStringAsExponential(2)==medios[i][1].toStringAsExponential(2)){
            c++;
          }
        }
        if(c==medios.length-1){
          break;
        }
        List<List<double>> auxme=List();
        for(int i=0;i<medios.length-1;i++){
          double xm=(medios[i][0]+medios[i+1][0])/2;
          double ym=(medios[i][1]+medios[i+1][1])/2;
          auxme.add([xm,ym]);
        }
        double xm=(medios[medios.length-1][0]+medios[0][0])/2;
        double ym=(medios[medios.length-1][1]+medios[0][1])/2;
        auxme.add([xm,ym]);

        medios=auxme;
      }
      setState(() {
        game.anadirmedio(medios[0]);
        medioR=medios[0];

      });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    Size ScreenSize=MediaQuery.of(context).size;
    return Scaffold(
        body:Container(
            height: ScreenSize.height,
            width: ScreenSize.width,
            child:ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                    height: ScreenSize.height/10,
                    width: ScreenSize.width,
                    color: Colors.blueGrey,
                    child: Row(
                      children: <Widget>[
                        Container(

                            width:ScreenSize.width*0.8,
                            child: Center(child: Text("Nash/Cournot",style: TextStyle(color: Colors.white,fontFamily: 'CenturyGothic',fontSize: ScreenSize.width*0.035),),
                            )
                        ),
                        Container(
                          width:ScreenSize.width*0.2,
                          padding: EdgeInsets.only(left: (ScreenSize.width*0.2-ScreenSize.width/9)/2,right: (ScreenSize.width*0.2-ScreenSize.width/9)/2),

                          child: MaterialButton(
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                            minWidth: ScreenSize.width/9,
                            height: ScreenSize.width/9,
                            color: Colors.green,
                            child: Center(heightFactor: 1,child: Icon(Icons.keyboard_backspace,color: Color(0xff323031),),),
                          ),
                        )
                      ],
                    )
                ),
                Container(
                  color: Colors.white,
                  height: ScreenSize.height/10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width:ScreenSize.width*0.6,
                        padding: EdgeInsets.all(0.6),
                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            sacarPunto();
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                          minWidth: ScreenSize.width/9,
                          height: ScreenSize.width/9,
                          color: Color(0xff1BB377),
                          child: Center(heightFactor: 1,child: Text("Encontrar Equilibrio",style: TextStyle(color: Color(0xff323031)),),),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: ScreenSize.height*0.7,
                  width: ScreenSize.width,
                  child:Zoom(
                      enableScroll: true,
                      zoomSensibility: 10,
                      initZoom: 0,
                      height:(ScreenSize.height*0.7)*5,
                      width: ScreenSize.width*5,
                      child:game.widget!=null?game.widget:Container(child: Text("Cargando"))
                  )
                ),
                Container(
                  height: ScreenSize.height*0.1,
                  width: ScreenSize.width,

                  color: Color(0xff1BB377),
                  child: Container(
                        height: ScreenSize.height*0.1,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Text(medioR.length>0?"Resultado: ["+medioR[0].toStringAsPrecision(6)+","+medioR[1].toStringAsPrecision(6)+"]":"",style: TextStyle(fontSize: 25),)
                          ],
                        ),
                      ),
                )
                      ]


            ),
          ),
    );
  }
}

