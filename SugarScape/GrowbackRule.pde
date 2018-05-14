interface GrowthRule{
 public void growBack(Square s); 
}

class GrowbackRule implements GrowthRule {
  /* Initializes a new GrowbackRule with the specified growth rate.
  *
  */
  private int rate;
  public GrowbackRule(int rate) {
    this.rate = rate;
  }
  /* Increases the sugar in Square s by the growth rate, 
  *  up to the maximum value that can be stored in s. 
  *  Note: you should use only public methods of the Square class. 
  *  The Autograder will provide its own Square class, 
  *  which may not have the private methods or variable names you expect.
  */
  //works in steps, sets sugar back to full
  public void growBack(Square s) {
    s.setSugar(s.getSugar() + rate);
  }
}

class SeasonalGrowbackRule implements GrowthRule{
  private int alpha;
  private int beta;
  private int gamma;
  private int equator;
  private int numSquares;
  private boolean northSummer;
  private int dayCounter;
  
  public SeasonalGrowbackRule(int alpha, int beta, int gamma, int equator, int numSquares){
   this.alpha = alpha;
   this.beta = beta;
   this.gamma = gamma;
   this.equator = equator;
   this.numSquares = numSquares;
   this.northSummer = true;
   this.dayCounter = 0;   
  }
  
  public void growBack(Square s){
   if((s.getY() <= equator && northSummer == true) || (s.getY() > equator && northSummer == false)){
    s.setSugar(s.getSugar() + alpha); 
   } else{
    s.setSugar(s.getSugar() + beta); 
   }
   dayCounter ++;
   if(dayCounter >= gamma*numSquares){
    northSummer = !northSummer;
    dayCounter = 0;
   }
  }
  
  public boolean isNorthSummer(){
   return northSummer; 
  }
}