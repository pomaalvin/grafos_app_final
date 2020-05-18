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
import 'package:grafos/componentes/Nodo_Cournot.dart';

class Cournot_graph extends Game{
  List<List<double>> datos;
  Size ScreenSize;
  double tileSize;
  List<Nodo_Cournot> nodos;
  BuildContext context;
  List<Conexion_Arbol> actividades;
  conectar(){
    Size size=MediaQuery.of(this.context).size;

    double mx=size.width*5/2;
    double my=(size.height*0.7)*5/2-1;
    Size size2=Size(size.width*5,size.height*5);
    nodos.add(Nodo_Cournot(size2,mx+datos[0][0]*55,my-datos[0][1]*55,datos[0][0].toString()+","+datos[0][1].toString(),"normal"));
    for(int i=1;i<datos.length;i++){

      nodos.add(Nodo_Cournot(size2,mx+datos
      [i][0]*55,my-datos[i][1]*55,datos[i][0].toString()+","+datos[i][1].toString(),"normal"));
    }
  }

  Cournot_graph(this.context,this.datos){
    initialize();
  }
  void anadirmedio(List<double> medio){
    Size size=MediaQuery.of(this.context).size;

    double mx=size.width*5/2;
    double my=(size.height*0.7)*5/2-1;
    Size size2=Size(size.width*4,size.height*4);

    nodos.add(Nodo_Cournot(size2,mx+medio[0]*55,my-medio[1]*55,medio[0].toStringAsPrecision(3)+","+medio[1].toStringAsPrecision(3),"medio"));
  }
  @override
  void render(Canvas canvas) {
    Rect backG=Rect.fromLTWH(0,0, ScreenSize.width, ScreenSize.height);
    Offset y1=Offset(ScreenSize.width/2,0);
    Offset y2=Offset(ScreenSize.width/2,ScreenSize.height);
    Paint ypaint=Paint();
    ypaint.color=Colors.redAccent.withOpacity(0.7);
    ypaint.style=PaintingStyle.stroke;
    ypaint.strokeWidth=5;
    Offset x1=Offset(0,(ScreenSize.height*0.7)/2);
    Offset x2=Offset(ScreenSize.width,(ScreenSize.height*0.7)/2);
    Paint xpaint=Paint();
    xpaint.color=Colors.black.withOpacity(0.7);
    xpaint.style=PaintingStyle.stroke;
    xpaint.strokeWidth=5;
    Paint backGPaint=Paint();
    backGPaint.color=Color(0xffffffff);
    canvas.drawRect(backG, backGPaint);
    canvas.drawLine(y1,y2,ypaint);
    canvas.drawLine(x1,x2,xpaint);
    double x0=ScreenSize.width/2;
    double x02=ScreenSize.width/2;
    double y0=ScreenSize.height*0.7/2;
    double y02=ScreenSize.height*0.7/2;
    for(int i=0;i<26;i++){
      TextSpan textox=new TextSpan(text: (i).toString(),style: TextStyle(color: Colors.black,fontSize: 15));
      TextSpan textox2=new TextSpan(text: (i).toString(),style: TextStyle(color: Colors.black,fontSize: 15));
      TextSpan textoy=new TextSpan(text: (i).toString(),style: TextStyle(color: Colors.red,fontSize: 15));
      TextSpan textoy2=new TextSpan(text: (i).toString(),style: TextStyle(color: Colors.red,fontSize: 15));
      TextPainter tpx=TextPainter(text: textox,textDirection: TextDirection.ltr);
      TextPainter tpx2=TextPainter(text: textox2,textDirection: TextDirection.ltr);
      TextPainter tpy=TextPainter(text: textoy,textDirection: TextDirection.ltr);
      TextPainter tpy2=TextPainter(text: textoy2,textDirection: TextDirection.ltr);
      tpx.layout();
      tpx2.layout();
      tpy.layout();
      tpy2.layout();
      Offset x1=Offset(x0,ScreenSize.height*0.7/2-10);
      Offset x2=Offset(x0,ScreenSize.height*0.7/2+10);

      Offset tx1=Offset(x0-tpx.size.width/2,ScreenSize.height*0.7/2+20);
      Offset tx2=Offset(x02-tpx2.size.width/2,ScreenSize.height*0.7/2-35);
      Offset ty1=Offset(ScreenSize.width/2-20-tpy.size.width,y0-tpy.size.height/2);
      Offset ty2=Offset(ScreenSize.width/2+20,y02-tpy2.size.height/2);
      Offset x12=Offset(x02,ScreenSize.height*0.7/2-10);
      Offset x22=Offset(x02,ScreenSize.height*0.7/2+10);
      Offset y1=Offset(ScreenSize.width/2-10,y0);
      Offset y2=Offset(ScreenSize.width/2+10,y0);
      Offset y12=Offset(ScreenSize.width/2-10,y02);
      Offset y22=Offset(ScreenSize.width/2+10,y02);
      canvas.drawLine(x1,x2,xpaint);
      canvas.drawLine(x12,x22,xpaint);
      canvas.drawLine(y1,y2,ypaint);
      canvas.drawLine(y12,y22,ypaint);
      tpx.paint(canvas, tx1);
      tpx2.paint(canvas, tx2);
      tpy.paint(canvas, ty1);
      tpy2.paint(canvas, ty2);
      x0+=55;
      x02-=55;
      y0+=55;
      y02-=55;
    }
    nodos.forEach((Nodo_Cournot nodo)=>nodo.render(canvas));
    actividades.forEach((Conexion_Arbol act)=>act.render(canvas));


  }
  void initialize() async{
    nodos=List<Nodo_Cournot>();
    actividades=List<Conexion_Arbol>();
    resize(await Flame.util.initialDimensions());
    conectar();


  }




  @override
  void update(double t) {

  }
  @override
  void resize(Size size) {
    ScreenSize=MediaQuery.of(context).size;
    ScreenSize=Size(ScreenSize.width*5,ScreenSize.height*5);
  }


}
