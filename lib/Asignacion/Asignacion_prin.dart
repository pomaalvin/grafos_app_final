import 'package:flutter/material.dart';
import 'package:grafos/Asignacion/Column_MaxMin.dart';
import 'package:grafos/componentes/Nodo.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class Asignacion_prin extends StatefulWidget {

  @override
  _Asignacion_prinState createState() => _Asignacion_prinState(matriz,nodos2,nodoscol);
  Asignacion_prin(this.matriz,this.nodos2,this.nodoscol);
  List<List<double>> matriz=new List<List<double>>();
  List<String> nodos2;
  List<String> nodoscol;
}

class _Asignacion_prinState extends State<Asignacion_prin> {
  List<List<double>> matriz=new List<List<double>>();
  List<String> nodos2=List<String>();
  List<String> nodoscol=List<String>();
  ScrollController controller1=ScrollController();
  ScrollController controller2=ScrollController();
  ScrollController controller3=ScrollController();
  _Asignacion_prinState(List<List<double>> matriz,nodos2,nodoscol){
    for(int i=0;i<matriz.length;i++){
      List<double> aux=new List<double>();
      for(int j=0;j<matriz[0].length;j++){
        aux.add(matriz[i][j]);
      }
      this.matriz.add(aux);
    }
    for(int i=0;i<nodos2.length;i++){
      this.nodos2.add(nodos2[i]);
    }
    for(int i=0;i<nodoscol.length;i++){
      this.nodoscol.add(nodoscol[i]);
    }
  }
  @override
  void initState() {
    super.initState();

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
    print(matriz);
    print(matriz.length);
    print(matriz[0].length);
    if(matriz.length<matriz[0].length){
      int tam=matriz[0].length-matriz.length;
      for(int i=0;i<tam;i++){
        List<double> aux=new List<double>();
        for(int j=0;j<matriz[0].length;j++){
            aux.add(0);
        }
        matriz.add(aux);
        nodoscol.add("AU"+(i+1).toString());
      }
    }
    else if(matriz.length>matriz[0].length){
      int tamcol=matriz.length-matriz[0].length;
      for(int i=0;i<matriz.length;i++){

        for(int j=0;j<tamcol;j++){
          if(i==0){
            nodos2.add("AU"+(j+1).toString());
          }
          print(j);
          matriz[i].add(0);
        }
      }
    }
    print(matriz);
  }
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
                      width:ScreenSize.width*0.6 ,
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Col_max_min(matriz,nodoscol,nodos2,"min")));
                        },
                        color: Color(0xffFFC857),
                        child: Text('Min',style: TextStyle(color: Color(0xff084C61),fontSize: ScreenSize.width*0.04),),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(15),
                      width: ScreenSize.width*0.2,
                      child: MaterialButton(
                        padding: EdgeInsets.all(1),
                        height: ScreenSize.height/10-5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenSize.height)),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Col_max_min(matriz,nodoscol,nodos2,"max")));

                        },
                        color: Color(0xffFFC857),
                        child: Text('Max',style: TextStyle(color: Color(0xff084C61),fontSize: ScreenSize.width*0.04),),
                      ),
                    ),
                  ])),
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

                      leftHandSideColBackgroundColor: Colors.black,elevation: 10,
                      controler1: controller1,
                      controler2: controller2,
                      controler3: controller3,

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
            ),

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
