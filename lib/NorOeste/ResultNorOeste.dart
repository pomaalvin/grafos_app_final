import 'package:flutter/material.dart';
import 'package:grafos/NorOeste/NorOeste.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class ResultNorOeste extends StatefulWidget {
  @override
  _ResultNorOesteState createState() => _ResultNorOesteState(cab1,cab2,inputmat,dema,disp,result.toString());

  List<List<TextEditingController>> inputmat=List();
  List<TextEditingController> cab1=List();
  List<TextEditingController> cab2=List();
  List<TextEditingController> dema=List();
  List<TextEditingController> disp=List();
  double result;
  ResultNorOeste(this.cab1,this.cab2,this.inputmat,this.dema,this.disp,this.result);
}


class _ResultNorOesteState extends State<ResultNorOeste> {
  List<List<TextEditingController>> inputmat=List();
  List<TextEditingController> cab=List();
  List<TextEditingController> cab2=List();
  List<TextEditingController> dema=List();
  List<TextEditingController> disp=List();
  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  ScrollController controller3 = ScrollController();
  ScrollController controlleraux2 = ScrollController();
  String resultado;
  _ResultNorOesteState(this.cab,this.cab2,this.inputmat,this.dema,this.disp,this.resultado);

  @override

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  void initState() {

    super.initState();
    controller3.addListener((){
      controlleraux2.jumpTo(controller3.offset);
    });


  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    double widthder=size.width*0.8-20;
    double widthizq=size.width*0.2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
        ),
        body:Container(
          child: ListView(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height*0.8,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              height: size.width*0.8,
                              width: size.width*0.8,
                              child: Center(
                                  child:Container(
                                      child:HorizontalDataTable(
                                        itemCount: cab2.length,
                                        leftHandSideColumnWidth: widthder/(4+1),
                                        rightHandSideColumnWidth: widthder/(4+1)*inputmat[0].length,
                                        rightSideItemBuilder: _datos,
                                        isFixedHeader: true,
                                        headerWidgets: cab.map((valor)=>Container(
                                          color: Color(0xff247BA0),
                                          width: widthder/(4+1),
                                          height: widthder/(4+1),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            minLines: null,
                                            decoration: InputDecoration(contentPadding: EdgeInsets.all(5),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                                            controller: valor,
                                          ),
                                        )
                                        ).toList(),
                                        leftSideItemBuilder: cabecera2,
                                        controler1: controller1,
                                        controler2: controller2,
                                        controler3: controller3,
                                      )
                                  )
                              )
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              height: widthder/(4+1)+20,
                              width: size.width*0.8,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color:Color(0xff70C1B3),border: Border.all(color: Colors.black)),

                                    child: Center(child: Text("DE",style: TextStyle(color:Colors.black),),),
                                    width: widthder/(4+1),
                                    height: widthder/(4+1),
                                    alignment: Alignment.centerLeft,
                                  )
                                  ,
                                  Container(
                                    width: widthder-widthder/(4+1),
                                    child: ListView(

                                        controller: controlleraux2,
                                        scrollDirection: Axis.horizontal,
                                        children: dema.map((valor){
                                          return Container(
                                            color:  Color(0xffF3FFBD),
                                            width: widthder/(4+1),
                                            height: widthder/(4+1),
                                            child: TextFormField(
                                              expands: true,
                                              maxLines: null,
                                              keyboardType: TextInputType.number,
                                              minLines: null,
                                              decoration: InputDecoration(contentPadding: EdgeInsets.all(5),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                                              controller: valor,
                                            ),
                                          );
                                        }).toList()
                                    ),
                                  ),

                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        width: widthder/(4+1)+10,
                        height: widthder+30+widthder/(5),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color:Color(0xff70C1B3),border: Border.all(color: Colors.black)),

                              child: Center(child: Text("DI",style: TextStyle(color:Colors.black),),),
                              width: widthder/(4+1),
                              height: widthder/(4+1),
                              alignment: Alignment.centerLeft,
                            )
                            ,
                            Container(
                              width: widthder/(4+1),
                              height: widthder-widthder/(4+1),
                              child: ListView(

                                  controller: controller1,
                                  children: disp.map((valor){
                                    return Container(
                                      color:  Color(0xffF3FFBD),
                                      width: widthder/(4+1),
                                      height: widthder/(4+1),
                                      child: TextFormField(
                                        expands: true,
                                        keyboardType: TextInputType.number,
                                        maxLines: null,
                                        minLines: null,
                                        decoration: InputDecoration(contentPadding: EdgeInsets.all(5),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                                        controller: valor,
                                      ),
                                    );
                                  }).toList()
                              ),
                            ),

                          ],
                        )
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height*0.1,
                color: Colors.indigo,
                alignment: AlignmentDirectional.center,
                child: Text("Resultado= "+resultado.toString(),style: TextStyle(color: Colors.white,fontSize: 25),),

              )
            ],
          ),
        )
    );
  }

  Widget cabecera2(context,index){
    var size=MediaQuery.of(context).size;
    double widthder=size.width*0.8-20;
    return Container(
      color: Color(0xff247BA0),
      width: widthder/(4+1),
      height: widthder/(4+1),
      child:
      TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(contentPadding: EdgeInsets.all(5),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
        controller: cab2[index],
      ),
    );
  }
  Widget _datos(BuildContext context,int index){
    var size=MediaQuery.of(context).size;
    double widthder=size.width*0.8-20;
    return Row(
        children:inputmat[index].map((fila){
          return Container(

            color:  Color(0xffB2DBBF),

            child:
            TextFormField(
              expands: true,
              maxLines: null,
              minLines: null,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(contentPadding: EdgeInsets.all(5),border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              controller: fila,
            ),
            width: (widthder)/(4+1),
            height: (widthder)/(4+1),
          );
        }).toList()
    );
  }
}
