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
    for (int i = 0; i < neighbourhood.size(); i++) {
      current = neighbourhood.get(i);
      if (current.getSugar() > mostSugar) {
        mostSugarSquare = current;
        mostSugar = mostSugarSquare.getSugar();
      } else if (current.getSugar() == mostSugar) {
        double mostSugarDist = g.euclidianDistance(mostSugarSquare, middle);
        double currentSugarDist = g.euclidianDistance(current, middle);
        if (mostSugarDist > currentSugarDist) {
          mostSugarSquare = current;
        }
      }
    }
    return mostSugarSquare;
  }
}

class PollutionMovementRule implements MovementRule{
  
 public Square move(LinkedList<Square> neighborhood SugarGrid g, Square middle){
   
  Square max = neighborhood.peek();
  Collections.shuffle(neighborhood);
  boolean noPollMax = (max.getPollution() == 0);
  
  for(Sqaure s : neighborhood){
   boolean closerSquare = (g.eulidianDistance(s, middle) < g.euclidianDistance(max, middle));
   
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