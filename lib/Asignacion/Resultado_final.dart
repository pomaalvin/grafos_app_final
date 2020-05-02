import 'package:flutter/material.dart';
import 'package:grafos/Asignacion/Row_max_min.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class Resultadofinal extends StatefulWidget {
  @override
  _ResultadofinalState createState() => _ResultadofinalState(this.matriz,this.nodos2,this.nodoscol,this.tipo,this.matrizorig);
  Resultadofinal(this.matriz,this.nodoscol,this.nodos2,this.tipo,this.matrizorig);
  List<List<double>> matriz=new List<List<double>>();
  List<List<double>> matrizorig=new List<List<double>>();
  List<String> nodos2;
  List<String> nodoscol;
  String tipo;
}

class _ResultadofinalState extends State<Resultadofinal> {
  void vercero(){
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++){
        if(matriz[i][j]==0){
          int c=-1;
          for(int k=0;k<matriz[i].length;k++){
            if(matriz[i][k]==0||matriz[i][k]==-1010108974578){
              c++;
            }
          }
          if(c==0){
            matriz[i][j]=-1010108974578;
          }
          int c2=-1;
          for(int k=0;k<matriz.length;k++){
            if(matriz[k][j]==0||matriz[k][j]==-1010108974578){
              c2++;
            }
          }
          if(c2==0){
            if(matriz[i][j]!=-1010108974578){
              matriz[i][j]=-1010108974578;
            }
          }
        }
      }
    }
  }
  void vercero2(){
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++){
        if(matriz[i][j]==0){
          int c=-1;
          for(int k=0;k<matriz[i].length;k++){
            if(matriz[i][k]==-1010108974578){
              c++;
            }
          }
          if(c==-1){
            matriz[i][j]=-1010108974578;
          }
          int c2=-1;
          for(int k=0;k<matriz.length;k++){
            if(matriz[i][k]==-1010108974578){
              c2++;
            }
          }
          if(c2==-1){
            if(matriz[i][j]!=-1010108974578){
              matriz[i][j]=-1010108974578;
            }
          }
        }
      }
    }
  }
  List<List<double>> matriz=new List<List<double>>();
  List<List<double>> matriz2=new List<List<double>>();
  List<List<double>> matrizorig=new List<List<double>>();
  List<String> nodos2=List<String>();
  double total=0;
  List<String> nodos22=List<String>();
  List<String> nodoscol=List<String>();
  List<String> nodoscol2=List<String>();
  List<double> min_maxrow=new List<double>();
  ScrollController controller1=ScrollController();
  ScrollController controller2=ScrollController();
  ScrollController controller3=ScrollController();
  String tipo;
  _ResultadofinalState(List<List<double>> this.matriz2,this.nodos22,this.nodoscol2,this.tipo,this.matrizorig);
  @override
  void initState() {
    super.initState();
    for(int i=0;i<this.matriz2.length;i++){
      List<double>aux=new List<double>();
      for(int j=0;j<this.matriz2[i].length;j++){
        if(matriz2[i][j]==-1010108974578){
          aux.add(matrizorig[i][j]*10000000000000+1010108974578);
          total+=matrizorig[i][j];
        }
        else{
          aux.add(matrizorig[i][j]);
        }
      }
      matriz.add(aux);
    }
    for(int i=0;i<this.nodos22.length;i++){
      nodos2.add(nodos22[i]);
    }
    for(int i=0;i<this.nodoscol2.length;i++){
      nodoscol.add(nodoscol2[i]);
    }/*
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++) {
        if(matriz[i][j]%10000000000000==1010108974578){
          int c=0;
          for(int k=0;k<matriz[i].length;k++){
            if(matriz[i][k]%10000000000000==1010108974578){
              c++;
            }
          }
          if(c>1){
            total-=(matriz[i][j]/10000000000000).truncate();
          }
          else{
          int c2=0;
          for(int k=0;k<matriz[k].length;k++) {
            if(matriz[k][j]%10000000000000==1010108974578){
              c2++;
            }
          }
          if(c2>1){
            total-=(matriz[i][j]/10000000000000).truncate();
          }
          }
        }
      }
      }*/
    print(matriz);
  }

  @override
  Widget build(BuildContext context) {

    Size ScreenSize=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( mainAxisAlignment: MainAxisAlignment.center,
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
                      Navigator.pop(this.context);
                      Navigator.pop(this.context);
                      Navigator.pop(this.context);
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
                        width:ScreenSize.width ,
                        child: Center(
                          child:Text(tipo=="min"?"Minimizando":"Maximizando",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width/15,fontWeight: FontWeight.bold,
                          ),

                          ),
                        )
                    ),


                  ])),
          Container(
            height: 100,
            child: Center(
              child: Text('Paso 4',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff084C61)),),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: <Widget>[
              Container(
                  height: ScreenSize.height-ScreenSize.height/5-200,
                  child:Container(
                      padding: EdgeInsets.all(ScreenSize.width/20),
                      height:nodoscol.length>6?(ScreenSize.width-ScreenSize.width/10)+2*ScreenSize.width/20: (ScreenSize.width-ScreenSize.width/10)/7*(nodoscol.length+1)+2*ScreenSize.width/20,
                      width: nodoscol.length>6?(ScreenSize.width-ScreenSize.width/10)/7*5+2*ScreenSize.width/20:(ScreenSize.width-ScreenSize.width/10)/7*nodos2.length+2*ScreenSize.width/20,
                      child: Center(
                          child:HorizontalDataTable(

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
                  )




              ),
              Container(
                color: Color(0xff6B1A6F),
                width: ScreenSize.width,
                height: 100,
                child: Center(
                  child: Text('Total= $total',style: TextStyle(color: Colors.white ,fontSize: ScreenSize.width*0.08)),
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
                color: fila%10000000000000==1010108974578?Colors.red:Color(0xffFFC857)
                ,border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black))),

            child: Center(child: Text(fila%10000000000000==1010108974578?(fila/10000000000000).truncate().toString():fila.toString()),),
            width: (Screen.width-2*Screen.width/20)/(6+1),
            height: (Screen.width-Screen.width/10)/7,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          );
        }).toList()
    );
  }
}
