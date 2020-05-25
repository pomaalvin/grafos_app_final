import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:grafos/componentes/Nodo.dart';
class Valor{
  Nodo nodo1,nodo2;
  Paint nodoPaint;
  Offset cent1,cent2,centtext;
  TextSpan texto1,texto2;
  TextPainter tp;
  double x,y;
  double text;
  Size ScreenSize;
  Valor(this.ScreenSize,this.nodo1,this.nodo2,this.text){
    texto1=new TextSpan(text: "T: "+text.round().toString().toUpperCase(),style: TextStyle(color: Colors.black,fontSize: (ScreenSize.width/20)/2));
    tp=new TextPainter(text: texto1,textDirection: TextDirection.rtl);
    tp.layout();
    centtext=Offset((nodo1.x+nodo2.x)/2,(nodo1.y+nodo2.y)/2);
    nodoPaint=Paint();
    nodoPaint.color=text.round()!=0?Colors.red:Colors.lightGreen;
  }
  void render(Canvas c){
    c.drawCircle(centtext,ScreenSize.width/25,nodoPaint);
    tp.paint(c, Offset(centtext.dx-tp.width/2,centtext.dy-tp.height/2));
  }
  void update(double t){

  }
}