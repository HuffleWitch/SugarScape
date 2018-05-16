class Sorter{
 ArrayList<Agent> al;
 
 public abstract void sort(ArrayList<Agent> al);
 
 public boolean lessThan(Agent a, Agent b){
  if(a.getSugar() < b.getSugar()){
   return true; 
  } else {
   return false; 
  }
 }
}

class BubbleSorter extends Sorter{
 public void sort(ArrayList<Agent> al){
   int numOfSwaps = 0;
   while(numOfSwaps != 0){
    for(int i = 0; i > al.size(); i++){
     Agent checkOne = al[i].getSugar();
     Agent checkTwo = al[i +1].getSugar();
     Agent placeHolder;
     if(lessThan(checkOne, checkTwo)){
       al.set(i + 1, checkOne);
       al.set(i, checkTwo);
     }
    }
   }
 }
}

class InsertionSorter extends Sorter{
 public void sort(ArrayList<Agent> al){
  for(int i = 0; i < al.size(); i++){
   Agent k = al.get(i);
   int j = i - 1;
   while(j >= 0 && k < al.get(j)){
    al.set(i, al.get(j));
    j = j - 1;
   }
   al.set(i, k);
  }
 }
}