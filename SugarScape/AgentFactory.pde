import java.lang.Math;

class AgentFactory{
 private int minMetabolism;
 private int maxMetabolism;
 private int minVision;
 private int maxVision;
 private int minInitialSugar; 
 private int maxInitialSugar;
 private MovementRule m;
 public AgentFactory(int minMetabolism, int maxMetabolism, int minVision, int maxVision, int minInitialSugar, int maxInitialSugar, MovementRule m){
   this.minMetabolism = minMetabolism; 
   this.maxMetabolism = maxMetabolism;
   this.minVision = minVision;
   this.maxVision = maxVision; 
   this.minInitialSugar = minInitialSugar;
   this.maxInitialSugar = maxInitialSugar;
 }
 
 public Agent makeAgent(){
   int metabolism = (int) random(minMetabolism, maxMetabolism + 1);
   int vision = (int) random(minVision, maxVision + 1);
   int initialSugar = (int) random(minInitialSugar, maxInitialSugar + 1);
   Agent a = new Agent(metabolism, vision, initialSugar, m);
   return a;
 }
}