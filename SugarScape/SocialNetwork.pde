import java.util.Iterator;

class SocialNetwork {

  private LinkedList<SocialNetworkNode>[] adj;

  public SocialNetwork(SugarGrid g) {
    //Initializes a new social network such that for every pair of Agents (x,y)
    //on grid g, if x can see y (i.e. y is on a square that is in the vision of x), 
    //then the SocialNetworkNode for x is connected to the SocialNetworkNode for y 
    //in this new social network. 
    //Note that x might be able to see y even if y cannot see x
  }

  public boolean adjacent(SocialNetworkNode x, SocialNetworkNode y) {
    //Returns true if agent x is adjacent to agent y in this SocialNetwork. 
    //If either x or y is not present in the social network, should return false.
    if (
  }

  public List<SocialNetworkNode> seenBy(SocialNetworkNode x) {
    //Returns a list (either ArrayList or LinkedList) containing all the 
    //nodes that x is adjacent to. Returns null if x is not in the social 
    //network
  }

  public List<SocialNetworkNode> sees(SocialNetworkNode y) {
    //Returns a list (either ArrayList or LinkedList) containing all the nodes
    //that are adjacent to y. Returns null if y is not in the social network.
  }

  public void resetPaint() {
    // Sets every node in the network to unpainted.
    for (int i = 0, i <
  }

  public SocialNetworkNode getNode(Agent a) {
    //Returns the node containing the passed agent. 
    //Returns null if that agent is not represented in this graph.
  }
}