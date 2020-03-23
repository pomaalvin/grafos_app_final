
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grafos/Tabla.dart';
import 'package:grafos/componentes/Button.dart';
import 'package:grafos/componentes/Actividad.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';

import 'package:grafos/componentes/Nodo_johnson.dart';
import 'package:grafos/componentes/valor.dart';

class Result_jo extends Game{
  Size ScreenSize;
  double tileSize;
  List<Nodo> nodos;
  BuildContext context;
  List<Actividad> actividades;
  List<Nodo_johnson> NodosJo;
  List<Valor> valores;
  Result_jo(this.context,this.nodos,this.actividades){
    initialize();
  }
  @override
  void render(Canvas canvas) {
    Rect backM2=Rect.fromLTWH(0, 0, ScreenSize.width, ScreenSize.height/10);
    Rect backG=Rect.fromLTWH(0,ScreenSize.height/10, ScreenSize.width, ScreenSize.height);
    Paint backGPaint=Paint();
    backGPaint.color=Color(0xffffffff);
    Paint backM1Paint=Paint();
    Paint backM2Paint=Paint();
    backM2Paint.color=Color(0xff084C61);
    canvas.drawRect(backG, backGPaint);
    canvas.drawRect(backM2, backM2Paint);
    nodos.forEach((Nodo nodo)=>nodo.render(canvas));
    actividades.forEach((Actividad act)=>act.render(canvas));
    NodosJo.forEach((Nodo_johnson nj)=>nj.render(canvas));
    valores.forEach((Valor v)=>v.render(canvas));


  }
  void initialize() async{
    NodosJo=new List<Nodo_johnson>();
    valores=new List<Valor>();
    resize(await Flame.util.initialDimensions());
    Nodo ini,fin;
    for(Nodo nodo in nodos){
      int cf=0;
      int ci=0;
      for(Actividad act in actividades){
        if(act.nfinal==nodo){
          cf++;
        }
        else{
          if(act.ninicio==nodo)
            {
              ci++;
            }
        }
      }
      if(cf==0){
        ini=nodo;
      }
      else{
        if(ci==0){
          fin=nodo;
        }
      }

    }
    for(Nodo nodo in nodos){
      NodosJo.add(Nodo_johnson(nodo,ScreenSize,nodo.x,nodo.y,0.0,0.0));
    }
    List<Nodo> auxiliares=List<Nodo>();
    auxiliares.add(ini);
    while(!(auxiliares.elementAt(0)==fin&&auxiliares.length==1)){
      List<Nodo> auxiliares2=List<Nodo>();
      for(Nodo aux in auxiliares){
        if(aux!=fin){
          List<Actividad> nodosfin=sacar_nfinal(aux);
          for(int i=0;i<nodosfin.length;i++){
            Nodo_johnson finJon=sacarNodoJ(nodosfin.elementAt(i).nfinal);
            Nodo_johnson iniJon=sacarNodoJ(nodosfin.elementAt(i).ninicio);
            if(finJon.text2!=0.0){
              if(finJon.text2<nodosfin.elementAt(i).valor+iniJon.text2){
                finJon.text2=nodosfin.elementAt(i).valor+iniJon.text2;
              }
            }
            else{
              finJon.text2=nodosfin.elementAt(i).valor+iniJon.text2;
            }
            if(!auxiliares2.contains(nodosfin.elementAt(i).nfinal)){
            auxiliares2.add(nodosfin.elementAt(i).nfinal);}
          }

        }

      }
      auxiliares.clear();
      for(Nodo auxi in auxiliares2){
        print(auxi.text);
        auxiliares.add(auxi);
      }
      print(auxiliares2.length);
      print(auxiliares.length);
    }
    List<Nodo> auxiliaresvuelta=List<Nodo>();
    auxiliaresvuelta.add(fin);
    sacarNodoJ(fin).text1=sacarNodoJ(fin).text2;
    while(!(auxiliaresvuelta.elementAt(0)==ini&&auxiliaresvuelta.length==1)){
      List<Nodo> auxiliares2=List<Nodo>();
      for(Nodo aux in auxiliaresvuelta){
        if(aux!=ini){
          List<Actividad> nodosini=sacar_ninicio(aux);
          for(int i=0;i<nodosini.length;i++){
            Nodo_johnson finJon=sacarNodoJ(nodosini.elementAt(i).nfinal);
            Nodo_johnson iniJon=sacarNodoJ(nodosini.elementAt(i).ninicio);
            if(iniJon.text1!=iniJon.text2){
              iniJon.text1=finJon.text1-nodosini.elementAt(i).valor;}
            valores.add(Valor(ScreenSize,iniJon.nodo,finJon.nodo,finJon.text1-nodosini.elementAt(i).valor-iniJon.text2));

            if(!auxiliares2.contains(nodosini.elementAt(i).ninicio)){
              auxiliares2.add(nodosini.elementAt(i).ninicio);}
          }

        }

      }
      auxiliaresvuelta.clear();
      for(Nodo auxi in auxiliares2){
        auxiliaresvuelta.add(auxi);
      }
      print(auxiliares2.length);
      print(auxiliares.length);
    }
    print(NodosJo.elementAt(1).text1);
    List<Nodo_johnson>nuevosnodos=List<Nodo_johnson>();
    for(Nodo_johnson nodo in NodosJo){
      nuevosnodos.add(Nodo_johnson(nodo.nodo,ScreenSize,nodo.x,nodo.y,nodo.text1,nodo.text2));
    }
    NodosJo.clear();
    NodosJo=nuevosnodos;


  }
  Nodo_johnson sacarNodoJ(Nodo nodo){
    Nodo_johnson devolver=null;
    for(Nodo_johnson nodito in NodosJo){
      if(nodito.nodo==nodo){
        devolver=nodito;
      }
    }
    return devolver;
  }
  List<Actividad> sacar_nfinal(Nodo nodo){
    List<Actividad> resp=List<Actividad>();

    for(Actividad act in actividades){
      if(act.ninicio==nodo){
        resp.add(act);
      }
    }
    return resp;
  }
  List<Actividad> sacar_ninicio(Nodo nodo){
    List<Actividad> resp=List<Actividad>();

    for(Actividad act in actividades){
      if(act.nfinal==nodo){
        resp.add(act);
      }
    }
    return resp;
  }




  @override
  void update(double t) {

  }
  @override
  void resize(Size size) {
    ScreenSize=size;
    tileSize=ScreenSize.width/7;
  }






}
