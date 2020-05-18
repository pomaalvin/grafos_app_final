
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:grafos/Grafos_game.dart';
import 'dart:math';
class Nodo_Cournot{
  Size ScreenSize;
  Nodo_Cournot nodoizq;
  Nodo_Cournot nododer;
  Offset posi;
  TextSpan texto;
  Offset centtext;
  TextPainter tp;
  Paint paint;
  double x,y;
  bool bloq1=false;
  bool bloq2=false;
  bool bloq3=false;
  String valor;
  String tipo;
  Nodo_Cournot(this.ScreenSize,this.x,this.y,this.valor,this.tipo)
  {
    texto=new TextSpan(text: valor.toString(),style: TextStyle(color: Colors.white,fontSize: tipo=="normal"?15:10));
    tp=TextPainter(text: texto,textDirection: TextDirection.ltr);
    tp.layout();
    posi=Offset(x,y);
    centtext=Offset(x-tp.width/2,y-(ScreenSize.width/30)/7);
    paint=Paint();
    paint.color=tipo=="normal"?Colors.teal:Colors.redAccent;
  }
  void render(Canvas c){
    c.drawCircle(posi,(ScreenSize.width/30)/2,paint);
    tp.paint(c, centtext);
  }


}