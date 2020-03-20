import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Grafos_game.dart';

class Button{
  Rect rect;
  Paint paintRect;
  TextPainter ptext;
  double x,y;
  String text;
  TextSpan texto;
  Color color;
  var para;
  final LangawGame game;
  Button(this.game,this.color,this.x,this.y,this.text,colortext,fontfamily){
    texto=TextSpan(text: text ,style: TextStyle(color: colortext,fontFamily:fontfamily,fontSize: game.ScreenSize.width/15));
    ptext=TextPainter(text: texto,textDirection: TextDirection.rtl);
    ptext.layout();
    rect=Rect.fromLTWH(x,y, game.ScreenSize.width/8, game.ScreenSize.width/8);
    paintRect=Paint();
    paintRect.color=color;



  }
  void render(Canvas c){
    c.drawOval(rect,paintRect);
    double tw=ptext.width,th=ptext.height;
    ptext.paint(c, new Offset(x+game.ScreenSize.width/16-tw/2, y+game.ScreenSize.width/16-th/2));
  }
  void update(double t){}
  void onTapDown(){}
  void seleccion(){
    if(text==""){

      paintRect.color=Color.fromARGB(255,178,49, 49);
    }
    else{
      if(text==""){

      paintRect.color=Color(0xff545454);
    }

      else{

        paintRect.color=Color(0xffFFE1A3);
      }
    }
  }
  void deseleccion(){
    paintRect.color=color;
  }
}