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

class MergeSorter extends Sorter{
 ArrayList<Agent> extra;
 
 public void sort(ArrayList<Agents> al){
  extra = new ArrayList<Agent>(al);
  sort(al, 0, al.size());
 }
 
 private void sort(ArrayList<Agents> al, int leftStart, int rightEnd){
  if(rightEnd - leftStart == 1){
   return; 
  }
  int leftEnd = (rightEnd + leftStart)/2;
  int rightStart = leftEnd + 1;
  sort(al, leftStart, leftEnd);
  sort(al, rightStart, rightEnd);
  merge(al, leftStart, rightEnd);
 }
 
 private void merge(ArrayList<Agents> al, int leftStart, int rightEnd){
  for(int i = leftStart; i < rightEnd; i++){
   extra.set(i, al.get(i)); 
  }
  
  int leftEnd = (rightEnd + leftStart)/2;
  int rightStart = leftEnd + 1;
  
  //pointers
  int leftPointer = leftStart;
  int rightPointer = rightStart;
  int extraPointer = leftStart;
  
  while(leftPointer <= leftEnd && rightPointer <= rightEnd){
   if(lessThan(extra[leftPointer], extra[rightPointer])){
    al[extraPointer] = extra[leftPointer];
    leftPointer++;
   } else {
    al[extraPointer] = extra[rightPointer];
    right++;
   }
   index++;
  }
  
  if(leftPointer == leftEnd){
   while(rightPointer < rightEnd){
    al.set(extraPointer, extra[rightPointer];
    rightPointer++;
    extraPointer++;
   }
  }
  if(rightPointer == rightEnd){
   while(leftPointer < leftEnd){
    al.set(extraPointer, extra[leftPointer];
    leftPointer++:
    extraPointer++;
   }
  }
 }
}

class QuickSorter extends Sorter{
 public void sort(ArrayList<Agents> al){
  sort(al, 0, al.size() - 1);
 }
 
 private void sort(ArrayList<Agents> al, int left, int right){
   //pick a pivot point
   //make two sides of the list (higher than pivot, and lower than pivot)
   //recursively call quicksort on both sides
   if(right <= left) return;
   
   int pivot = al[(left + right)/2];
   int index = partition(al, start, end, pivot);
   sort(al, left, index - 1);
   sort(al, index, right);
 }
 
 private void partition(ArrayList<Agents> al, int left, int right){
   //put results back into al (or have them swap in the list)
   //Collections.swap(Arraylist<Agents>, int index1, int index2)
   //swaps index1 and index2
  while(lessThan(left, right)){
   while(lessThan(al[left], pivot)){
    left++; 
   }
   while(al[right].getSugar() > pivot.getSugar()){
    right--; 
   }
   if (lessThan(left, right)){
    Collections.swap(al, left, right);
    left++;
    right--:
   }
  }
  return left;
 }
}