SugarGrid myGrid;
Agent ag, ag1, ag2;
void setup(){
  size(1000,800);
  myGrid = new SugarGrid(50,40,20, new GrowbackRule(4));
  myGrid.addSugarBlob(0,0,30,10);
  ag = new Agent(1,1,50, new SugarSeekingMovementRule());
  ag1 = new Agent(3, 5, 4, new SugarSeekingMovementRule());
  ag2 = new Agent(4, 6, 4, new SugarSeekingMovementRule());
  myGrid.placeAgent(ag1, 40, 60);
  myGrid.placeAgent(ag2, 120, 100);
  myGrid.placeAgent(ag,60,60);
  myGrid.display(); //<>//
  frameRate(2);

}

void draw(){
  myGrid.update();
  background(255);
  myGrid.display();
}