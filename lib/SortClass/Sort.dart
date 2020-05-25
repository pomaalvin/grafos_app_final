//----SELECTION-----
selectionSort(List list) {
  if (list == null || list.length == 0) {
    print("error en lista");
  }else{
    int n = list.length;
    int i, steps;
    for (steps = 0; steps < n; steps++) {
      for (i = steps + 1; i < n; i++) {
        if(list[steps] > list[i]) {
          swap(list, steps, i);
        }
      }
    }
    return list;
  }
}

void swap(List list, int steps, int i) {
  int temp = list[steps];
  list[steps] = list[i];
  list[i] = temp;
}
//----#SELECTION-----

//----SELECTION----
insertionSort(List list) {
  if (list == null || list.length == 0)
  { 
    print('Error en lista');
  }else{
    int n = list.length;
    int temp, i, j;

    for(i=1; i< n; i++) {
      temp = list[i];
      j=i-1;
      while(j >= 0 && temp < list[j] ) {
        list[j+1] = list[j];
        --j;
      }
      list[j+1] = temp;
    }
    return list;
  }
}
//Shell Sort
shellSort(List list) {
  if (list == null || list.length == 0)
  {
    print('Error en lista');
  }else{
    int n = list.length;
    int h=1;
    while(h < n/3){
      h=3*h+1;
    }
    while(h>=1){
      for(int i=h; i < n; i++) {
        for(int j=i; j>=h && less(list[j],list[j-h]); j=j-h) {
          swap(list,j,j-h);
        }
      }  
      h=(h/3) as int;
    }    
    return list;
  }
}
//Shell Sort
//Comparador si es menor o no xdxd.
bool less(int v, int w ){
  if(v > w) {
    return true;
  }else{
    return false;
  }
}
