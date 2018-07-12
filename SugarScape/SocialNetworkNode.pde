class SocialNetworkNode{
  Agent agent;
  boolean isPainted;
  
 public SocialNetworkNode(Agent a){
   agent = a;
   isPainted = false;
 }
 
 public boolean painted(){
  return(isPainted);
 }
 
 public void paint(){
  isPainted = true; 
 }
 
 public void unpaint(){
   isPainted = false;
 }
 
 public Agent getAgent(){
  return(agent); 
 }
}