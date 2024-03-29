
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:grafos/Grafos_game.dart';
import 'dart:math';
class Actividad{
  Nodo ninicio,nfinal;
  Size ScreenSize;
  double xini,yini,xfin,yfin;
  Offset posiactini;
  Offset posiactfin;
  Paint paintacti,paintdot;
  TextSpan att;
  double valor;
  bool doble;
  TextPainter attPaint;
  Actividad(this.ScreenSize,this.ninicio,this.nfinal,this.valor,this.doble){
    xini=ninicio.posNodo.right-(ScreenSize.width/7)/2;
    yini=ninicio.posNodo.top+(ScreenSize.width/7)/2;
    xfin=nfinal.posNodo.right-(ScreenSize.width/7)/2;
    yfin=nfinal.posNodo.top+(ScreenSize.width/7)/2;
    if((xini-xfin).abs()>(yini-yfin).abs()){
      if(xini<xfin){
        xini=xini+(ScreenSize.width/7)/2;
        xfin=xfin-(ScreenSize.width/7)/2;
      }
      else{
        xini=xini-(ScreenSize.width/7)/2;
        xfin=xfin+(ScreenSize.width/7)/2;
      }
    }
    else
    {
      if(yini<yfin){
        yini=yini+(ScreenSize.width/7)/2;
        yfin=yfin-(ScreenSize.width/7)/2;
      }
      else{

        yini=yini-(ScreenSize.width/7)/2;
        yfin=yfin+(ScreenSize.width/7)/2;
      }
    }
    posiactini=Offset(xini,yini);
    posiactfin=Offset(xfin,yfin);
    paintacti=Paint();
    paintdot=Paint();
    paintdot.color=Colors.black;
    paintacti.strokeWidth=3;
    paintacti.color=Color(0xff123123);
  }
  void moverini(x,y){
    if((x-xfin).abs()>(y-yfin).abs()){
      if(x<xfin){
        x=x+(ScreenSize.width/7)/2;
      }
      else{
        x=x-(ScreenSize.width/7)/2;
      }
    }
    else
    {
      if(y<yfin){
        y=y+(ScreenSize.width/7)/2;
      }
      else{

        y=y-(ScreenSize.width/7)/2;
      }
    }
      posiactini=posiactini.translate(x-xini, y-yini);
      xini=x;
      yini=y;
    }
    void moverigual(x,y){
      y=y-(ScreenSize.width/7)/2;
    posiactini=posiactini.translate(x-this.xini, y-this.yini);
    posiactfin=posiactfin.translate(x-this.xfin, y+(ScreenSize.width/7)-this.yfin);
      this.xini=x;
      this.yini=y;
      this.xfin=x;
      this.yfin=y+(ScreenSize.width/7);
      
    

    }
    void moverfin(x,y)    {
      if((xini-x).abs()>(yini-y).abs()){
      if(xini<x){
        x=x-(ScreenSize.width/7)/2;
      }
      else{
        x=x+(ScreenSize.width/7)/2;
      }
    }
    else
    {
      if(yini<y){
        y=y-(ScreenSize.width/7)/2;
      }
      else{

        y=y+(ScreenSize.width/7)/2;
      }
    }
      
      posiactfin=posiactfin.translate(x-xfin, y-yfin);
      xfin=x;
      yfin=y;
  }
  void render(Canvas c){


    if(ninicio==nfinal)
      {
      this.posiactfin=Offset(xfin+(ScreenSize.width/7)/2,yini+(ScreenSize.width/7));
        paintacti.style=PaintingStyle.stroke;

      Paint flechap=new Paint();
      flechap.color=Colors.black;
      flechap.strokeWidth=(ScreenSize.width/7)*0.02;
      flechap.style=PaintingStyle.stroke;
      c.drawArc(new Rect.fromLTWH(this.posiactini.dx, this.posiactini.dy, (ScreenSize.width/7), (ScreenSize.width/7)),pi*1.35, pi*1.3, false, flechap);
      Path triangulo=new Path();
      Offset posiactfin=new Offset((this.posiactfin.dx-(ScreenSize.width/7)/3.5),(this.posiactfin.dy-3));
      Offset posiactini=new Offset((posiactfin.dx+45),(posiactfin.dy-5));

      var tam = (ScreenSize.width/7)/2; // length of head in pixels
      var dx = posiactfin.dx - posiactini.dx;
      var dy = posiactfin.dy - posiactini.dy;
      var angle = atan2(dy, dx);
      var fle1x=posiactfin.dx - tam* cos(angle - pi / 6);
      var fle1y=posiactfin.dy - tam* sin(angle - pi / 6);
      var fle2x=posiactfin.dx - tam* cos(angle + pi / 6);
      var fle2y=posiactfin.dy- tam* sin(angle + pi / 6);
      triangulo.moveTo(posiactfin.dx, posiactfin.dy);
      triangulo.lineTo(fle1x, fle1y);
      triangulo.lineTo(fle2x,fle2y );
      Paint triangp=new Paint();
      triangp.style=PaintingStyle.fill;
      triangp.color=Color(0xffFFC857);
      c.drawPath(triangulo, triangp);
      var da=sqrt(pow(posiactfin.dx-fle2x,2)+pow(posiactfin.dy-fle2y,2));
      var db=sqrt(pow(posiactfin.dx-fle1x,2)+pow(posiactfin.dy-fle1y,2));
      var dc=sqrt(pow(fle2x-fle1x,2)+pow(fle2y-fle1y,2));
      var letrax=(fle1x*(da)+fle2x*db+posiactfin.dx*dc)/(da+db+dc);
      var letray=(fle1y*(da)+fle2y*db+posiactfin.dy*dc)/(da+db+dc);
      att=TextSpan(text: valor.truncate().toString(),style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: (ScreenSize.width/7)*0.2));

      attPaint=TextPainter(text: att,textDirection: TextDirection.rtl);
      attPaint.layout();

      double tamtw = attPaint.width,
          tamth = attPaint.height;
      attPaint.paint(c, Offset(letrax-tamtw/2,letray-tamth/2));

      }
    else {
      if(!doble){
        c.drawLine(this.posiactini, this.posiactfin, paintacti);
      }
      Offset posiactfin=new Offset((6*this.posiactfin.dx+this.posiactini.dx)/7,(6*this.posiactfin.dy+this.posiactini.dy)/7);
      Offset posiactini=new Offset((this.posiactfin.dx+6*this.posiactini.dx)/7,(this.posiactfin.dy+6*this.posiactini.dy)/7);


      Path triangulo=new Path();
      var tam = (ScreenSize.width/7)/2; // length of head in pixels
      var dx = posiactfin.dx - posiactini.dx;
      var dy = posiactfin.dy - posiactini.dy;
      var angle = atan2(dy, dx);
      var fle1x=posiactfin.dx - tam* cos(angle - pi / 6);
      var fle1y=posiactfin.dy - tam* sin(angle - pi / 6);
      var fle2x=posiactfin.dx - tam* cos(angle + pi / 6);
      var fle2y=posiactfin.dy- tam* sin(angle + pi / 6);
      triangulo.moveTo(posiactfin.dx, posiactfin.dy);
      triangulo.lineTo(fle1x, fle1y);
      triangulo.lineTo(fle2x,fle2y );
      Paint triangp=new Paint();
      triangp.style=PaintingStyle.fill;
      triangp.color=Color(0xffFFC857);
      c.drawPath(triangulo, triangp);
      var da=sqrt(pow(posiactfin.dx-fle2x,2)+pow(posiactfin.dy-fle2y,2));
      var db=sqrt(pow(posiactfin.dx-fle1x,2)+pow(posiactfin.dy-fle1y,2));
      var dc=sqrt(pow(fle2x-fle1x,2)+pow(fle2y-fle1y,2));
      var letrax=(fle1x*(da)+fle2x*db+posiactfin.dx*dc)/(da+db+dc);
      var letray=(fle1y*(da)+fle2y*db+posiactfin.dy*dc)/(da+db+dc);
      att=TextSpan(text: valor.truncate().toString(),style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold,fontSize: (ScreenSize.width/7)*0.2));

      attPaint=TextPainter(text: att,textDirection: TextDirection.rtl);
      attPaint.layout();

      double tamtw = attPaint.width,
          tamth = attPaint.height;
      attPaint.paint(c, Offset(letrax-tamtw/2,letray-tamth/2));
    }
  }


}