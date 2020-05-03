import 'dart:io';

import 'package:flame/game.dart';

class NorOeste{
  List<double> demanda = new List();
  String tipo;
  List<double> disponibilidad = new List();
  List<List<double>> matriz = new List<List<double>>();
  NorOeste(this.matriz,this.demanda,this.disponibilidad,this.tipo);
  double operacion() {
    List<List<double>> sol = noroe1(matriz);
    while (true) {
      List<List<double>> solaux = matsol(sol, tipo);
      if (solaux == null) {
        break;
      }
      else {
        sol = solaux;
      }
    }
    print("solfinal:");
    double finalsol=sacardouble(sol);
    print(finalsol);
    return finalsol;
  }
  List<List<String>> quitarnox(matriz){
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++){
        if(matriz[i][j]!="0.0"){
          int cf=0;
          int cc=0;
          for(int k=0;k<matriz.length;k++){
            if(matriz[k][j]!="0.0"||matriz[k][j]=="x"){
              cf++;
            }
          }
          for(int k=0;k<matriz[i].length;k++){
            if(matriz[i][k]!="0.0"||matriz[i][k]=="x"){
              cc++;
            }
          }
          if(cf==1||cc==1){
              matriz[i][j]="0.0";
          }
        }
      }}
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++){
        if(matriz[i][j]!="0.0"){
          int cf=0;
          int cc=0;
          for(int k=0;k<matriz.length;k++){
            if(matriz[k][j]!="0.0"||matriz[k][j]=="x"){
              cf++;
            }
          }
          for(int k=0;k<matriz[i].length;k++){
            if(matriz[i][k]!="0.0"||matriz[i][k]=="x"){
              cc++;
            }
          }
          if(cf==1||cc==1){
            matriz[i][j]="0.0";
          }
        }
      }}
    return matriz;
  }
  List<List<double>> matsol(matrizsol1,tipo){
    List<int> matzimenor=matzmenosor(matrizsol1,tipo);
    if(matzimenor==null){
      return null;
    }
    else{
      List<List<String>> matrizx = List<List<String>>();
      List<List<double>> matrizsol = List();

      for(int i=0;i<matrizsol1.length;i++){
        List<String> auxili=List();
        for(int j=0;j<matrizsol1[i].length;j++){
          auxili.add(matrizsol1[i][j].toString());
        }
        matrizx.add(auxili);
      }
      matrizx[matzimenor[0]][matzimenor[1]]="x";
      matrizx=quitarnox(matrizx);
      List<int> pivot=[matzimenor[0],matzimenor[1]];
      for(int f=0;f<matrizx.length;f++){
        if(matrizx[f][pivot[1]]!="0.0"&&matrizx[f][pivot[1]]!="x"){
          pivot=[f,pivot[1]];
          matrizx[f][pivot[1]]=matrizx[f][pivot[1]]+"-x";
          break;
        }
      }
      bool fin=false;
      bool signo=true;
      print(matrizx);
      print(pivot);
      while(!fin){
        bool encontrado=false;
        for(int i=0;i<matrizx[0].length;i++){
          String val=matrizx[pivot[0]][i];
          if(val=="x"){
            fin=true;
          }
          if(val!="0.0"&&val.substring(val.length-1,val.length)!="x"){
            if(signo){
              matrizx[pivot[0]][i]=matrizx[pivot[0]][i]+"+x";
              pivot=[pivot[0],i];
            }
            else{
              matrizx[pivot[0]][i]=matrizx[pivot[0]][i]+"-x";
              pivot=[pivot[0],i];
            }
            signo=!signo;
            encontrado=true;
          }
        }
        if(!encontrado){
          for(int i=0;i<matrizx.length;i++){
            String val=matrizx[i][pivot[1]];
            if(val=="x"){
              fin=true;
            }
            if(val!="0.0"&&val.substring(val.length-1,val.length)!="x"){
              if(signo){
                matrizx[i][pivot[1]]=matrizx[i][pivot[1]]+"+x";
                pivot=[i,pivot[1]];
              }
              else{
                matrizx[i][pivot[1]]=matrizx[i][pivot[1]]+"-x";
                pivot=[i,pivot[1]];
              }

              signo=!signo;
            }
          }}
      }
      double menor=90000000;
      for(int i=0;i<matrizx.length;i++){
        List<double> auxidou=List();
        for(int j=0;j<matrizx[i].length;j++){
          String valor=matrizx[i][j];
          if(valor.substring(valor.length-1,valor.length)=="x"&&valor!="x"){
            if(valor.substring(valor.length-2,valor.length)=="-x"){
              double auxmen=double.parse(valor.substring(0,valor.length-2));
              if(auxmen<menor){
                print("menor x");
                print(menor);
                menor=auxmen;
              }
            }
          }
        }
      }
      print(matrizx);
      print("menor x");
      print(menor);
      double x=menor;
      for(int i=0;i<matrizx.length;i++){
        List<double> auxidou=List();
        for(int j=0;j<matrizx[i].length;j++){
          String valor=matrizx[i][j];
          if(valor=="x"){
            auxidou.add(x);
          }
          else
          if(valor.substring(valor.length-1,valor.length)=="x"){
            if(valor.substring(valor.length-2,valor.length)=="-x"){
              double auxmen=double.parse(valor.substring(0,valor.length-2));
              auxidou.add(double.parse(valor.substring(0,valor.length-2))-x);
            }
            else{
              double auxmen=double.parse(valor.substring(0,valor.length-2));
              auxidou.add(double.parse(valor.substring(0,valor.length-2))+x);
            }
          }
          else{
            auxidou.add(matrizsol1[i][j]);
          }
        }
        matrizsol.add(auxidou);
      }
      print("solucion 1");
      print(matrizsol1);
      print("solucion final");
      print(matrizsol);
      return matrizsol;
    }
  }
  List<int> matzmenosor(matrizcos,tipo){
    List<List<double>> matzi=matz(matrizcos);
    List<List<double>> matzmen=List();
    for(int i=0;i<matzi.length;i++){
      List<double> aux=new List();
      for(int j=0;j<matzi[i].length;j++){
        aux.add(matzi[i][j]-matriz[i][j]);
      }
      matzmen.add(aux);
    }
    double menor=matzmen[0][0];
    List<int> coormen=[0,0];
    for(int i=0;i<matzi.length;i++){
      for(int j=0;j<matzi[i].length;j++){
        if(tipo=="min"){
          if(menor<matzmen[i][j]){
            menor=matzmen[i][j];
            coormen=[i,j];
          }

        }
        else{
        if(menor>matzmen[i][j]){
          menor=matzmen[i][j];
          coormen=[i,j];
        }}
      }
    }
    print("matnegativo");
    print(matzmen);
    print("menor");
    print(menor);
    if(menor==0.0){
      return null;
    }
    else
    return coormen;
  }
  List<List<double>> matz(matrizc){
    List<List<double>> matrizz = new List<List<double>>();
    List<List<double>> matrizcos=matrizc;
    List<double> demaaux = new List();
    List<double> dispaux= new List();
    for(int i=0;i<matrizc.length;i++){
      List<double> aux=List();
      dispaux.add(-89879879);
      for(int j=0;j<matrizc[i].length;j++){
        if(matrizcos[i][j]!=0){
          aux.add(matriz[i][j]);
        }
        else{
          aux.add(0);
        }
        if(demaaux.length<demanda.length){
        demaaux.add(-89879879);}
      }
      matrizz.add(aux);
    }
    List<int> pivot=[0,0];
    for(int j=0;j<matrizz[0].length;j++){
      if(matrizz[0][j]!=0){
        pivot=[0,j];
        break;
      }
    }
    dispaux[pivot[0]]=matrizz[pivot[0]][pivot[1]];
    demaaux[pivot[1]]=dispaux[pivot[0]]-matrizz[pivot[0]][pivot[1]];
    bool flag=true;
    int fila=0;
    int columna=0;
    while(demaaux.contains(-89879879)||dispaux.contains(-89879879)){
        print(pivot);
        print(dispaux);
        print(demaaux);
      if(flag){
        for(int j=0;j<matrizz[fila].length;j++){
          if(matrizz[fila][j]!=0){
            pivot=[fila,j];
          }
          bool fcamb=false;
          if(dispaux[pivot[0]]==-89879879&&demaaux[pivot[1]]!=-89879879)
            {
              dispaux[pivot[0]]=matrizz[pivot[0]][pivot[1]]-demaaux[pivot[1]];
            fcamb=true;}
          if(demaaux[pivot[1]]==-89879879&&dispaux[pivot[0]]!=-89879879)
          {demaaux[pivot[1]]=matrizz[pivot[0]][pivot[1]]-dispaux[pivot[0]];
            fcamb=true;
            }
          if(fcamb){
            bool tfila=false;
            for(int i=0;i<matrizz.length;i++){
              if(matrizz[i][j]!=0){
                tfila=true;
                break;
              }
            }
            if(tfila){
              fila=j;
              flag=false;
              break;
            }
          }
          if(j+1==matrizz[fila].length){
            if(fila+1==matrizcos.length){
              fila=0;
            }
            else{
              fila++;
            }
          }



        }
      }
      else{
        for(int j=0;j<matrizz.length;j++){
          if(matrizz[j][columna]!=0){
            pivot=[j,columna];
          }
          bool ccamb=false;
          if(dispaux[pivot[0]]==-89879879&&demaaux[pivot[1]]!=-89879879)
          {
            dispaux[pivot[0]]=matrizz[pivot[0]][pivot[1]]-demaaux[pivot[1]];
          ccamb=true;
          }
          if(demaaux[pivot[1]]==-89879879&&dispaux[pivot[0]]!=-89879879)
          {demaaux[pivot[1]]=matrizz[pivot[0]][pivot[1]]-dispaux[pivot[0]];
          ccamb=true;
          }
          if(ccamb){
            bool tcol=false;
            for(int i=0;i<matrizz.length;i++){
              if(matrizz[i][j]!=0){
                tcol=true;
                break;
              }
            }
            if(tcol){
              columna=j;
              flag=true;
              break;
            }
          }
          if(j+1==matrizz.length){
            if(columna+1==matrizcos[j].length){
              columna=0;
            }
            else{
              columna++;
            }
          }



        }
      }

    }
    for(int i=0;i<matrizz.length;i++){
      for(int j=0;j<matrizz[i].length;j++){
        matrizz[i][j]=demaaux[j]+dispaux[i];
      }
    }
    return matrizz;
  }
  double sacardouble(matrizcos){

    double total=0;
    for(int i=0;i<matriz.length;i++){
      for(int j=0;j<matriz[i].length;j++){
        total+=matriz[i][j]*matrizcos[i][j];
      }
    }
    return total;
  }
  List<List<double>> noroe1(matriz){
    List<List<double>> matrizcos = new List<List<double>>();
    for(int i=0;i<matriz.length;i++){
      List<double> aux=List();
      for(int j=0;j<matriz[i].length;j++){
        aux.add(0);
      }
      matrizcos.add(aux);
    }
    print(disponibilidad);
    print(demanda);
    matrizcos[0][0]=demanda[0];
    matrizcos[0][1]=disponibilidad[0]-matrizcos[0][0];

    int inii=1;
    int inij=1;
    for(int i=inii;i<matriz.length;i++){
      for(int j=inij;j<matriz[i].length;j++){
        if(matrizcos[i][j-1]!=0){
          matrizcos[i][j]=disponibilidad[i]-matrizcos[i][j-1];
          inii++;
          break;
        }
        else
        if(matrizcos[i-1][j]!=0){
          matrizcos[i][j]=demanda[j]-matrizcos[i-1][j];
          inij++;
        }
      }
    }
    return  matrizcos;
  }
  
}