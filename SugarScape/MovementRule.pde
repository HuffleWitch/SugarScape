import java.util.LinkedList;
import java.util.Collections;

interface MovementRule{
 public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle);
}

class SugarSeekingMovementRule implements MovementRule{
  /* The default constructor. For now, does nothing.
   *
   */
  LinkedList<Square> neighbourhood;
  SugarGrid g;
  Square middle;

  public SugarSeekingMovementRule() {
  }

  /* For now, returns the Square containing the most sugar. 
   *  In case of a tie, use the Square that is closest to the middle according 
   *  to g.euclidianDistance(). 
   *  Squares should be considered in a random order (use Collections.shuffle()). 
   */
  public Square move(LinkedList<Square> neighbourhood, SugarGrid g, Square middle) {
    int mostSugar = 0;
    Square mostSugarSquare = null;
    Square current = null;
    Collections.shuffle(neighbourhood);
    double mostSugarDist = 888888888;
    for (int i = 0; i < neighbourhood.size(); i++) {
      current = neighbourhood.get(i);
      double currentSugarDist = g.euclidianDistance(current, middle);
      if (current.getSugar() >  mostSugar | 
         (current.getSugar() == mostSugar && mostSugarDist > currentSugarDist)
         ) {
        mostSugarSquare = current;
        mostSugar = mostSugarSquare.getSugar();
        mostSugarDist = g.euclidianDistance(mostSugarSquare, middle);
         
      }
    }
    return mostSugarSquare;
  }
}

class PollutionMovementRule implements MovementRule{
  
 public Square move(LinkedList<Square> neighborhood, SugarGrid g, Square middle){
   
  Square max = neighborhood.peek();
  Collections.shuffle(neighborhood);
  boolean noPollMax = (max.getPollution() == 0);
  
  for(Square s : neighborhood){
   boolean closerSquare = (g.euclidianDistance(s, middle) < g.euclidianDistance(max, middle));
   
   if (s.getPollution() == 0){
    if(noPollMax == false || s.getSugar() > max.getSugar() || (s.getSugar() == max.getSugar() && closerSquare)){
     max = s; 
    }
   } else if (noPollMax == false){
    float newRatio = s.getSugar() * (1.0 / s.getPollution());
    float currentRatio = max.getSugar() * (1.0 / max.getPollution());
    if (newRatio > currentRatio || (newRatio == currentRatio && closerSquare)){
     max = s; 
    }
   }
  }
  return max;
 }
}

class CombatMovementRule extends SugarSeekingMovementRule{
  private int alpha;
  
  public CombatMovementRule(int alpha){
   this.alpha = alpha; 
  }
  
  public move(LinkeList<Square> neighbourhood, SugarGrid g, Square middle){
    Agent middleAgent = middle.getAgent();
    boolean middleTribe = middleAgent.getTribe();
    
    //remove tribe members and garunteed losses
    for(Square s : neighbourhood){
     if(s.getAgent() != null){
      if(s.getAgent().getTribe == middleTribe || s.getAgent().getSugarLevel() > middleAgent.getSugarLevel()){
       neighbourhood.remove(s); 
      }
     }
    }
    
    //retaliation possibilities removed
    for(Square s : neighbourhood){
     LinkedList<Square> deathView = g.generateVision(s.getX(), s.getY(), middleAgent.getVision());
     for(Square sq : deathView){
      if(sq.getAgent().getSugarLevel > middleAgent.getSugarLevel() && sq.getAgent().getTribe != middleTribe){
       neighbourhood.remove(sq); 
      }
     }
    }
    
    //combat -- uses alternative square to pass to the super.move()
    LinkedList<Square> superMoveSq = neighbourhood;
    for(Square s : neighbourhood){
      if(s.getAgent() !=){
       int newSugarLevel = s.getAgent().getSugarLevel() + s.getSugar() + alpha;
       int newMaxSugar = s.getAgent().getSugarLevel() + s.getSugar() + alpha;
       Square fakeSquare = new Square(newSugarLevel, newMaxSugar, s.getX(), s.getY():
       superMoveSq.remove(s);
       superMoveSq.add(fakeSquare);
      }
    }
    
    Square target = super.move(superMoveSq, g, middle);
    if(target == null){
     return target; 
    } else {
      Agent casualty = target.getAgent();
      target.setAgent(null);
      middleAgent.addSugar(casualty.getSugarLevel() + alpha);
      g.killAgent(casualty);
      return target;
    } 
  }
}