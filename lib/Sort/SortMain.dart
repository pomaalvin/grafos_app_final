import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';

class SortMain extends StatefulWidget {
  @override
  _SortMainState createState() => _SortMainState(array);
  List<double> array;
  SortMain(this.array);
}

class _SortMainState extends State<SortMain> {
  List<double> array;
  List<double> arraysel=List();
  List<double> arrayins=List();
  List<double> arrayshe=List();
  List<double> arraymer=List();
  List<List<int>> pasSelection=List();
  List<List<int>> pasInsertion=List();
  List<List<int>> pasShell=List();
  int Selactivecon1=-1;
  int Selactivecon2=-1;
  int Selactiveconok1=-1;
  int Selactiveconok2=-1;
  int Insactivecon1=-1;
  int Insactivecon2=-1;
  int Insactiveconok1=-1;
  int Insactiveconok2=-1;
  int Sheactivecon1=-1;
  int Sheactivecon2=-1;
  int Sheactiveconok1=-1;
  int Sheactiveconok2=-1;
  int Mergeact=-1;
  int Mergeinact=-1;
  _SortMainState(this.array);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(double dato in array){
      arraysel.add(dato);
      arrayins.add(dato);
      arrayshe.add(dato);
      arraymer.add(dato);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size ScreenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: ScreenSize.height/10,
              width: ScreenSize.width,
              color: Colors.blueGrey,
              child: Row(
                children: <Widget>[
                  Container(
                      width:ScreenSize.width*0.8,
                      child: Center(child: Text("Sort",style: TextStyle(color: Colors.white,fontFamily: 'CenturyGothic',fontSize: ScreenSize.width*0.035),),
                      )
                  ),
                  Container(
                    width:ScreenSize.width*0.2,
                    padding: EdgeInsets.only(left: (ScreenSize.width*0.2-ScreenSize.width/9)/2,right: (ScreenSize.width*0.2-ScreenSize.width/9)/2),

                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                      minWidth: ScreenSize.width/9,
                      height: ScreenSize.width/9,
                      color: Colors.green,
                      child: Center(heightFactor: 1,child: Icon(Icons.keyboard_backspace,color: Color(0xff323031),),),
                    ),
                  )
                ],
              )
          ),
          Container(
            width: ScreenSize.width,
            height: ScreenSize.height*0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width:ScreenSize.width*0.2,
                  padding: EdgeInsets.all(0.6),

                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      pasSelection.clear();
                      selectionSort(arraysel);
                      volverArray(arraysel);
                      cambiarNodoSel(0,false,arraysel,"Sel",pasSelection);

                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                    minWidth: ScreenSize.width/9,
                    height: ScreenSize.width/9,
                    color: Color(0xff1BB377),
                    child: Center(heightFactor: 1,child: Text("Selection",style: TextStyle(color: Color(0xff323031))),),
                  ),
                ),
                Container(
                  width:ScreenSize.width*0.2,
                  padding: EdgeInsets.all(0.6),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      pasInsertion.clear();
                      insertionSort(arrayins);
                      volverArray(arrayins);
                      print(pasInsertion);
                      cambiarNodoSel(0,false,arrayins,"Ins",pasInsertion);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                    minWidth: ScreenSize.width/9,
                    height: ScreenSize.width/9,
                    color: Color(0xff1BB377),
                    child: Center(heightFactor: 1,child: Text("Insertion",style: TextStyle(color: Color(0xff323031))),),
                  ),
                ),Container(
                  width:ScreenSize.width*0.2,
                  padding: EdgeInsets.all(0.6),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      pasShell.clear();
                      print(shellSort(arrayshe));
                      volverArray(arrayshe);
                      print(pasShell);
                      cambiarNodoSel(0,false,arrayshe,"She",pasShell);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                    minWidth: ScreenSize.width/9,
                    height: ScreenSize.width/9,
                    color: Color(0xff1BB377),
                    child: Center(heightFactor: 1,child: Text("Shell",style: TextStyle(color: Color(0xff323031)),),),
                  ),
                ),Container(
                  width:ScreenSize.width*0.2,
                  padding: EdgeInsets.all(0.6),
                  child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    onPressed: (){
                      setState(() {
                        colorMerge();
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ScreenSize.width/18))),
                    minWidth: ScreenSize.width/9,
                    height: ScreenSize.width/9,
                    color: Color(0xff1BB377),
                    child: Center(heightFactor: 1,child: Text("Merge",style: TextStyle(color: Color(0xff323031)),),),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: ScreenSize.width,
            height: ScreenSize.height*0.8,
            child: Zoom(
              width: ScreenSize.width*4,
              height: ScreenSize.height*0.8*4,
              scrollWeight: 1,
              initZoom: 0,
              zoomSensibility: 10,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: ScreenSize.width*0.08),
                      height: 60,
                      width: ScreenSize.width,
                      child: Center(
                        child: Text('Selection Sort:',style: TextStyle(fontSize: ScreenSize.width*0.08),),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: arraysel.asMap().entries.map((valor){
                          return AnimatedContainer(
                            width: ScreenSize.width/5,
                            height: ScreenSize.width/5,
                            duration: Duration(milliseconds:100),
                            decoration: BoxDecoration(color: valor.key==Selactivecon1||valor.key==Selactivecon2?Colors.redAccent:valor.key==Selactiveconok1||valor.key==Selactiveconok2?Colors.green:Colors.blueAccent,border:Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(valor.value.toString(),style: TextStyle(fontSize: ScreenSize.width*0.08),),
                            ),
                          );
                        }).toList()
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenSize.width*0.08),
                      height: 60,
                      width: ScreenSize.width,
                      child: Center(
                        child: Text('Insertion Sort:',style: TextStyle(fontSize: ScreenSize.width*0.08),),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: arrayins.asMap().entries.map((valor){
                          return AnimatedContainer(
                            width: ScreenSize.width/5,
                            height: ScreenSize.width/5,
                            duration: Duration(milliseconds: 100),
                            decoration: BoxDecoration(color: valor.key==Insactivecon1||valor.key==Insactivecon2?Colors.redAccent:valor.key==Insactiveconok1||valor.key==Insactiveconok2?Colors.green:Colors.blueAccent,border:Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(valor.value.toString(),style: TextStyle(fontSize: ScreenSize.width*0.08),),
                            ),
                          );
                        }).toList()
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenSize.width*0.08),
                      height: 60,
                      width: ScreenSize.width,
                      child: Center(
                        child: Text('ShellSort:',style: TextStyle(fontSize: ScreenSize.width*0.08),),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: arrayshe.asMap().entries.map((valor){
                          return AnimatedContainer(
                            width: ScreenSize.width/5,
                            height: ScreenSize.width/5,
                            duration: Duration(milliseconds: 100),
                            decoration: BoxDecoration(color: valor.key==Sheactivecon1||valor.key==Sheactivecon2?Colors.redAccent:valor.key==Sheactiveconok1||valor.key==Sheactiveconok2?Colors.green:Colors.blueAccent,border:Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(valor.value.toString(),style: TextStyle(fontSize: ScreenSize.width*0.08),),
                            ),
                          );
                        }).toList()
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenSize.width*0.08),
                      height: 60,
                      width: ScreenSize.width,
                      child: Center(
                        child: Text('MergeSort:',style: TextStyle(fontSize: ScreenSize.width*0.08),),
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: arraymer.asMap().entries.map((valor){
                          return AnimatedContainer(
                            width: ScreenSize.width/5,
                            height: ScreenSize.width/5,
                            duration: Duration(milliseconds: 100),
                            decoration: BoxDecoration(color: Mergeact!=-1?Colors.green:Colors.blueAccent,border:Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(valor.value.toString(),style: TextStyle(fontSize: ScreenSize.width*0.08),),
                            ),
                          );
                        }).toList()
                    )
                  ],
                )
              ),
            ),
          ),
        ],
      )
    );
  }
  colorMerge(){
    if(Mergeact==-1){
    setState(() {
      Mergeact=1;
      mergeFut();
    });
    }
    else{
      mergeSort(arraymer, 0, arraymer.length-1);
      setState(() {
        Mergeact=-1;

      });
    }

  }
  Future mergeFut()async{
    Completer c=Completer();
    Timer(Duration(milliseconds: 1000),(){
        c.complete(colorMerge()
        );
    });
  }
  volverArray(arrayvolver){
    arrayvolver.clear();
    for(double dat in array){
      arrayvolver.add(dat);
    }
  }
  shellSort(List list) {
    if (list == null || list.length == 0)
    {
      print('Error en lista');
    }else{
      int n = list.length;
      int h=(n/1.3).truncate();
      while(h>=1){
          for(int j=h; j<n; j++) {
            pasShell.add([j,j-h]);
            if(less(list[j],list[j-h]))
            swap(list,j,j-h);

          }
        h=(h/1.3).truncate();
        print(h);
      }
      return list;
    }
  }
//Shell Sort
//Comparador si es menor o no xdxd.
  bool less(double v, double w ){
    if(v < w) {
      return true;
    }else{
      return false;
    }
  }
  insertionSort(List list) {
    if (list == null || list.length == 0)
    {
      print('Error en lista');
    }else{
      int n = list.length;
      double temp;
      int  tempi,i, j;

      for(i=1; i< n; i++) {
        temp = list[i];
        tempi=i;
        j=i-1;
        while(j >= 0 && temp < list[j]) {
          pasInsertion.add([tempi,j]);
          list[j+1] = list[j];
          --j;
          tempi--;
        }
        if(j>=0)
          pasInsertion.add([tempi,j]);
        list[j+1] = temp;
        print("aqui 2 j="+list[i].toString()+" i="+list[j+1].toString());
      }
      return list;
    }
  }
  Future avanzarSel(int pos,swapt,array,tipo,pasSelection)async{
    Completer c = Completer();
    Timer(Duration(milliseconds: 500
    ), (){


          if(swapt){
            if (pos != pasSelection.length - 1) {
            c.complete(cambiarNodoSel(pos+1,false,array,tipo,pasSelection));}
            else{
              setState(() {
                switch(tipo){
                  case "Sel":
                    Selactiveconok1=-1;
                    Selactiveconok2=-1;
                    Selactivecon1=-1;
                    Selactivecon2=-1;
                    break;
                  case "Ins":
                    Insactiveconok1=-1;
                    Insactiveconok2=-1;
                    Insactivecon1=-1;
                    Insactivecon2=-1;
                    break;
                  case "She":
                    Sheactiveconok1=-1;
                    Sheactiveconok2=-1;
                    Sheactivecon1=-1;
                    Sheactivecon2=-1;
                    break;
                }
              });
            }

          }else {
            bool ver;
            switch(tipo){
              case "Sel":
                ver=array[pasSelection[pos][0]] > array[pasSelection[pos][1]];
                break;
              case "Ins":
                ver=array[pasSelection[pos][0]] < array[pasSelection[pos][1]];
                break;
              case "She":
                ver=array[pasSelection[pos][0]] < array[pasSelection[pos][1]];
                break;
            }
            if (ver) {
              c.complete(cambiarNodoSel(pos, true,array,tipo,pasSelection));
            }
            else {
              if (pos != pasSelection.length - 1) {
                c.complete(cambiarNodoSel(pos + 1, false,array,tipo,pasSelection));
              }
              else {

                setState(() {
                  switch(tipo){
                    case "Sel":
                      Selactiveconok1=-1;
                      Selactiveconok2=-1;
                      Selactivecon1=-1;
                      Selactivecon2=-1;
                      break;
                    case "Ins":
                      Insactiveconok1=-1;
                      Insactiveconok2=-1;
                      Insactivecon1=-1;
                      Insactivecon2=-1;
                      break;
                    case "She":
                      Sheactiveconok1=-1;
                      Sheactiveconok2=-1;
                      Sheactivecon1=-1;
                      Sheactivecon2=-1;
                      break;
                  }
                });
              }
            }
          }
    });
  }
  cambiarNodoSel(int pos,swap2,array,tipo,pasSelection){
    if(swap2){
      setState(() {
        switch(tipo){
          case "Sel":
            Selactiveconok1=pasSelection[pos][0];
            Selactiveconok2=pasSelection[pos][1];
            Selactivecon1=-1;
            Selactivecon2=-1;
            swap(array, pasSelection[pos][0], pasSelection[pos][1]);
            break;
          case "Ins":
            Insactiveconok1=pasSelection[pos][0];
            Insactiveconok2=pasSelection[pos][1];
            Insactivecon1=-1;
            Insactivecon2=-1;
            swap(array, pasSelection[pos][0], pasSelection[pos][1]);
            break;
          case "She":
            Sheactiveconok1=pasSelection[pos][0];
            Sheactiveconok2=pasSelection[pos][1];
            Sheactivecon1=-1;
            Sheactivecon2=-1;
            swap(array, pasSelection[pos][0], pasSelection[pos][1]);
            break;
        }


        avanzarSel(pos,true,array,tipo,pasSelection);
      });
    }
    else{
      setState(() {
        switch(tipo){
          case "Sel":
            Selactivecon1=pasSelection[pos][0];
            Selactivecon2=pasSelection[pos][1];
            Selactiveconok1=-1;
            Selactiveconok2=-1;
            break;
          case "Ins":
            Insactivecon1=pasSelection[pos][0];
            Insactivecon2=pasSelection[pos][1];
            Insactiveconok1=-1;
            Insactiveconok2=-1;
            break;
          case "She":
            Sheactivecon1=pasSelection[pos][0];
            Sheactivecon2=pasSelection[pos][1];
            Sheactiveconok1=-1;
            Sheactiveconok2=-1;
            break;
        }
        avanzarSel(pos,false,array,tipo,pasSelection);
      });
    }

  }
  selectionSort(List list) {

    if (list == null || list.length == 0) {
      print("error en lista");
    }else{
      int n = list.length;
      int i, steps;
      for (steps = 0; steps < n; steps++) {
        for (i = steps + 1; i < n; i++) {
           setState(() {
             pasSelection.add([steps,i]);
           });

          if(list[steps] > list[i]) {
            swap(list, steps, i);
          }
        }
      }
      return list;
    }
  }

  void swap(List list, int steps, int i) {
     double temp = list[steps];
    list[steps] = list[i];
    list[i] = temp;
  }
  void merge(List list, int leftIndex, int middleIndex, int rightIndex) {
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    List leftList = new List(leftSize);
    List rightList = new List(rightSize);

    for (int i = 0; i < leftSize; i++) leftList[i] = list[leftIndex + i];
    for (int j = 0; j < rightSize; j++) rightList[j] = list[middleIndex + j + 1];

    int i = 0, j = 0;
    int k = leftIndex;

    while (i < leftSize && j < rightSize) {
      if (leftList[i] <= rightList[j]) {
        list[k] = leftList[i];
        i++;
      } else {
        list[k] = rightList[j];
        j++;
      }
      k++;
    }

    while (i < leftSize) {
      list[k] = leftList[i];
      i++;
      k++;
    }

    while (j < rightSize) {
      list[k] = rightList[j];
      j++;
      k++;
    }
  }

  void mergeSort(List list, int leftIndex, int rightIndex) {
    if (leftIndex < rightIndex) {
      int middleIndex = (rightIndex + leftIndex) ~/ 2;
      mergeSort(list, leftIndex, middleIndex);
      mergeSort(list, middleIndex + 1, rightIndex);
      merge(list, leftIndex, middleIndex, rightIndex);
    }
  }
}
