import 'package:flutter/material.dart';
import 'package:grafos/Arboles/Arboles_main.dart';
import 'package:grafos/Cournot/Cournot_main.dart';
import 'package:grafos/NorOeste/MainNorOeste.dart';
import 'package:grafos/grafos.dart';

void main() => runApp(MyApp());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _AlertCournot extends StatefulWidget {
  @override
  __AlertCournotState createState() => __AlertCournotState();
}

class __AlertCournotState extends State<_AlertCournot> {
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }
    final formkey=GlobalKey<FormState>();
    TextEditingController lista=new TextEditingController();
    TextEditingController x=new TextEditingController();
    TextEditingController y=new TextEditingController();
    String valor="";
    List<List<double>> arraypunt=new List();
    @override
  Widget build(BuildContext context) {
      var size=MediaQuery.of(context).size;
    return AlertDialog(

          title: Text('Algoritmo Cournot'),
          content: Form(
            key: formkey,
            child: Container(
              height: size.height*0.3,
              width: size.width,
              child: ListView(
                children: <Widget>[
                  Container(
                    child:Text('Array puntos:'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: size.width,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.5),width: 1),borderRadius: BorderRadius.all(Radius.circular(size.height*0.0125))),
                    height: size.height*0.05,
                    child:
                    ListView(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      children: <Widget>[
                        Container(
                            padding:EdgeInsets.only(left: 8,right: 8),

                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(valor,style: TextStyle(color: Color(0xff23615C)),),
                              ],
                            )
                        )
                      ],
                    )
                    ,
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: size.width*0.2,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38),borderRadius: BorderRadius.all(Radius.circular(5)))),
                          keyboardType: TextInputType.number,
                          controller: x,
                          focusNode: myFocusNode,
                          validator: (val){
                            if(val.isEmpty){
                              return " ";
                            }
                            else
                              return null;
                          },
                        ),
                      ),
                      VerticalDivider(
                          width: size.width*0.02
                      ),
                      Container(
                        width: size.width*0.2,
                        child: TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38),borderRadius: BorderRadius.all(Radius.circular(5)))),
                          keyboardType: TextInputType.number,
                          controller: y,
                          validator: (val){
                            if(val.isEmpty){
                              return " ";
                            }
                            else
                              return null;
                          },
                        ),
                      ),
                      VerticalDivider(
                        width: size.width*0.05,
                      ),
                      Container(
                        width: size.width*0.20,
                        child: MaterialButton(
                          child: Text('Add'),
                          padding: EdgeInsets.all(2),
                          color: Colors.teal,
                          onPressed: (){
                            if(x.text.isNotEmpty&&y.text.isNotEmpty){
                              setState(() {
                                arraypunt.add([double.parse(x.text),double.parse(y.text)]);
                                valor+="["+x.text+","+y.text+"], ";
                                x.text="";
                                y.text="";
                                myFocusNode.requestFocus();
                              });
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 20,
                  ),
                  Container(
                    child: MaterialButton(
                      child: Text('Aceptar'),
                      color: Colors.blueAccent,
                      onPressed: (){
                        FocusScope.of(context).requestFocus(new FocusNode());
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Main_Cournot(arraypunt)));

                      },
                    ),
                  )
                ],
              ),
            ),
          )
      );
  }
}


class _MainState extends State<Main> {

  Widget AlertArboles(formkey,TextEditingController lista,size){
    return AlertDialog(
        title: Text('Algoritmo NorOeste'),
        content: Form(
          key: formkey,
          child: Container(
            height: size.height*0.3,
            width: size.width,
            child: ListView(
              children: <Widget>[
                Container(
                  child:Text('Array(Numeros separados por ","):'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38),borderRadius: BorderRadius.all(Radius.circular(5)))),

                  keyboardType: TextInputType.number,
                  controller: lista,
                  validator: (val){
                    if(val.isEmpty){
                      return "Ingrese un valor";
                    }
                    else
                      return null;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                Container(
                  child: MaterialButton(
                    child: Text('Aceptar'),
                    color: Colors.blueAccent,
                    onPressed: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if(formkey.currentState.validate()){
                        List<String> strlista=lista.text.split(",");
                        List<double> splitlista=new List();
                        for(String str in strlista){
                          if(!splitlista.contains(double.parse(str)))
                            splitlista.add(double.parse(str));
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Main_Arboles(splitlista)));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  Widget AlertNorOeste(formkey,numrow,numcol,size){
    return AlertDialog(
        title: Text('Algoritmo NorOeste'),
        content: Form(
          key: formkey,
          child: Container(
            height: size.height*0.3,
            width: size.width,
            child: ListView(
              children: <Widget>[
                Container(
                  child:Text('Numero de Columnas:'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38),borderRadius: BorderRadius.all(Radius.circular(5)))),

                  keyboardType: TextInputType.number,
                  controller: numrow,
                  validator: (val){
                    if(val.isEmpty){
                      return "Ingrese un valor";
                    }
                    else
                    if(double.parse(val)<=0)
                      return "El valor debe ser positivo y diferente de 0";
                    else
                      return null;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                Container(
                  child:Text('Numero de Filas:'),
                ),TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38),borderRadius: BorderRadius.all(Radius.circular(5)))),
                    keyboardType: TextInputType.number,
                    controller: numcol,
                    validator: (val){
                      if(val.isEmpty){
                        return "Ingrese un valor";
                      }
                      else
                      if(double.parse(val)<=0)
                        return "El valor debe ser positivo y diferente de 0";
                      else
                        return null;
                    },
                  ),
                Divider(
                  color: Colors.transparent,
                  height: 20,
                ),
                Container(
                  child: MaterialButton(
                    child: Text('Aceptar'),
                    color: Colors.blueAccent,
                    onPressed: (){
                       FocusScope.of(context).requestFocus(new FocusNode());
                      if(formkey.currentState.validate()){

                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>MainNorOeste(double.parse(numcol.text),double.parse(numrow.text))));
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  color: Colors.black.withOpacity(0.8),
                  height: size.height*0.5-80,
                ),
                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child:Image.asset("assets/icono2.png",width: size.width*0.5,height: size.height*0.5-80,)
                        ),
                        Divider(
                          height: 80,
                          color: Colors.transparent,
                        ),
                        Container(
                          height: size.height*0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: MaterialButton(
                                  color: Colors.blueGrey,
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Grafos()));
                                  },
                                  child: Text('Grafos',style: TextStyle(color: Colors.white),),
                                ),
                              ),Center(
                                child: MaterialButton(
                                  color: Colors.indigo,
                                  onPressed: (){
                                    TextEditingController numcol=TextEditingController();
                                    TextEditingController numrow=TextEditingController();
                                    final formkey=GlobalKey<FormState>();
                                    showDialog(context: context,
                                        builder: (BuildContext context){
                                          return AlertNorOeste(formkey,numcol,numrow,size);
                                        }
                                    );

                                  },
                                  child: Text('Nor Oeste',style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              Center(
                                child: MaterialButton(
                                  color: Colors.cyan,
                                  onPressed: (){
                                    TextEditingController lista=TextEditingController();
                                    final formkeylista=GlobalKey<FormState>();
                                    showDialog(context: context,
                                        builder: (BuildContext context){
                                          return AlertArboles(formkeylista, lista, size);
                                        }
                                    );
                                    },
                                  child: Text('Arboles',style: TextStyle(color: Colors.black),),
                                ),
                              ),
                              Center(
                                child: MaterialButton(
                                  color: Color(0xff5846DB),
                                  onPressed: (){
                                    showDialog(context: context,
                                        builder: (BuildContext context){
                                          return _AlertCournot()
                                          ;
                                        }
                                    );
                                  },
                                  child: Text('Cournot',style: TextStyle(color: Colors.black),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
                Positioned(
                    bottom: 10,
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Text('Grafos-2020',style: TextStyle(color: Colors.black38),),
                      ),
                    )
                )
              ],
            )
          ],
        ),
      )
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Main()
    );
  }
}

