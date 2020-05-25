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