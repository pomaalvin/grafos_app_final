import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button{
  Rect rect;
  Paint paintRect;
  TextPainter ptext;
  double x,y;
  String text;
  TextSpan texto;
  Color color;
  var para;
  Size ScreenSize;
  Button(this.ScreenSize,this.color,this.x,this.y,this.text,colortext,fontfamily){
    texto=TextSpan(text: text ,style: TextStyle(color: colortext,fontFamily:fontfamily,fontSize: ScreenSize.width/15));
    ptext=TextPainter(text: texto,textDirection: TextDirection.rtl);
    ptext.layout();
    rect=Rect.fromLTWH(x,y, ScreenSize.width/8, ScreenSize.width/8);
    paintRect=Paint();
    paintRect.color=color;



  }
  void render(Canvas c){
    c.drawOval(rect,paintRect);
    double tw=ptext.width,th=ptext.height;
    ptext.paint(c, new Offset(x+ScreenSize.width/16-tw/2, y+ScreenSize.width/16-th/2));
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