import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:grafos/Asignacion/Resultado_final.dart';
import 'package:grafos/Asignacion/Row_max_min.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState(this.matriz,this.nodos2,this.nodoscol,this.tipo,this.min_maxrow,this.direct);
  Resultado(this.matriz,this.nodoscol,this.nodos2,this.tipo,this.min_maxrow,this.matrizorig,this.direct);
  List<List<double>> matriz=new List<List<double>>();
  List<List<double>> matrizorig=new List<List<double>>();
  List<double> min_maxrow=new List<double>();
  List<String> nodos2;
  List<String> nodoscol;
  String tipo;
  bool direct;
}

class _ResultadoState extends State<Resultado> {
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
            int k1=0;
            for(int k=0;k<matriz.length;k++){
              if(matriz[k][j]==-1010108974578){
                k1++;
              }
            }
            if(c==0&&k1==0){
              matriz[i][j]=-1010108974578;
            }
            int c2=-1;
            for(int k=0;k<matriz.length;k++){
              if(matriz[k][j]==0||matriz[k][j]==-1010108974578){
                c2++;
              }
            }
            int k2=0;
            for(int k=0;k<matriz[i].length;k++){
              if(matriz[i][k]==-1010108974578){
                k2++;
              }
            }
            if(c2==0&&k2==0){
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
          int c2=-1;
          for(int k=0;k<matriz.length;k++){
            if(matriz[k][j]==-1010108974578){
              c2++;
            }
          }
          if(c2==-1&&c==-1){
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
  List<String> nodos2=List<String>();
  List<String> nodos22=List<String>();
  List<String> nodoscol=List<String>();
  List<String> nodoscol2=List<String>();
  List<double> min_maxrow=new List<double>();
  ScrollController controller1=ScrollController();
  ScrollController controller2=ScrollController();
  ScrollController controller3=ScrollController();
  String tipo;
  bool direct;
  _ResultadoState(List<List<double>> this.matriz2,this.nodos22,this.nodoscol2,this.tipo,this.min_maxrow,this.direct);
  @override
  void initState() {
    super.initState();
    for(int i=0;i<this.matriz2.length;i++){
      List<double>aux=new List<double>();
      for(int j=0;j<this.matriz2.length;j++){
        aux.add(matriz2[i][j]-min_maxrow[i]);
      }
      matriz.add(aux);
    }
    for(int i=0;i<this.nodos22.length;i++){
      nodos2.add(nodos22[i]);
    }
    for(int i=0;i<this.nodoscol2.length;i++){
      nodoscol.add(nodoscol2[i]);
    }

    print(nodoscol);
    int el=-1;
    for(int i=0;i<nodoscol.length;i++){
      if(nodoscol[i].length==3){
        el=i;
        break;
      }
    }
    if(el!=-1){

      matriz.removeRange(el, matriz.length);
      nodoscol.removeRange(el, nodoscol.length);
    }
    int el2=-1;
    for(int i=0;i<nodos2.length;i++){
      if(nodos2[i].length==3){
        el2=i-1;
        break;
      }
    }

    if(el2!=-1){
      nodos2.removeRange(el2+1, nodos2.length);
    }
    if(el2>=0){
    for(int i=0;i<matriz.length;i++){

      matriz[i].removeRange(el2, matriz.length);

    }}
    vercero();
    vercero2();
    print(matriz);
    print(nodoscol);
    print(nodos2);
  }

  bool bloquedirect=false;
  @override
  Widget build(BuildContext context) {

    Size ScreenSize=MediaQuery.of(context).size;

    if(direct&&!bloquedirect){
      SchedulerBinding.instance.addPostFrameCallback((_){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Resultadofinal(matriz,nodoscol,nodos2,tipo,widget.matrizorig)));
        setState(() {
          bloquedirect=!bloquedirect;
        });
      });
    }
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
                          child:Text(tipo=="min"?"Minimizando":"Maximizando",style: TextStyle(color: Colors.white,fontSize: ScreenSize.width/15,fontWeight: FontWeight.bold,
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
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Resultadofinal(matriz,nodoscol,nodos2,tipo,widget.matrizorig)));
                        },
                        color: Color(0xffFFC857),
                        child: Icon(Icons.arrow_forward,color: Color(0xff084C61),size: ScreenSize.width*0.07),
                      ),
                    ),


                  ])),
          Container(
            height: 100,
            child: Center(
              child: Text('Paso 3',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(0xff084C61)),),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center
            ,
            children: <Widget>[
              Container(
                  height: ScreenSize.height-ScreenSize.height/5-100,
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
                color: fila==-1010108974578?Colors.red:Color(0xffFFC857)
                ,border: Border(right: BorderSide(color: Colors.black),bottom: BorderSide(color: Colors.black))),

            child: Center(child: Text(fila==-1010108974578?"0":fila.toString()),),
            width: (Screen.width-2*Screen.width/20)/(6+1),
            height: (Screen.width-Screen.width/10)/7,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          );
        }).toList()
    );
  }
}
