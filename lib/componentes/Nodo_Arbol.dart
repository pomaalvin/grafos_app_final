
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:grafos/Grafos_game.dart';
import 'dart:math';
class Nodo_Arbol{
  Size ScreenSize;
  Nodo_Arbol nodoizq;
  Nodo_Arbol nododer;
  Offset posi;
  TextSpan texto;
  Offset centtext;
  TextPainter tp;
  Paint paint;
  double x,y;
  bool bloq1=false;
  bool bloq2=false;
  bool bloq3=false;
  double valor;
  Nodo_Arbol(this.ScreenSize,this.x,this.y,this.valor,this.nodoizq,this.nododer)
  {
    texto=new TextSpan(text: valor.toString(),style: TextStyle(color: Colors.white,fontSize: 20));
    tp=TextPainter(text: texto,textDirection: TextDirection.ltr);
    tp.layout();
    posi=Offset(x,y);
    centtext=Offset(x-tp.width/2,y-(ScreenSize.width/30)/3.8);
    paint=Paint();
    paint.color=Colors.teal;
  }
  void render(Canvas c){
    c.drawCircle(posi,(ScreenSize.width/30)/2,paint);
    tp.paint(c, centtext);
  }


}