import java.util.Iterator;

class SocialNetwork {

  private LinkedList<SocialNetworkNode>[] adj;

  public SocialNetwork(SugarGrid g) {
    //Initializes a new social network such that for every pair of Agents (x,y)
    //on grid g, if x can see y (i.e. y is on a square that is in the vision of x), 
    //then the SocialNetworkNode for x is connected to the SocialNetworkNode for y 
    //in this new social network. 
    //Note that x might be able to see y even if y cannot see x
    adj = new LinkedList[g.getWidth() * g.getHeight()];
    for(int i = 0; i < g.getWidth(); i++){
     for(int j = 0; j < g.getHeight(); j++){
      Agent currentAgent = g.getAgentAt(i, j);
      int index = i + (j * g.getWidth());
      adj[index] = new LinkedList<SocialNetworkNode>();
      if(currentAgent != null){
       LinkedList<Square> vision = g.generateVision(i, j, currentAgent.getVision());
       for(Square s: vision){
        Agent agentInVision = s.getAgent();
        if( agentInVision != null){
         SocialNetworkNode currentNode = new SocialNetworkNode(agentInVision);
         adj[index].add(currentNode);
        }
       }
      }
     }
    }
  }

  public boolean adjacent(SocialNetworkNode x, SocialNetworkNode y) {
    //Returns true if agent x is adjacent to agent y in this SocialNetwork. 
    //If either x or y is not present in the social network, should return false.
   for(int i = 0; i < adj.length; i ++){
    LinkedList<SocialNetworkNode> socialNetwork = adj[i];
    if(socialNetwork.peek() == x){
     for(int j = 0; j < socialNetwork.size(); j++){
      SocialNetworkNode currentNode = socialNetwork.get(j);
      if(currentNode == y){
       return true; 
      }
     }
    }
   }
   return false;
  }

  public List<SocialNetworkNode> seenBy(SocialNetworkNode x) {
    //Returns a list (either ArrayList or LinkedList) containing all the 
    //nodes that x is adjacent to. Returns null if x is not in the social 
    //network
    LinkedList<SocialNetworkNode> seenBy = new LinkedList<SocialNetworkNode>();
    for(int i =0; i < adj.length; i ++){
      LinkedList<SocialNetworkNode> socialNetwork = adj[i];
      for(int j = 0; j < socialNetwork.size(); j++){
       SocialNetworkNode currentNode = socialNetwork.get(j);
       if(currentNode == x){
        seenBy.add(socialNetwork.peek()); 
       }
      }
    }
    if(seenBy.size() == 0){
     return null; 
    }
    return seenBy;
  }

  public List<SocialNetworkNode> sees(SocialNetworkNode y) {
    //Returns a list (either ArrayList or LinkedList) containing all the nodes
    //that are adjacent to y. Returns null if y is not in the social network.
    for(int i =0; i < adj.length; i++){
     LinkedList<SocialNetworkNode> socialNetwork = adj[i];
     if(socialNetwork.peek() == y){
      return socialNetwork; 
     }
    }
    return null;
  }

  public void resetPaint() {
    // Sets every node in the network to unpainted.
    for (int i = 0, i < adj.length; i++){
     LinkedList<SocialNetworkNode> socialNetwork = adj[i];
     for(int j = 0; j < socialNetwork.size(); j++){
      SocialNetworkNode currentNode = socialNetwork.get(j);
      currentNode.unpaint();
     }
    }
  }

  public SocialNetworkNode getNode(Agent a) {
    //Returns the node containing the passed agent. 
    //Returns null if that agent is not represented in this graph.
    for(int i = 0; i < adj.length; i++){
     LinkedList<SocialNetworkNode> socialNetwork = adj[i];
     for(int j = 0; j < socialNetwork.size(); j++){
       SocialNetworkNode currentNode = socialNetwork.get(j);
       if(currentNode.getAgent() == a){
        return currentNode; 
       }
     }
    }
    return null;
  }
  
  //question 3
  public boolean pathExists(Agent x, Agent y){
    //Returns true if there exists any path through the social network 
    //that connects x to y. A path should start with node x, proceed through
    //any node x can see, and then any node that agent can see, and so on, 
    //until it reaches node y.
    //Agent x is the 'search key'
    for (int i = 0; i < adj.length; i++){
     LinkedList<SocialNetworkNode> path = new LinkedList<SocialNetworkNode>();
     LinkedList<SocialNetworkNode> socialNetwork = adj[i];
     if (socialNetwork.peek() != null && socialNetwork.peek().getAgent() == x){
       SocialNetworkNode currentNode = socialNetwork.peek();
       currentNode.paint();
       path.add(currentNode);
       
       Iterator<SocialNetworkNode> it;
       while (path.size() != 0){
        currentNode = path.poll();
        
        SocialNetworkNode extra;
        it = adj[i].listIterator();
        
        while(it.hasNext()){
         extra = it.next();
         if(extra.getAgent() == y){
          resetPaint();
          return true;
         }
         
         if( !extra.painted()){
          extra.paint();
          path.add(n);
         }
        }
        
       }
     }
    }
    return false;
  }
  
  public List<Agent> bacon(Agent x, Agent y){
    //Returns the shortest path through the social network from node x 
    //to node y. If more than one path is the shortest, returns any of the 
    //shortest ones. If there is no path from x to y, returns null
    LinkedList<SocialNetwork> shortest = new LinkedList<>();
    for (int i = 0; i < adj.length; i++){
      LinkedList<SocialNetworkNode> extra = adj[i];
    }
  }
  return shortest;
}