import java.util.LinkedList;
import java.util.Collections;

class MovementRule {
  /* The default constructor. For now, does nothing.
   *
   */
  LinkedList<Square> neighbourhood;
  SugarGrid g;
  Square middle;

  public MovementRule() {
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