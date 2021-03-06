import java.util.LinkedList;

class SquareTester {
  void test() {
    Square s = new Square(5, 9, 50, 50); // square with sugarLevel 5, maxSugarLevel 9, position (x, y) = (50, 50)
    assert (s.getSugar() < s.getMaxSugar());
    assert (s.getSugar() == 5);
    s.setSugar(10);
    assert (s.getSugar() == 9);
    s.setMaxSugar(-1);
    assert(s.getMaxSugar() == 0);
    s.setMaxSugar(10);
    assert(s.getMaxSugar() == 10);
    s.setSugar(11);
    assert(s.getSugar() == 10);
    assert(s.getX() == 50);
    assert(s.getY() == 50);
    assert(s.getAgent() == null);
    GrowbackRule g = new GrowbackRule(2);
    s.setSugar(2);
    g.growBack(s);
    SugarGrid grid = new SugarGrid(5, 5, 20, g);
    assert(grid.getWidth() == 5);
    assert(grid.getHeight() == 5);
    assert(grid.getSquareSize() == 25);
    assert(grid.getSugarAt(2,2) == 0);
    assert(grid.getMaxSugarAt(2,2) == 0);
    assert(grid.getAgentAt(2,2) == null);
    //agent and AgentFactory tests
    MovementRule m = new SugarSeekingMovementRule();
    AgentFactory fac = new AgentFactory(2, 5, 1, 5, 3, 6, m);
    Agent a = fac.makeAgent();
    assert(a.getAge() == 0);
    a.step();
    assert(a.getAge() == 1);
    a.setAge(3);
    assert(a.getAge() == 3);
    
  }
}