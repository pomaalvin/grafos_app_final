import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class Row_max_min extends StatefulWidget {
  @override
  _Row_max_minState createState() => _Row_max_minState(this.matriz,this.nodos2,this.nodoscol,this.tipo,this.min_maxcol);
  Row_max_min(this.matriz,this.nodoscol,this.nodos2,this.tipo,this.min_maxcol);
  List<List<double>> matriz=new List<List<double>>();
  List<String> nodos2;
  List<String> nodoscol;
  String tipo;
  List<double> min_maxcol=new List<double>();
}

class _Row_max_minState extends State<Row_max_min> {
  List<List<double>> matriz2=new List<List<double>>();
  List<List<double>> matriz=new List<List<double>>();
  List<String> nodos2=List<String>();
  List<String> nodoscol=List<String>();
  List<double> min_maxcol=new List<double>();
  List<double> min_maxrow=new List<double>();
  ScrollController controller1=ScrollController();
  ScrollController controller2=ScrollController();
  ScrollController controller3=ScrollController();
  ScrollController controlleraux2=ScrollController();
  ScrollController controlleraux3=ScrollController();
  String tipo;
  _Row_max_minState(List<List<double>> this.matriz2,this.nodos2,this.nodoscol,this.tipo,this.min_maxcol);
  @override
  void initState() {
    controller3.addListener((){
      controlleraux2.jumpTo(controller3.offset);
    });
    controller1.addListener((){
      controlleraux3.jumpTo(controller1.offset);
    });
    List<List<double>> matrizaux=new List<List<double>>();
    for(int i=0;i<this.matriz2.length;i++){
      List<double>aux=new List<double>();
      for(int j=0;j<this.matriz2.length;j++){
        aux.add(matriz2[i][j]-min_maxcol[j]);
      }
      matrizaux.add(aux);
    }
    for(int i=0;i<matrizaux.length;i++){
      List<double>aux=new List<double>();
      for(int j=0;j<matrizaux.length;j++){
        aux.add(matrizaux[i][j]);
      }
      matriz.add(aux);
    }
    for(int i=0;i<matriz.length;i++){
      matrizaux[i].sort();
    }
    for(int i=0;i<this.matriz.length;i++){
      if(tipo=="max"){
        min_maxrow.add(matrizaux[i][matrizaux.length-1]);
      }
      else{
        min_maxrow.add(matrizaux[i][0]);
      }
    }
    print(min_maxrow);
  }
  ScrollController contlist=new ScrollController();
  @override
  Widget build(BuildContext context) {

    Size ScreenSize=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: ScreenSize.height/10,
            color: Color(0xff6B1A6F),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: MaterialButton(

                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text('Volver',style: TextStyle(color: Color(0xff084C61))),
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
              child: Row(
                  children: [
                    Container(
                        width:ScreenSize.width*0.8 ,
                        child: Center(
                          child:Text("Matriz",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width/15,fontWeight: FontWeight.bold,
                          ),

                          ),
                        )
                    ),

                    Container(
                      padding: EdgeInsets.all(15),
                      width: ScreenSize.width*0.2,
                      child: MaterialButton(
                        padding: EdgeInsets.all(1),
                        height: ScreenSize.height/10-5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenSize.height)),
                        onPressed: (){

                        },
                        color: Color(0xffFFC857),
                        child: Icon(Icons.arrow_forward,color: Color(0xff084C61),size: ScreenSize.width*0.07),
                      ),
                    ),
                  ])),
          Row(
            children: <Widget>[
              Container(
                height: ScreenSize.height-ScreenSize.height/5,
                width: ScreenSize.width*0.75,
                child:Center(

                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onHorizontalDragUpdate: (drag){
                            contlist.jumpTo(205);
                          },
                          child:Container(
                              padding: EdgeInsets.all(ScreenSize.width/20),
                              height:nodoscol.length>6?(ScreenSize.width-ScreenSize.width/10)+2*ScreenSize.width/20: (ScreenSize.width-ScreenSize.width/10)/7*(nodoscol.length+1)+2*ScreenSize.width/20,
                              width: (ScreenSize.width-ScreenSize.width/10)/7*5+2*ScreenSize.width/20,
                              child: ScrollConfiguration(
                                behavior: ScrollBehavior(),
                                child: GlowingOverscrollIndicator(
                                  color: Color(0xff084C61),
                                  axisDirection: AxisDirection.right,
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


                                  ),
                                ),
                              )
                          ),),

                        Container(
                            padding: EdgeInsets.all(ScreenSize.width/20),

                            height: (ScreenSize.width-ScreenSize.width/10)/7+ScreenSize.width/10,
                            width: (ScreenSize.width-ScreenSize.width/10)/7*5+2*ScreenSize.width/20,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color:Color(0xff6F1A53),border: Border.all(color: Colors.black)),

                                  child: Center(child: Text(tipo,style: TextStyle(color:Colors.white),),),
                                  width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                                  height: (ScreenSize.width-ScreenSize.width/10)/7,
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                )
                                ,
                                Container(
                                  width: (ScreenSize.width-ScreenSize.width/10)/7*5+2*ScreenSize.width/20-(ScreenSize.width-2*ScreenSize.width/20)/(6+1)-41,
                                  child: ListView(

                                      controller: controlleraux2,
                                      scrollDirection: Axis.horizontal,
                                      children: min_maxcol.map((valor){
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: valor==-45465465?Color(0xff6F1A53):Color(0xffFFC857),border: Border.all(color: Colors.black)),

                                          child: Center(child: Text(valor==-45465465?tipo:valor.toString(),style: TextStyle(color: valor==-45465465?Colors.white:Colors.black),),),
                                          width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                                          height: (ScreenSize.width-ScreenSize.width/10)/7,
                                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          alignment: Alignment.centerLeft,
                                        );
                                      }).toList()
                                  ),
                                ),

                              ],
                            )
                        ),




                      ],
                    )
                ),

              ),
              Container(
                height: ScreenSize.height-ScreenSize.height/5,
                width: ScreenSize.width*0.25,
                child:Container(
                    padding: EdgeInsets.all(ScreenSize.width/20),

                    height: (ScreenSize.width-ScreenSize.width/10)/7+ScreenSize.width/10,
                    width: (ScreenSize.width-ScreenSize.width/10)/7*5+2*ScreenSize.width/20,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color:Color(0xff6F1A53),border: Border.all(color: Colors.black)),

                          child: Center(child: Text(tipo,style: TextStyle(color:Colors.white),),),
                          width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                          height: (ScreenSize.width-ScreenSize.width/10)/7,
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                        )
                        ,
                        Container(
                          height: (ScreenSize.width-ScreenSize.width/10)/7*6+2*ScreenSize.width/20-(ScreenSize.width-2*ScreenSize.width/20)/(6+1)-41,
                          width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                          child: ListView(

                              controller: controlleraux3,
                              children: min_maxrow.map((valor){
                                return Container(
                                  decoration: BoxDecoration(
                                      color: valor==-45465465?Color(0xff6F1A53):Color(0xffFFC857),border: Border(left: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black),right: BorderSide(color: Colors.black))),

                                  child: Center(child: Text(valor==-45465465?tipo:valor.toString(),style: TextStyle(color: valor==-45465465?Colors.white:Colors.black),),),
                                  width: (ScreenSize.width-2*ScreenSize.width/20)/(6+1),
                                  height: (ScreenSize.width-ScreenSize.width/10)/7,
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                );
                              }).toList()
                          ),
                        ),

                      ],
                    )
                ),
              )
            ],
          )

        ],
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
                color: Color(0xffFFC857)
                ,border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black))),

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
