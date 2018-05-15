class Square {
  /* Fields
   *   where the square is
   *    - x and y coordinates (on the grid, right? not on the screen)
   *   how much sugar is on the square right now 
   *   the maximum amount of sugar that the square can hold
   *     (should the max amount be forced to be the same for every square, or
   *      should we rely on the object that calls the constructor to enforce that?)
   *   whether the square is currently occupied, and who is occupying it
   *    - this should be an Agent reference, null for unoccupied
   */
  private int x;
  private int y;
  private int sugarLevel;
  private int maxSugarLevel;
  private Agent agent;
  private int pollution;

  /* Constructor
   *   initializes a new Square with the specified initial and maximum sugar levels, 
   *   and the specified x and y coordinates. The square should be unoccupied.
   */
  public Square(int sugarLevel, int maxSugarLevel, int x, int y) {
    this.sugarLevel = sugarLevel;
    this.maxSugarLevel = maxSugarLevel;
    this.x = x;
    this.y = y;
    this.pollution =0;
  }
  
  //returns the current pollution level;
  public int getPollution(){
   return pollution; 
  }
  
  //sets the pollution level to howMuch
  public void setPollution(int howMuch){
   if(howMuch < 0){
    this.pollution = 0; 
   } else {
    this.pollution = howMuch; 
   }
  }

  /* Returns the current level of sugar
   */
  public int getSugar() {
    return this.sugarLevel;
  }

  /* returns the maximum amount of sugar that can be stored here.
   *
   */
  public int getMaxSugar() {
    return this.maxSugarLevel;
  }

  /* returns the x coordinate of the Square
   *  (on the grid, right?)
   *
   */
  public int getX() {
    return this.x;
  }

  /* returns the y coordinate of the Square
   *  (on the grid, right?)
   *
   */
  public int getY() {
    return this.y;
  }

  /* Sets the sugar level to the specified value. 
   *  If the value is negative, sets the sugar level to 0 instead. 
   *  If the value is larger than the maximum amount of sugar that can be stored here, 
   *  sets the sugar level to the maximum value instead.
   *
   */
  public void setSugar(int howMuch) {
    if (howMuch < 0) {
      sugarLevel = 0;
    } else if (howMuch > maxSugarLevel) {
      sugarLevel = maxSugarLevel;
    } else {
      sugarLevel = howMuch;
    }
  }


  /* Sets the maximum sugar level to the specified value. 
   *  If the specified value is less than 0, sets the maximum sugar level to 0 instead. 
   *  Adjusts the current sugar level to ensure it is no larger than the updated maximum.
   *
   */
  public void setMaxSugar(int howMuch) {
    if (howMuch < 0) {
      maxSugarLevel = 0;
    } else {
      maxSugarLevel = howMuch;
    }
    if (sugarLevel > maxSugarLevel) {
      sugarLevel = maxSugarLevel;
    }
  }

  /* Returns the Agent object that currently occupies this Square, if any. 
   *  Returns null if no Agent is present. 
   *  You may make an empty Agent class to ensure your code compiles, and 
   *  to facilitate tests of your code. 
   *  The test system will provide its own Agent class.
   *
   */
  public Agent getAgent() {
    if (agent == null) {
      return null;
    } else {
      return agent;
    }
  }

  /* Sets the Agent currently occupying this Square to the specified Agent a. 
   *  If this Square is not empty, then:
   *     unless the current agent is the same as the specified Agent or 
   *     the specified Agent is null, this should produce an error instead 
   *     (use assert(false)).
   *
   */
  public void setAgent(Agent a) {
    if (this.getAgent() == null || this.getAgent() == a || a == null) {
      this.agent = a;
    } else {
      assert(false);
    }
  }

  /* Draws a Square. 
   *  Not tested visually by the autograder. 
   *
   *  The Square should be drawn as a size*size square 
   *  at position (size*xOffset, size*yOffset). 
   *
   *  The square should have a while border 4 pixels wide. 
   *  The square should be colored as a function of its Sugar Levels. 
   *  An example color scheme is to use shades of yellow: 
   *    (255, 255, 255 - sugarLevel/6.0*255)
   *
   */
  public void display(int size) {
    strokeWeight(4);
    stroke(255);
    fill(255, 255, 255 - this.sugarLevel/ 6.0*255);
    if (this.getAgent() != null) {
      agent.display(size*x + size/2, size*y + size/2, size);
    }
    rect(x, y, size, size);
    
  }
}