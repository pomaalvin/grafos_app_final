
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

class LangawGame extends Game{
  bool bloquear=false;
  Size ScreenSize;
  double tileSize;
  List<bool> selec;
  List<Button> botones;
  List<Nodo> elegidos;
  List<Nodo> nodos;
  List<Nodo> elegborrar;
  BuildContext context;
  List<Actividad> actividades;
  LangawGame(this.context){
    initialize();
  }
  @override
  void render(Canvas canvas) {
    Rect backM1=Rect.fromLTWH(0, 0, ScreenSize.width, ScreenSize.height/10);
    TextSpan titulo=new TextSpan(text: "Grafos",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width/25,fontFamily: 'CenturyGothic',fontWeight: FontWeight.bold));
    TextPainter paintext=new TextPainter(text: titulo,textDirection: TextDirection.rtl);
    paintext.layout();
    double htext=paintext.height;
    double wtext=paintext.width;
    Rect backM2=Rect.fromLTWH(0, ScreenSize.height/10, ScreenSize.width, ScreenSize.height/10);
    Rect backG=Rect.fromLTWH(0,ScreenSize.height/5, ScreenSize.width, ScreenSize.height);
    Paint backGPaint=Paint();
    backGPaint.color=Color(0xffffffff);
    Paint backM1Paint=Paint();
    backM1Paint.color=Color(0xff323031);
    Paint backM2Paint=Paint();
    backM2Paint.color=Color(0xff084C61);
    canvas.drawRect(backG, backGPaint);
    canvas.drawRect(backM1, backM1Paint);
    canvas.drawRect(backM2, backM2Paint);
    paintext.paint(canvas, Offset(ScreenSize.width/2-wtext/2,ScreenSize.height/20-htext/2));
    nodos.forEach((Nodo nodo)=>nodo.render(canvas));
    actividades.forEach((Actividad act)=>act.render(canvas));
    botones.forEach((Button boton)=> boton.render(canvas));


  }
  void dibujarbotones(){
    var icon1=Icons.add;
    var icon2=Icons.keyboard_backspace;
    var icon3=Icons.mode_edit;
    var icon4=Icons.remove_circle;
    var icon5=Icons.clear;
    var icon6=Icons.table_chart;
    String icon1t=String.fromCharCode(icon1.codePoint);
    String icon2t=String.fromCharCode(icon2.codePoint);
    String icon3t=String.fromCharCode(icon3.codePoint);
    String icon4t=String.fromCharCode(icon4.codePoint);
    String icon5t=String.fromCharCode(icon5.codePoint);
    String icon6t=String.fromCharCode(icon6.codePoint);
    botones.add(Button(this,Color(0xffFFC857), ScreenSize.width/35, ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon1t, Color(0xff323031),icon1.fontFamily));
    botones.add(Button(this, Color(0xffFFC857), ScreenSize.width/35+tileSize , ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon2t, Color(0xff323031),icon2.fontFamily));
    botones.add(Button(this, Color(0xffFFC857), ScreenSize.width/35+tileSize*2, ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon3t, Color(0xff323031),icon3.fontFamily));
    botones.add(Button(this, Color(0xffFFC857), ScreenSize.width/35+tileSize*3, ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon4t, Color(0xff323031),icon4.fontFamily));
    botones.add(Button(this, Color.fromARGB(255,112,16, 16), ScreenSize.width/35+tileSize*4, ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon5t, Color(0xffffffff),icon5.fontFamily));
    botones.add(Button(this,Color(0xff323031),ScreenSize.width*4/35+tileSize*5, ScreenSize.height/10+ScreenSize.height/20-ScreenSize.width/16,icon6t, Color(0xffffffff),icon6.fontFamily));

  }
  void initialize() async{
    botones=List<Button>();
    selec=[true,false,false,false,false,false];
    nodos=List<Nodo>();
    elegidos=List<Nodo>();
    actividades=List<Actividad>();
    resize(await Flame.util.initialDimensions());
    dibujarbotones();
    botones.elementAt(0).seleccion();

  }
  void llamarNodo(double x,double y){
    TextEditingController texto=new TextEditingController();
    final formkey=GlobalKey<FormState>();
    showDialog(context: context,
    builder: (BuildContext context){
      bloquear=true;
      return WillPopScope(
        onWillPop: ()async {

          bloquear=false;
          return true;
        },

        child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(15),
              color: Color(0xff084C61),
              child: Text("Ingrese el valor del Nodo",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width*0.05),),
            ),
            content: Form(
              key: formkey,
              child: Container(
                height: ScreenSize.width*0.5,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        controller: texto,
                        maxLength: 2,
                        validator: (value){
                          if(value.isEmpty){
                            return"Ingrese un valor";
                          }
                          else{
                            bool igualval=false;
                            for(int i=0;i<nodos.length;i++)
                            {
                              if(nodos.elementAt(i).text==value)
                              {
                                igualval=true;
                              }
                            }
                            if(igualval==false)
                            {
                              return null;
                            }
                            else{
                              return "Ya existe el elemento";
                            }
                          }
                        }
                    ),
                    MaterialButton(
                      elevation: 10,
                      padding: EdgeInsets.all(0),
                      color: Color(0xff323031),
                      child: Text("Aceptar",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width*0.05),),
                      onPressed: (){
                        if(formkey.currentState.validate()){
                          nodos.add(Nodo(this,x,y,texto.text));
                          Navigator.pop(context);
                          bloquear=false;
                        }
                      },


                    )
                  ],
                ),
              ),
            )
        ),
      );
    });
  }
  bool verificaract(Nodo ni,Nodo nf){
    bool nuevo=true;
    for(Actividad act in actividades){
      if(act.nfinal==nf&&act.ninicio==ni){
        nuevo=false;
        break;
      }
    }
    return nuevo;

  }
  void llamarAct(Nodo ni,Nodo nf){
    if(verificaract(ni, nf)){
TextEditingController texto=new TextEditingController();
  final formkey=GlobalKey<FormState>();
  showDialog(context: context,
      builder: (BuildContext context){
      bloquear=true;
        return WillPopScope(
          onWillPop: ()async {

            bloquear=false;
            return true;
          },
          child: AlertDialog(

              titlePadding: EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.all(15),
                color: Color(0xff084C61),
                child: Text("Ingrese el valor de la Actividad",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width*0.05),),
              ),
              content: Form(
                key: formkey,
                child: Container(
                  height: ScreenSize.width*0.5,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          keyboardType: TextInputType.number,
                          controller: texto,
                          maxLength: 10,
                          validator: (value){
                            if(value.isEmpty){
                              return"Ingrese un valor";
                            }
                            else{
                              return null;
                            }
                          }
                      ),
                      MaterialButton(
                        elevation: 10,
                        padding: EdgeInsets.all(0),
                        color: Color(0xff323031),
                        child: Text("Aceptar",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width*0.05),),
                        onPressed: (){
                          if(formkey.currentState.validate()){
                            bool doble=false;
                            for(Actividad act in actividades){
                              if(act.nfinal==ni&&act.ninicio==nf){
                                doble=true;
                                break;
                              }
                            }
                            if(doble){
                              actividades.add(Actividad(this,ni,nf,double.parse(texto.text.toString()),true));
                              Navigator.pop(context);
                              bloquear=false;
                            }
                            else{
                            actividades.add(Actividad(this,ni,nf,double.parse(texto.text.toString()),false));
                            Navigator.pop(context);
                            bloquear=false;
                          }
                          }
                        },


                      )
                    ],
                  ),
                ),
              )
          ),
        );
      });
    }
    else{
      bloquear=false;
      elegidos.clear();
      for(Nodo n in nodos){
        n.deseleccionar();
      }
      Fluttertoast.showToast(
          msg: "Ya existe la Actividad",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          
          timeInSecForIos: 1,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white.withOpacity(0.8),
          fontSize: 16.0
      );
     }
  }
  
  @override
  void update(double t) {
    nodos.forEach((Nodo nodo)=>nodo.update(t));
    botones.forEach((Button nodo)=>nodo.update(t));

  }
  @override
  void resize(Size size) {
    ScreenSize=size;
    tileSize=ScreenSize.width/7;
  }
  void borrarop(d){
    for(Nodo el in elegidos)
    {
      el.deseleccionar();
    }
    elegidos.clear();
    Nodo borrar;
    for(Nodo nodo in nodos)
    {

      if(nodo.posNodo.contains(d)){
        borrar=nodo;
      }       }
    bool encact=false;
    List<Actividad> acteli=new List<Actividad>();
    for(int i=0;i<actividades.length;i++)
    {
      if(actividades.elementAt(i).ninicio==borrar||actividades.elementAt(i).nfinal==borrar)
      {

        acteli.add(actividades.elementAt(i));
        encact=true;
      }
    }
    for(int i=0;i<acteli.length;i++)
    {
      actividades.remove(acteli.elementAt(i));
    }
    if(!encact){
      nodos.remove(borrar);}
  }
  void addnodo(d){
    elegidos.clear();
    bool contiene=false;
    for(Nodo nodo in nodos){
      if(nodo.posNodo.contains(d)){
        contiene=true;
      }
    }
    if(contiene==false&&nodos.length<15){
      llamarNodo(d.dx, d.dy,);

    }
  }
  void addactividad(d){
    bool presionado=false;
    for(Nodo nodo in nodos){
      if(nodo.posNodo.contains(d)&&elegidos.length<2){
        elegidos.add(nodo);
        nodo.seleccionar();
        presionado=true;
        break;
      }
    }
    if(presionado==false)
    {
      for(Nodo elegi in elegidos){
        elegi.deseleccionar();
      }
      elegidos.clear();
      bool contiene=false;
      for(Nodo nodo in nodos){
        if(nodo.posNodo.contains(d)){
          contiene=true;
        }
      }
    }
    else{
      if(elegidos.length==2){
        llamarAct(elegidos.first,elegidos.last);
      }
    }
  }
  void limpiarop(d){

    for(Nodo elegi in elegidos){
      elegi.deseleccionar();
    }
   elegidos.clear();
    int c=0;
    for(int i=0;i<6;i++){
      botones.elementAt(i).deseleccion();

    }
    for(Button b in botones){
      if(b.rect.contains(d)){
        b.seleccion();
        selec=[false,false,false,false,false,false];
        selec.insert(c, true);
        selec.removeAt(c+1);
        if(botones[4]==b)
        {showDialog(context: context,
              builder:(BuildContext context){
                  return AlertDialog(
                    backgroundColor: Color(0xff323031).withOpacity(0.8),
                    title: Text("Limpiar Todo?",textAlign: TextAlign.center,style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                         MaterialButton(
                            color: Color(0xff084C61),
                      child: Text("Cancelar",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        Navigator.pop(context);
                      }),
                      Container(width: 10,height: 0,),
                        MaterialButton(
                          color: Color(0xffFFC857),
                      child: Text("Aceptar"),
                      onPressed: (){
                        for(Nodo el in elegidos)
                        {
                          el.deseleccionar();
                        }
                        elegidos.clear();
                        nodos.clear();
                        actividades.clear();
                        Navigator.pop(context);

                        
                      }),
                      ],
                    ),
                    
                  );
              });

          
        }
        else{

          if(botones[5]==b){
            if(nodos.length==0){
              Fluttertoast.showToast(
                
          msg: "Cree al menos un nodo",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          
          timeInSecForIos: 1,
          backgroundColor: Colors.black.withOpacity(0.7),
          textColor: Colors.white.withOpacity(0.8),
          fontSize: 16.0
              );
            }
            else{
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Tabla(nodos,actividades)));
         
              
            }
            
             }
        }
        break;

      }
      c++;
      }
  }
  void ondragstart(Offset d){
   if(selec.elementAt(2)){
     if(d.dy>ScreenSize.height/5+ScreenSize.height/20&&d.dy<ScreenSize.height-ScreenSize.height/20
        &&d.dx<ScreenSize.width-ScreenSize.width/10&&d.dx>ScreenSize.width/10){
     Nodo aux;
     for(Nodo n in nodos){
       if(n.posNodo.contains(d))
       {
         n.mover(d.dx, d.dy);
         for(Actividad act in actividades){
           if(act.ninicio==n&&act.nfinal==n){
             act.moverigual(d.dx,d.dy);

           }else if(act.ninicio==n)
           {
             act.moverini(d.dx, d.dy);
           }
           else if(act.nfinal==n){
             act.moverfin(d.dx, d.dy);

           }
         }
         break;
       }
     }
   }
  }
  }
  void onTapDon(Offset d){

if(!bloquear)
  {

    if(d.dy>ScreenSize.height/5+ScreenSize.height/20&&d.dy<ScreenSize.height-ScreenSize.height/20
        &&d.dx<ScreenSize.width-ScreenSize.width/15&&d.dx>ScreenSize.width/15){
      if(selec.elementAt(0))
      {
        addnodo(d);
      }
      else{
        if(selec.elementAt(1))
        {
          addactividad(d);

        }
        else{
          if(selec.elementAt(3)){
            borrarop(d);

          }
        }
      }

    }
    else
    {
      limpiarop(d);

    }
  }
  }
  }
  