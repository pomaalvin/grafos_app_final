import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grafos/Asignacion/Asignacion_prin.dart';
import 'package:grafos/Grafos_game.dart';
import 'package:grafos/componentes/Actividad.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'componentes/Nodo.dart';

class Tabla extends StatefulWidget{
List<Nodo> nodos;
List<Actividad> activi ;
LangawGame bloqueo;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createSta
    return _Tabla(nodos,activi,bloqueo);
  }

  Tabla(this.nodos,this.activi,this.bloqueo);

}
class _Tabla extends State<Tabla>{
  List<List<double>> matriz=new List<List<double>>();
  ScrollController controller1=ScrollController();
  ScrollController controller2=ScrollController();
  ScrollController controller3=ScrollController();
  List<Nodo> nodos;
  List<String> nodos2;
  List<String> nodoscol;
  List<Actividad> activi ;
  LangawGame bloqueo;
  _Tabla(this.nodos,this.activi,this.bloqueo);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crearmatriz();




  }
  void crearmatriz(){
    nodos2=nodos.map((nodo)=>(
        nodo.text
    )).toList();
    nodos2.insert(0, "");
    nodoscol=nodos.map((nodo)=>(
        nodo.text
    )).toList();
    for(Nodo nodo in nodos){
      List<double> aux=new List<double>();
      for(Nodo nodo2 in nodos){
        double valor=0;
        for(Actividad act in activi){
          if(act.ninicio==nodo&&act.nfinal==nodo2){
            valor=act.valor;
          }
        }
        aux.add(valor);
      }
      matriz.add(aux);
    }

/*

List<int> filael=new List<int>();
    List<int> colel=new List<int>();
    for(int i=0;i<matriz.length;i++){
      int c=0;
      List<double> aux=new List<double>();
      for(int j=0;j<matriz.length;j++){
        if(matriz[i][j]==0){
          c++;
        }
      }
      if(c==matriz.length){
          filael.add(i-filael.length);
      }
    }
    for(int i=0;i<matriz.length;i++){
      int c=0;
      List<double> aux=new List<double>();
      for(int j=0;j<matriz.length;j++){
        if(matriz[j][i]==0){
          c++;
        }
      }
      if(c==matriz.length){
        colel.add(i-colel.length);
      }
    }
    for(int i=0;i<filael.length;i++)
      {
        matriz.removeAt(filael[i]);
        nodoscol.removeAt(filael[i]);
      }
    for(int i=0;i<colel.length;i++)
    {
      nodos2.removeAt(colel[i]+1);
    }
    for(int i=0;i<colel.length;i++){
      for(int j=0;j<matriz.length;j++){
        matriz[j].removeAt(colel[i]);
      }
    }
* */

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size ScreenSize=MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: ()async{
        setState(() {
          bloqueo.bloqueototal=false;
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              height: ScreenSize.height/10,
              color: Color(0xff084C61),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: MaterialButton(

                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>
                            Asignacion_prin(matriz,nodos2,nodoscol)));
                      },
                      child: Text('Asignacion',style: TextStyle(color: Color(0xff084C61))),
                      color: Color(0xffFFC857),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenSize.height/10-2)),
                    ),
                  )
                ],
              ),
              width: ScreenSize.width,
            ),
            Container(
                color: Color(0xff323031),
                height: ScreenSize.height/10,
                width: ScreenSize.width,
                child: Center(
                    child: Text("Matriz",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width/15,fontWeight: FontWeight.bold,
                    ),
                    ))),
            Container(
              height: ScreenSize.height-ScreenSize.height/5,
              width: ScreenSize.width,
              child:Center(

                  child: Container(
                      padding: EdgeInsets.all(ScreenSize.width/20),
                      height:nodoscol.length>6?(ScreenSize.width-ScreenSize.width/10)+2*ScreenSize.width/20: (ScreenSize.width-ScreenSize.width/10)/7*(nodoscol.length+1)+2*ScreenSize.width/20,
                      width: (ScreenSize.width-ScreenSize.width/10)/7*nodos2.length+2*ScreenSize.width/20,
                      child: HorizontalDataTable(

                        elevationColor: Colors.black,
                        controler1: controller1,
                        controler2: controller2,
                        controler3: controller3,

                        leftHandSideColBackgroundColor: Colors.black,elevation: 10,

                        leftHandSideColumnWidth: (ScreenSize.width-ScreenSize.width/10)/7,
                        rightHandSideColumnWidth:(ScreenSize.width-2*ScreenSize.width/20)/7*(nodos2.length-1),
                        isFixedHeader: true,

                        rightSideItemBuilder: _datos,
                        itemCount: nodoscol.length,
                        leftSideItemBuilder: _primera_col,
                        headerWidgets:
                        nodos2.map((name)=>Container(
                          decoration:BoxDecoration(
                              color: Color(0xff084C61),border: name!=nodos2.elementAt(0)?Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black),top: BorderSide(color: Colors.black)):Border.all(color: Colors.black)),
                          child: Center(child: Text(name.toUpperCase(),style: TextStyle(color:Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),),),
                          width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                          height: (ScreenSize.width-ScreenSize.width/10)/7,
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,

                        )).toList(),


                      )
                  )
              ),)

          ],
        ),
      ),
    );

  }
  Widget _primera_col(BuildContext context,int index){
    Size Screen=MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
      color: Color(0xff084C61),border: Border(left: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black))),
      child: Center(child: Text(nodoscol.elementAt(index).toUpperCase(),style: TextStyle(color:Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),),),
      width: (Screen.width-2*Screen.width/20)/(6+1),
      height: (Screen.width-Screen.width/10)/7,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
  Widget _datos(BuildContext context,int index){
    Size Screen=MediaQuery.of(context).size;
    return Row(
        children:matriz[index].map((fila){
          return Container(
            decoration: BoxDecoration(
      color: Color(0xffFFC857),border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black))),
     
            child: Center(child: Text(fila.toString()),),
            width: (Screen.width-2*Screen.width/20)/(6+1),
            height: (Screen.width-Screen.width/10)/7,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          );
        }).toList()
    );
  }

}