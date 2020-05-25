import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grafos/Arboles/Arboles_graph.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:flutter/gestures.dart';
import 'package:grafos/Johnson/grafos_john.dart';
import 'package:grafos/componentes/Nodo_Arbol.dart';
import 'package:zoom_widget/zoom_widget.dart';
class Main_Arboles extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Main_Arboles(lista);
  }

  List<double> lista;
  Main_Arboles(this.lista);

}

class _Main_Arboles extends State<Main_Arboles>{
  Arboles_graph game;
  List<Nodo_Arbol> nodosl;
  List<Nodo_Arbol> pila1;
  List<double> res;
  ScrollController listc;
  List<double> lista;
  _Main_Arboles(this.lista);
  @override
  void iniciar()async{
    WidgetsFlutterBinding.ensureInitialized();
    game=new Arboles_graph(context,lista);

    await Flame.util.fullScreen();
    await Flame.util.setOrientation(DeviceOrientation.portraitUp);
  }
  void initState() {

    iniciar();
    listc=ScrollController(initialScrollOffset: 250);
    if(listc.hasClients){
    }
  }
  List<double> alg3(){
    pila1=List<Nodo_Arbol>();
    res=List<double>();
    nodosl=game.nodos;
    pila1.add(nodosl[0]);
    while(pila1.length!=0){
      if(pila1[pila1.length-1].nodoizq!=null&&pila1[pila1.length-1].nodoizq.bloq3!=true){
        pila1.add(pila1[pila1.length-1].nodoizq);
      }
      else{
        if(pila1[pila1.length-1].nododer!=null&&pila1[pila1.length-1].nododer.bloq3!=true)
        {
          pila1.add(pila1[pila1.length-1].nododer);
        }
        else{
          if(!res.contains(pila1[pila1.length-1].valor)){
            res.add(pila1[pila1.length-1].valor);}
          pila1[pila1.length-1].bloq3=true;
          pila1.removeLast();
        }
      }
    }
    for(Nodo_Arbol nodo in nodosl){
      nodo.bloq3=false;
    }
    setState(() {
      lista=res;
    });
  }
  List<double> alg2(){
    pila1=List<Nodo_Arbol>();
    res=List<double>();
    nodosl=game.nodos;
    pila1.add(nodosl[0]);
    while(pila1.length!=0){
      if(pila1[pila1.length-1].nodoizq!=null&&pila1[pila1.length-1].nodoizq.bloq2!=true){
        pila1.add(pila1[pila1.length-1].nodoizq);
      }
      else{
        if(pila1[pila1.length-1].nododer!=null&&pila1[pila1.length-1].nododer.bloq2!=true)
        {
          if(!res.contains(pila1[pila1.length-1].valor)){
          res.add(pila1[pila1.length-1].valor);}
          pila1.add(pila1[pila1.length-1].nododer);
        }
        else{
          if(!res.contains(pila1[pila1.length-1].valor)){
            res.add(pila1[pila1.length-1].valor);}
          pila1[pila1.length-1].bloq2=true;
          pila1.removeLast();
        }
      }
    }

    for(Nodo_Arbol nodo in nodosl){
      nodo.bloq2=false;
    }
    setState(() {
      lista=res;
    });
  }
  List<double> alg1(){
    pila1=List<Nodo_Arbol>();
    res=List<double>();
    nodosl=game.nodos;
    pila1.add(nodosl[0]);
    res.add(pila1[pila1.length-1].valor);
    while(pila1.length!=0){
      if(pila1[pila1.length-1].nodoizq!=null&&pila1[pila1.length-1].nodoizq.bloq1!=true){
        pila1.add(pila1[pila1.length-1].nodoizq);
        res.add(pila1[pila1.length-1].valor);
      }
      else{
        if(pila1[pila1.length-1].nododer!=null&&pila1[pila1.length-1].nododer.bloq1!=true)
        {
          pila1.add(pila1[pila1.length-1].nododer);
          res.add(pila1[pila1.length-1].valor);
        }
        else{
          pila1[pila1.length-1].bloq1=true;
          pila1.removeLast();
        }
      }
    }

    for(Nodo_Arbol nodo in nodosl){
      nodo.bloq1=false;
    }
    setState(() {
      lista=res;
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
                            child: Center(child: Text("Arboles",style: TextStyle(color: Colors.white,fontFamily: 'CenturyGothic',fontSize: ScreenSize.width*0.05),),
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
                        width:ScreenSize.width*0.3,
                        padding: EdgeInsets.all(0.6),

                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            alg1();
                            print(res.toString());
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                          minWidth: ScreenSize.width/9,
                          height: ScreenSize.width/9,
                          color: Color(0xff1BB377),
                          child: Center(heightFactor: 1,child: Text("PreOrder",style: TextStyle(color: Color(0xff323031))),),
                        ),
                      ),
                      Container(
                        width:ScreenSize.width*0.3,
                        padding: EdgeInsets.all(0.6),
                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            alg2();
                            print(res.toString());
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                          minWidth: ScreenSize.width/9,
                          height: ScreenSize.width/9,
                          color: Color(0xff1BB377),
                          child: Center(heightFactor: 1,child: Text("InOrder",style: TextStyle(color: Color(0xff323031))),),
                        ),
                      ),Container(
                        width:ScreenSize.width*0.3,
                        padding: EdgeInsets.all(0.6),
                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            alg3();
                            print(res.toString());
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                          minWidth: ScreenSize.width/9,
                          height: ScreenSize.width/9,
                          color: Color(0xff1BB377),
                          child: Center(heightFactor: 1,child: Text("PostOrder",style: TextStyle(color: Color(0xff323031)),),),
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
                      height:(ScreenSize.height*0.8)*5,
                      width: ScreenSize.width*5,
                      child:game.widget!=null?game.widget:Container(child: Text("Cargando"))
                  )
                ),
                Container(
                  height: ScreenSize.height*0.1,
                  width: ScreenSize.width,

                  color: Color(0xff1BB377),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        height: ScreenSize.height*0.1,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Text(lista.toString(),style: TextStyle(fontSize: 25),)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                      ]


            ),
          ),
    );
  }
}

