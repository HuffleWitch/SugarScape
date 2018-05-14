class ReplacementRule{
 private int minAge; 
 private int maxAge;
 private AgentFactory fac;
 private HashMap<Agent, Integer> listOfAgentsAge;
 
 public ReplacementRule(int minAge, int maxAge, AgentFactory fac){
  this.minAge = minAge;
  this.maxAge = maxAge;
  this.fac = fac;
  this.listOfAgentsAge = new HashMap<Agent, Integer>();
 }
 
 public boolean replaceThisOne(Agent a){
  if(a.isAlive() == false){
    a.setAge(maxAge + 1);
    return true;
  } 
  if (listOfAgentsAge.containsKey(a) == false){
   int ranAge = (int)random(minAge, maxAge + 1);
   listOfAgentsAge.put(a, ranAge);
  } else{
   if(listOfAgentsAge.get(a) < a.getAge()){
    a.setAge(maxAge + 1);
    return true;
   }
  }
  return false;
 }
 
 public Agent replace(Agent a, List<Agent> others){
   return fac.makeAgent();
 }
}