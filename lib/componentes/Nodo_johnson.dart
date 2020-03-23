import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:grafos/componentes/Nodo.dart';
class Nodo_johnson{
  Nodo nodo;
  Rect posNodo;
  Paint nodoPaint;
  Offset cent,centtext1,centtext2;
  TextSpan texto1,texto2;
  TextPainter tp1,tp2;
  double x,y;
  double text1,text2;
  Size ScreenSize;
  Nodo_johnson(this.nodo,this.ScreenSize,this.x,this.y, this.text1, this.text2){
    texto1=new TextSpan(text: text1.toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: (ScreenSize.width/14)/2));
    texto2=new TextSpan(text: text2.toString().toUpperCase(),style: TextStyle(color: Colors.white,fontSize: (ScreenSize.width/14)/2));
    tp1 = new TextPainter(text: texto1, textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    tp2 = new TextPainter(text: texto2, textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    tp1.layout();
    tp2.layout();
    posNodo=Rect.fromLTWH(x-(ScreenSize.width/5)/2, y-(ScreenSize.width/7)/2+ScreenSize.width/7, (ScreenSize.width/5), (ScreenSize.width/18));
    cent=Offset(x,y+ScreenSize.width/7);
    centtext1=Offset(x-ScreenSize.width*0.008-tp1.width,y-(ScreenSize.width/7)/2+ScreenSize.width/7+tp1.height/4);
    centtext2=Offset(x+ScreenSize.width*0.008,y-(ScreenSize.width/7)/2+ScreenSize.width/7+tp1.height/4);
    nodoPaint=Paint();
    nodoPaint.color=Color(0xff084C61);
  }
  void render(Canvas c){
    c.drawRect(posNodo,nodoPaint);
    tp1.paint(c, centtext2);
    tp2.paint(c, centtext1);
    Paint linep=new Paint();
    linep.color=Colors.white;
    linep.style=PaintingStyle.stroke;
    linep.strokeWidth=2;
    c.drawLine(Offset(cent.dx,cent.dy-ScreenSize.width/14), Offset(cent.dx,cent.dy), linep);
  }
  void update(double t){

  }
}