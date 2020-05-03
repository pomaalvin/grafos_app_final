import 'package:flutter/material.dart';
import 'package:grafos/NorOeste/MainNorOeste.dart';
import 'package:grafos/grafos.dart';

void main() => runApp(MyApp());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
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
                  child:Text('Numero de Filas:'),
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
                  child:Text('Numero de Columnas:'),
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

