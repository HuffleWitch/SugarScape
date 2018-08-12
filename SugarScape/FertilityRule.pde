class FertilityRule{
 private Integer[] childbearingOnset;
 private Integer[] climactericOnset;
 
 public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character, Integer[]> climactericOnset){
  this.childbearingOnset = childbearingOnset; 
  this.climactericOnset = climactericOnset;
 }
 
 public boolean isFertile(Agent a){
  if(a.isAlive() == false || a == null){
   return false; 
  } else{
    
  }
 }
}