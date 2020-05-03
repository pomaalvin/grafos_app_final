import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class MainNorOeste extends StatefulWidget {
  @override
  _MainNorOesteState createState() => _MainNorOesteState(numrow,numcol);
  double numcol,numrow;
  MainNorOeste(this.numrow,this.numcol);
}
List<List<TextEditingController>> inputmat=List();
List<TextEditingController> cab=List();
List<TextEditingController> cab2=List();
List<Widget> cabecera(width,heigth){
  return cab.map((valor){
    return Container(
      width: width,
      height: heigth,
      child: TextFormField(
        decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
        initialValue:
        "0",
      ),
    );
  }).toList();
}

class _MainNorOesteState extends State<MainNorOeste> {
  double numcol,numrow;
  _MainNorOesteState(this.numrow,this.numcol);
  @override
  void IniciarMat(){
    TextEditingController aux;
    for(int i=0;i<numrow;i++){
      List<TextEditingController> auxcont;
      for(int j=0;j<numcol;j++){
        aux=TextEditingController();
        aux.text="0.0";
        auxcont.add(aux);
      }
      inputmat.add(auxcont);
    }
  }
  void Iniciarcab(){
    TextEditingController aux=TextEditingController();
    aux.text="";
    cab.add(aux);
    for(int i=0;i<numcol;i++){
      aux=TextEditingController();
      aux.text=(i+1).toString();
      cab.add(aux);
    }
    for(int i=0;i<numrow;i++){
      aux=TextEditingController();
      aux.text="a"+(i+1).toString();
      cab2.add(aux);
    }
  }
  void initState() {

    super.initState();
    Iniciarcab();
    IniciarMat();


  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    double widthder=size.width*0.7-20;
    double widthizq=size.width*0.3;
    return Scaffold(
      body:Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            color:Colors.red,
            width: size.width*0.7,
            child: Center(
              child:Container(
                child:HorizontalDataTable(

                  headerWidgets: cabecera(widthder/(numcol+1),widthder/(numcol+1)),
                  leftSideItemBuilder: cabecera2,
                )
              )
            )
          ),
          Container(
              color:Colors.black38,
            width: size.width*0.3,
          ),
        ],
      )
    );
  }

  Widget cabecera2(context,index){
    var size=MediaQuery.of(context).size;
    double widthder=size.width*0.7-20;
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      width: widthder/(numcol+1),
      height: widthder/(numcol+1),
      child: Text(cab2[index].text)
    );
  }
}
