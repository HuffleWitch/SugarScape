SugarGrid myGrid;
//Agent ag;
void setup(){
  size(1000,800);
  myGrid = new SugarGrid(50,40,20, new GrowbackRule(4));
  myGrid.addSugarBlob(10,10,1,8);
  //ag = new Agent(1,1,50, new MovementRule());
  //myGrid.placeAgent(ag,10,10);
  myGrid.display();
  frameRate(2);

}

void draw(){
  myGrid.update();
  background(255);
  myGrid.display();
}