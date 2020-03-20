import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Grafos_game.dart';
class Nodo{
  bool mov=true;
  Rect posNodo;
  Paint nodoPaint;
  Offset cent,centtext;
  TextSpan texto;
  TextPainter tp;
  double x,y;
  String text;
  final LangawGame game;
  Nodo(this.game,this.x,this.y,String this.text){
    texto=new TextSpan(text: text.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: game.tileSize/2));
    tp = new TextPainter(text: texto, textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    tp.layout();
    posNodo=Rect.fromLTWH(x-game.tileSize/2, y-game.tileSize/2, game.tileSize, game.tileSize);
    cent=Offset(x,y);
    centtext=Offset(x-tp.width/2,y-game.tileSize/3.8);
    nodoPaint=Paint();
    nodoPaint.color=Color(0xff323031);
  }
  void render(Canvas c){
    c.drawCircle(cent,game.tileSize/2,nodoPaint);
    tp.paint(c, centtext);
  }
  void update(double t){

  }
  void onTapDown(){}
  void mover(double x,double y){
      cent=cent.translate(x-this.x,y-this.y);
      centtext=centtext.translate(x-this.x,y-this.y);
      this.x=x;
      this.y=y;      
    posNodo=Rect.fromLTWH(x-game.tileSize/2, y-game.tileSize/2, game.tileSize, game.tileSize);

  }
  void seleccionar(){
    nodoPaint.color=Color(0xff177E89);

  }
  void deseleccionar(){

    nodoPaint.color=Color(0xff323031);

  }
  void dibujar_act(){

  }
}