import java.util.Map;

class FertilityRule{
 private Map<Character, Integer[]> childbearingOnset;
 private Map<Character, Integer[]> climactericOnset;
 private HashMap<Agent, Integer> agentsSugar;
 private HashMap<Agent, Integer> agentChild;
 private HashMap<Agent, Integer> agentClima;
 
 
 public FertilityRule(Map<Character, Integer[]> childbearingOnset, Map<Character, Integer[]> climactericOnset){
  this.childbearingOnset = childbearingOnset; 
  this.climactericOnset = climactericOnset;
  this.agentsSugar = new HashMap<Agent, Integer>;
  this.agentChild = new HashMap<Agent, Integer>;
  this.agentClima = new HashMap<Agent, Integer>;
 }
 
 public boolean isFertile(Agent a){
  if(a.isAlive() == false || a == null){
    agentsSugar.remove(a);
    agentChild.remove(a);
    agentClima.remove(a);
   return false; 
  } 
  
  if(agentsSugar.containsKey(a) != true){
    float randChild = random(childbearingOnset.get(a.getSex())[0], childbearingOnset.get(a.getSex())[1]);
    Integer ChildYear = (int)randChild;
    agentChild.put(a, ChildYear);
    
    float randClima = random(climactericOnset.get(a.getSex())[0], climactericOnset.get(a.getSex())[1]);
    Integer ClimaYear = (int)randClima;
    agentClima.put(a, ClimaYear);
    
    agentsSugar.put(a, a.getSugarLevel());
  }
  
  if(agentChild.get(a) <= a.getAge() < agentClima.get(a) && a.getSugarLevel() >= agentsSugar.get(a)){
   return true; 
  }
  return false;
 }
 
 public boolean canBreed(Agent a, Agent b, LinkedList<Square> local){
   boolean emptySquare = false;
  if(isFertile(a) && isFertile(b) && a.getSex() != b.getSex() && local.contains(b)){
    for(Square s : local){
     if(s.getAgent() == null){
      emptySquare = true; 
     }
    }
    if(emptySquare == true){
     return true; 
    }
  }
  return false;
 }
 
 public Agent breed(Agent a, Agent b, LinkedList<Square> Alocal, LinkedList<Square> Blocal){
   int babyMeta;
   int babyVision;
   char babySex;
   MovementRule babyMovement;
   ArrayList<Square> emptySquare = new ArrayList<Square>();
   
   if(canBreed(a, b, Alocal) != true || canBreed(b, a, Blocal) != true){
   return null; 
  } else {
    //baby's metabolism
    if((int)random(0,2) == 0){
     babyMeta = a.getMetabolism(); 
    } if ((int)random(0,2) == 1){
     babyMeta = b.getMetabolism(); 
    }
    
    //baby's vision
    if ((int)random(0,2) == 0){
     babyVision = a.getVision();
    } if (int)random(0,2) == 1){
     babyVision = b.getVision(); 
    }
    //baby's movement
    babyMovement = a.getMovementRule();
    
    //baby's sex
    if((int)random(0, 2)){
     babySex = 'X'; 
    } else {
     babySex = 'Y'; 
    }
    
    //baby
    Agent baby = new Agent(babyMeta, babyVision, 0, babyMovement);
    
    //baby gets sugar!!
    a.gift(baby, agentsSugar.get(a)/2);
    b.gift(baby, agentsSugar.get(b)/2);
    
    //gotta place the baby, mom can't carry them forever!
    for(Square s : Alocal){
     if(s.getAgent() == null){
      emptySquare.add(s); 
     }
    }
    
    for(Square sq : Blocal){
     if(sq.getAgent() == null){
      emptySquare.add(sq): 
     }
    }
    
    emptySquare.get((int)random(0, emptySquare.size())).setAgent(baby);
    return baby;
  }
 }
}