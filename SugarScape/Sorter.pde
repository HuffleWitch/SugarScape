abstract class Sorter{
 ArrayList<Agent> al;
 
 public abstract void sort(ArrayList<Agent> al);
 
 public boolean lessThan(Agent a, Agent b){
  if(a.getSugarLevel() < b.getSugarLevel()){
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
     Agent checkOne = al.get(i);
     Agent checkTwo = al.get(i +1);
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
   while(j >= 0 && lessThan(k, al.get(j))){
    al.set(i, al.get(j));
    j = j - 1;
   }
   al.set(i, k);
  }
 }
}

class MergeSorter extends Sorter{
 ArrayList<Agent> extra;
 
 public void sort(ArrayList<Agent> al){
  extra = new ArrayList<Agent>(al);
  sort(al, 0, al.size());
 }
 
 private void sort(ArrayList<Agent> al, int leftStart, int rightEnd){
  if(rightEnd - leftStart == 1){
   return; 
  }
  int leftEnd = (rightEnd + leftStart)/2;
  int rightStart = leftEnd + 1;
  sort(al, leftStart, leftEnd);
  sort(al, rightStart, rightEnd);
  merge(al, leftStart, rightEnd);
 }
 
 private void merge(ArrayList<Agent> al, int leftStart, int rightEnd){
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
   if(lessThan(extra.get(leftPointer), extra.get(rightPointer))){
    al.set(extraPointer, extra.get(leftPointer));
    leftPointer++;
   } else {
    al.set(extraPointer, extra.get(rightPointer));
    rightPointer++;
   }
   extraPointer++;
  }
  
  if(leftPointer == leftEnd){
   while(rightPointer < rightEnd){
    al.set(extraPointer, extra.get(rightPointer));
    rightPointer++;
    extraPointer++;
   }
  }
  if(rightPointer == rightEnd){
   while(leftPointer < leftEnd){
    al.set(extraPointer, extra.get(leftPointer));
    leftPointer++;
    extraPointer++;
   }
  }
 }
}

class QuickSorter extends Sorter{
 public void sort(ArrayList<Agent> al){
  sort(al, 0, al.size() - 1);
 }
 
 private void sort(ArrayList<Agent> al, int left, int right){
   //pick a pivot point
   //make two sides of the list (higher than pivot, and lower than pivot)
   //recursively call quicksort on both sides
   if(right <= left) return;
   
   int pivot = (left + right)/2;
   int index = partition(al, left, right, pivot);
   sort(al, left, index - 1);
   sort(al, index, right);
 }
 
 private int partition(ArrayList<Agent> al, int left, int right, int pivot){
   //put results back into al (or have them swap in the list)
   //Collections.swap(Arraylist<Agents>, int index1, int index2)
   //swaps index1 and index2
  while(lessThan(al.get(left), al.get(right))){
   while(lessThan(al.get(left), al.get(pivot))){
    left++; 
   }
   while(al.get(right).getSugarLevel() > al.get(pivot).getSugarLevel()){
    right--; 
   }
   if (lessThan(al.get(left), al.get(right))){
    Collections.swap(al, left, right);
    left++;
    right--;
   }
  }
  return(left);
 }
}