import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:grafos/Johnson/Main_result_jo.dart';
import 'package:grafos/Johnson/Result_johnson.dart';
import 'package:grafos/Tabla.dart';
import 'package:grafos/componentes/Button.dart';
import 'package:grafos/componentes/Actividad.dart';
import 'package:grafos/componentes/Conexion_Arbol.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';

import 'package:grafos/componentes/Nodo_Arbol.dart';

class Arboles_graph extends Game{
  List<double> datos;
  Size ScreenSize;
  double tileSize;
  List<Nodo_Arbol> nodos;
  BuildContext context;
  List<Conexion_Arbol> actividades;
  void alogoritmo_ord(){
    nodos.add(Nodo_Arbol(ScreenSize,ScreenSize.width/2,ScreenSize.width/7,datos[0],null,null));
    for(int i=1;i<datos.length;i++){
      Nodo_Arbol cab=nodos[0];
      int c=0;
      while(cab.nododer!=null||cab.nodoizq!=null){
          c++;
          if(cab.valor<datos[i]){
            if(cab.nododer==null){
              break;}
            else
            cab=cab.nododer;
          }
          else if(cab.valor>datos[i]){
            if(cab.nodoizq==null)
              break;
            else
            cab=cab.nodoizq;
          }
        }
        if(cab.valor<datos[i]){
          double x=120;
          double y=120;
          for(Nodo_Arbol nodo in nodos){
            print(nodo.x);
            print(cab.x+x);
            print(nodo.y);
            print(cab.y+y);

            if((nodo.x).toStringAsFixed(2)==(cab.x+x).toStringAsFixed(2)&&(nodo.y).toStringAsFixed(2)==(cab.y+y).toStringAsFixed(2)){
              x+=ScreenSize.width/30+3;
              break;
            }
          }
          Nodo_Arbol nuevo=Nodo_Arbol(ScreenSize,(cab.x+x),(cab.y+y),datos[i],null,null);
          Conexion_Arbol nuevocon=Conexion_Arbol(ScreenSize,cab.x,cab.y,(cab.x+x),(cab.y+y),);
          nodos.add(nuevo);
          actividades.add(nuevocon);
          cab.nododer=nuevo;
        }
        else if(cab.valor>datos[i]){
          double x=120;
          double y=120;
          for(Nodo_Arbol nodo in nodos){
            print(nodo.x);
            print(cab.x-x);
            print(nodo.y);
            print(cab.y+y);
            if((nodo.x).toStringAsFixed(2)==(cab.x-x).toStringAsFixed(2)&&(nodo.y).toStringAsFixed(2)==(cab.y+y).toStringAsFixed(2)){
              x-=ScreenSize.width/30+3;
              break;
            }
          }
          Nodo_Arbol nuevo=Nodo_Arbol(ScreenSize,(cab.x-x),(cab.y+y),datos[i],null,null);
          Conexion_Arbol nuevocon=Conexion_Arbol(ScreenSize,cab.x,cab.y,(cab.x-x),(cab.y+y),);
          nodos.add(nuevo);
          actividades.add(nuevocon);
          cab.nodoizq=nuevo;
        }

    }
  }
  Arboles_graph(this.context,this.datos){
    initialize();
  }
  @override
  void render(Canvas canvas) {
    Rect backG=Rect.fromLTWH(0,0, ScreenSize.width, ScreenSize.height);
    Paint backGPaint=Paint();
    backGPaint.color=Color(0xffffffff);
    canvas.drawRect(backG, backGPaint);
    nodos.forEach((Nodo_Arbol nodo)=>nodo.render(canvas));
    actividades.forEach((Conexion_Arbol act)=>act.render(canvas));


  }
  void initialize() async{
    nodos=List<Nodo_Arbol>();
    actividades=List<Conexion_Arbol>();
    resize(await Flame.util.initialDimensions());
    alogoritmo_ord();


  }




  @override
  void update(double t) {

  }
  @override
  void resize(Size size) {
    ScreenSize=size;
    ScreenSize=Size(ScreenSize.width*5,ScreenSize.height*5);
  }


}
