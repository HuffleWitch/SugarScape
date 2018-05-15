import java.lang.Math;

class PollutionRule{
 private int gatheringPollution;
 private int eatingPollution;
 
 public PollutionRule(int gatheringPollution, int eatingPollution){
  this.gatheringPollution = gatheringPollution;
  this.eatingPollution = eatingPollution;
 }
 
 public void pollute(Square s){
  if(s.getAgent() != null) {
   s.setPollution(s.getPollution() + (eatingPollution * s.getAgent().getMetabolism()) + (gatheringPollution * s.getSugar())); 
  }
 }
}