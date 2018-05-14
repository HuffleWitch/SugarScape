class Agent {
  /* Agent fields:
  *    metabolism - int? float?
  *    vision - int, right? measured in grid steps
  *    stored sugar - int, right?
  *    movement rule - a reference to a MovementRule object
  *     (should all Agents have the same movement rule?)
  */
  private int metabolism;
  private int vision;
  private int sugarLevel;
  private MovementRule movementRule;
  private int age;
  
  /* initializes a new Agent with the specified values for its 
  *  metabolism, vision, stored sugar, and movement rule.
  *
  */
  public Agent(int metabolism, int vision, int initialSugar, MovementRule m) {
    this.metabolism = metabolism;
    this.vision = vision;
    this.sugarLevel = initialSugar;
    this.movementRule = m;
    this.age = 0;
  }
  
  /* returns the amount of food the agent needs to eat each turn to survive. 
  *
  */
  public int getMetabolism() {
    return metabolism; 
  } 
  /* returns the agent's age */
  public int getAge(){
   return age; 
  }
  
  /* sets the agent's age to howMuch, crashes with a negative age */
  public void setAge(int howMuch){
   if (howMuch < 0){
    assert(false); 
   } else {
    this.age = howMuch; 
   }
  }
  
  /* returns the agent's vision radius.
  *
  */
  public int getVision() {
    return vision;
  } 
  
  /* returns the amount of stored sugar the agent has right now.
  *
  */
  public int getSugarLevel() {
    return sugarLevel;
  } 
  
  /* returns the Agent's movement rule.
  *
  */
  public MovementRule getMovementRule() {
    return movementRule;
  } 
  
  /* Moves the agent from source to destination. 
  If the destination is already occupied, 
  the program should crash with an assertion error instead,
  unless the destination is the same as the source.
  *
  */
  public void move(Square source, Square destination) {
    if(destination.getAgent() != null){
     assert(false); 
    }
    else{
     source.setAgent(null);
     destination.setAgent(this);
    }
  } 
  
  /* Reduces the agent's stored sugar level by its metabolic rate, to a minimum value of 0.
  *
  */
  public void step() {
    age++;
    for(int i = sugarLevel; i <= 0; i -= metabolism){
      if( i < 0){
       sugarLevel = 0; 
      }
    }
  } 
  
  /* returns true if the agent's stored sugar level is greater than 0, false otherwise. 
  * 
  */
  public boolean isAlive() {
    if (sugarLevel > 0){
     return true; 
    }
    else{
      return false; 
    }
  } 
  
  /* The agent eats all the sugar at Square s. The agents sugar level is increased by that amount, and the amount of sugar on the square is set to 0.
  *
  */
  public void eat(Square s) {
    sugarLevel += s.getSugar();
    s.setSugar(0);
  } 
  
  /* returns true if this Agent passes all the tests I can think of
  *
  */
  public boolean test() {
    if (getSugarLevel() < 0) return false;
    if (isAlive() && getSugarLevel() == 0) return false;
    // is having no sugar the only way to die?
    
    return true;
  }
  
  public void display(int x, int y, int scale){
    //diameter 3*scale/4
    fill(0);
    ellipse(x, y, 3*scale/4, 3*scale/4);
  }
}