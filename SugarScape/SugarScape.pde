SugarGrid myGrid;
//Agent ag, ag1, ag2;
Graph NumberOfAgentsGraph;

void setup(){
  size(1000,800);
  
  int numOfAgents = 200;
  int minMetab = 1;
  int maxMetab = 4;
  int minVision = 1;
  int maxVision = 6;
  int minInitialSugar = 50;
  int maxInitialSugar = 100;
  
  MovementRule mr = new SugarSeekingMovementRule();
  
  GrowbackRule gbr = new GrowbackRule(1);
  
  NumberOfAgentsGraph = new NumberOfAgentsGraph(750, 100, 400, 200, "Time", "Agents");
  
  AgentFactory af = new AgentFactory(minMetab, maxMetab, minVision, maxVision, minInitialSugar, maxInitialSugar, mr);
  
  myGrid = new SugarGrid(50, 50, 14, gbr);
  myGrid.addSugarBlob(300, 150, 10, 10);
  myGrid.addSugarBlob(600, 400, 7, 7);
  myGrid.addSugarBlob(0, 500, 10, 10);
  
  for (int i = 0; i < numOfAgents; i++){
   Agent a = af.makeAgent();
   myGrid.addAgentAtRandom(a);
  }
  myGrid.display();
  frameRate(10);

}

void draw(){
  myGrid.update();
  NumberOfAgentsGraph.update(myGrid);
  myGrid.display();
}
  //myGrid = new SugarGrid(50,40,20, new GrowbackRule(4));
  //myGrid.addSugarBlob(0,0,30,10);
  //ag = new Agent(1,1,50, new SugarSeekingMovementRule());
  //ag1 = new Agent(3, 5, 4, new SugarSeekingMovementRule());
  //ag2 = new Agent(4, 6, 4, new SugarSeekingMovementRule());
  //myGrid.placeAgent(ag1, 40, 60);
  //myGrid.placeAgent(ag2, 120, 100);
  //myGrid.placeAgent(ag,60,60);