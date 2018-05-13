import java.lang.Math;
import java.util.*;

class SugarGrid {
  private int w, h, sideLength;
  private GrowbackRule g;
  private Square[][] gridArray;
  private ArrayList<Agent> listOfAgents;
  /* Initializes a new SugarGrid object with a w*h grid of Squares, 
   *  a sideLength for the squares (used for drawing purposes only) 
   *  of the specified value, and 
   *  a sugar growback rule g. 
   *  Initialize the Squares in the grid to have 0 initial and 0 maximum sugar.
   *
   */
  public SugarGrid(int w, int h, int sideLength, GrowbackRule g) {
    this.gridArray = new Square[w][h];
    this.w = w;
    this.h = h;
    this.sideLength = sideLength;
    this.g = g;
    for (int i = 1; i < w; i++) {
      for (int j = 1; j < h; j++) {
        gridArray[i][j] = new Square(0, 0, i*sideLength, j*sideLength);
      }
    }
  }

  /* Accessor methods for the named variables.
   *
   */
  public int getWidth() {
    return this.w;
  }

  public int getHeight() {
    return this.h;
  }

  public int getSquareSize() {
    return this.w * this.h;
  }

  /* returns respectively the initial or maximum sugar at the Square 
   *  in row i, column j of the grid.
   *
   */
  public int getSugarAt(int i, int j) {
    return gridArray[i][j].getSugar();
  }

  public int getMaxSugarAt(int i, int j) {
    return gridArray[i][j].getMaxSugar();
  }

  /* returns the Agent occupying the square at position (i,j) in the grid, 
   *  or null if no agent is present there.
   *
   */
  public Agent getAgentAt(int i, int j) {
    return gridArray[i][j].getAgent();
  }

  /* places Agent a at Square(x,y), provided that the square is empty. 
   *  If the square is not empty, the program should crash with an assertion failure.
   *
   */
  public void placeAgent(Agent a, int x, int y) {
    if (gridArray[x][y].getAgent() == null) {
      gridArray[x][y].setAgent(a);
    } else {
     assert(false); 
    }
  }

  /* A method that computes the Euclidian distance between two squares on the grid 
   *  at (x1,y1) and (x2,y2). 
   *  Points are indexed from (0,0) up to (width-1, height-1) for the grid. 
   *  The formula for Euclidean distance is normally sqrt( (x2-x1)2 + (y2-y1)2 ) However...
   *  
   *  As in the book, the grid is a torus. 
   *  This means that an Agent that moves off the top of the grid ends up at the bottom 
   *  (and vice versa), and 
   *  an Agent that moves off the left hand side of the grid ends up on the right hand 
   *  side (and vice versa). 
   *
   *  You should return the minimum euclidian distance between the two points. 
   *  For example, euclidianDistance((1,1), (19,19)) on a 20x20 grid would be 
   *  sqrt(2*2 + 2*2) = sqrt(8) ~ 3, and not sqrt(18*18 + 18*18) = sqrt(648) ~ 25. 
   *
   *  The built-in Java method Math.sqrt() may be useful.
   *
   */
  public double euclidianDistance(Square s1, Square s2) {
    float xDis = min(abs(s1.getX() - s2.getX()), w - (abs(s1.getX() - s2.getX())));
    float yDis = min(abs(s1.getY() - s2.getY()), h - (abs(s1.getY() - s2.getY())));
    double euDis = Math.sqrt(Math.pow(xDis, 2) + Math.pow(yDis, 2));
    return euDis;
  }

  /* Creates a circular blob of sugar on the gird. 
   *  The center of the blob is at position (x,y), and 
   *  that Square is updated to store a maximum of max sugar or 
   *  its current maximum value, whichever is greater. 
   *
   *  Then, every square within euclidian distance of radius is updated 
   *  to store a maximum of (max-1) sugar, or its current maximum value, 
   *  whichever is greater. 
   *
   *  Then, every square within euclidian distance of 2*radius is updated 
   *  to store a maximum of (max-2) sugar, or its current maximum value, 
   *  whichever is greater. 
   *
   *  This process continues until every square has been updated. 
   *  Any Square that has a new maximum value 
   *  should also have its Sugar level set to this maximum.
   *
   */
  public void addSugarBlob(int x, int y, int radius, int max) {
    int inc = 1;
    while (inc >= max) {
      for (int i =0; i <w; i++) {
        for (int j = 0; j < h; j++) {
          double euDistance = euclidianDistance(this.gridArray[i][j], this.gridArray[x][y]);
          if (euDistance < radius * (inc ++)) {
            int sugar = max - inc;
            gridArray[i][j].setMaxSugar(sugar);
            gridArray[i][j].setSugar(sugar);
          }
        }
      }
      inc++;
    }
  }

  /* Returns a linked list containing radius squares in each cardinal direction, 
   *  centered on (x,y). 
   *
   *  For example, generateVision(5,5,2) should return the squares 
   *   (5,5), (4,5), (3,5), (6,5), (7,5), (5,4), (5,3), (5,6), and (5,7). 
   *
   *  Your program may do whatever it likes if (x,y) is not a point on the grid, 
   *  or radius is negative. 
   *
   *  When radius is 0, it should return a list containing only (x,y). 
   *
   */
  public LinkedList<Square> generateVision(int x, int y, int radius) {
    LinkedList<Square> l = new LinkedList();
    if (radius == 0) {
      l.add(this.gridArray[x][y]);
    } else {
      for (int i = 0; i <w; i++) {
        for (int j = 0; j <h; j++) {
          int euDistan = (int) euclidianDistance(this.gridArray[i][j], this.gridArray[x][y]);
          if (euDistan <= radius) {
            l.add(this.gridArray[i][j]);
          }
        }
      }
    }
    return l;
  }

  public void update() {
    ArrayList<Agent> lastAgent = new ArrayList<Agent>();
    for (int i = 0; i< w; i++) {
      for (int j =0; j < h; j++) {
        Square current = gridArray[i][j];
        g.growBack(current);
        if (current.getAgent() != null && lastAgent.contains(current.getAgent()) == false) {
          Agent currentAgent = current.getAgent();
          LinkedList<Square> view = generateVision(current.getX(), current.getY(), currentAgent.getVision());
          Square destination = null;
          MovementRule move = currentAgent.getMovementRule();
          while (view.size() != 0) {
            destination = move.move(view, this, gridArray[(w-1)/2][(h-1)/2]);
            if (destination.getAgent() == null) {
              currentAgent.move(current, destination);
              break;
            } else {
              view.remove(destination);
            }
          }
          currentAgent.step();
          if (currentAgent.isAlive()) {
            currentAgent.eat(destination);
            lastAgent.add(currentAgent);
          } else {
            destination.setAgent(null);
            listOfAgents.remove(currentAgent);
          }
        }
      }
    }
  }

  public void display() {
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        this.gridArray[i][j].display(sideLength);
      }
    }
  }
}