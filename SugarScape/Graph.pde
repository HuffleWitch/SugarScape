class Graph{
 protected int x;
 protected int y;
 protected int howWide;
 protected int howTall;
 protected String xlab;
 protected String ylab;
 
 public Graph(int x, int y, int howWide, int howTall, String xlab, String ylab){
  this.x = x;
  this.y = y;
  this.howWide = howWide;
  this.howTall = howTall;
  this.xlab = xlab;
  this.ylab = ylab;
 }
 
 public void update(SugarGrid g){
  noStroke();
  fill(255);
  rect(x, y, howWide, howTall);
  stroke(0);
  strokeWeight(1);
  line(x, y + howTall, x + howWide, y + howTall);
  line(x, y, x, y + howTall);
  writeRotatedText(xlab, x + howWide, y + howTall + 15, 0);
  writeRotatedText(ylab, x-5, y, -PI/2.0);
 }
 
 private void writeRotatedText(String s, int i, int j, float angle){
  pushMatrix();
  translate(i, j);
  rotate(angle);
  text(s, -s.length() * 8, 0);
  popMatrix();
 }
}

abstract class LineGraph extends Graph{
 private int numberOfUpdates;
 
 public LineGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
  super(x, y, howWide, howTall, xlab, ylab);
  numberOfUpdates = 0;
 }
 
 public abstract int nextPoint(SugarGrid g);
 
 public void update(SugarGrid g){
  if(numberOfUpdates == 0){
   super.update(g);
   numberOfUpdates++;
  } else { 
   fill(0);
   stroke(0);
   rect(numberOfUpdates + this.x, nextPoint(g) + this.y + this.howTall - 2, 1, 1);
   numberOfUpdates++;
   if(numberOfUpdates >= howWide){
    numberOfUpdates = 0; 
   }
  }
 }
}

class NumberOfAgentsGraph extends LineGraph{
 
  public NumberOfAgentsGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
    super(x, y, howWide, howTall, xlab, ylab);
  }
  
  public int nextPoint(SugarGrid g){
   return(g.getAgents().size()/10); //<>//
  }
}

class MetabolismGraph extends LineGraph{
 public MetabolismGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
  super(x, y, howWide, howTall,xlab, ylab); 
 }
 
 public int nextPoint(SugarGrid g){
   ArrayList<Agent> Agents = g.getAgents();
   int totalAgents = Agents.size();
   int totalMetabolism = 0;
   
   for(int i = 0; i < totalAgents; i++){
    Agent current = Agents.get(i);
    totalMetabolism += current.getMetabolism();
   }
  return (10 * (-totalMetabolism/totalAgents)); 
 }
}

class VisionGraph extends LineGraph{
 
  public VisionGraph(int x, int y, int howWide, int howTall, String xlab, String ylab){
   super(x, y, howWide, howTall, xlab, ylab); 
  }
  
  public int nextPoint(SugarGrid g){
   ArrayList<Agent> Agents = g.getAgents();
   int totalAgents = Agents.size();
   int totalVision = 0;
   
   for(int i = 0; i < totalAgents; i++){
    Agent current = Agents.get(i);
    totalVision += current.getVision();
   }
   return 10 * (-totalVision / totalAgents);
  }
}

abstract class CDFGraph extends Graph{
  protected int callsPerValue = 0;
  protected int numberOfUpdates;
  
 public CDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
   super(x, y, howWide, howTall, xlab, ylab);
   callsPerValue++; 
   numberOfUpdates = 0;
 }
 
 public abstract void reset(SugarGrid g);
 
 public abstract int nextPoint(SugarGrid g);
 
 public abstract int getTotalCalls(SugarGrid g);
 
 public void update(SugarGrid g){
  numberOfUpdates = 0; 
  super.update(g);
  reset(g);
  int numPerCell = (g.w / this.getTotalCalls(g));
  while(numberOfUpdates < this.getTotalCalls(g)){
   rect(numberOfUpdates, nextPoint(g), numPerCell, 1);
   numberOfUpdates++;
  }
 }
}

class WealthCDFGraph extends CDFGraph{
  protected int sugarSoFar;
  protected int totalSugar;
  
 public WealthCDFGraph(int x, int y, int howWide, int howTall, String xlab, String ylab, int callsPerValue){
  super(x, y, howWide, howTall, xlab, ylab, callsPerValue);
 }
 
 public void reset(SugarGrid g){
  sugarSoFar = 0;
  ArrayList<Agent> sortedListOfAgents = new ArrayList();
  sortedListOfAgents = g.getAgents();
  Sorter sorter = new QuickSorter();
  sorter.sort(sortedListOfAgents);
 }
 
 public int nextPoint(SugarGrid g){
  int graphedSoFar = super.numberOfUpdates / callsPerValue;
  reset(g);
  return(sugarSoFar/totalSugar);
 }
 
 public int getTotalCalls(SugarGrid g){
  int totalCalls = g.getAgents().size() / callsPerValue;
  return(totalCalls);
 }
}