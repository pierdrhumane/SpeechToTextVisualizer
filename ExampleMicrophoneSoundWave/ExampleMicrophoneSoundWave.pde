import processing.sound.*;
import geomerative.*;

Waveform waveform;
AudioIn in;


/** GEOMETRATIVE **/

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] pointsText;
RPoint[] pointsWave;
RPoint[] mergedPoints;

int samples =128;
String[] words = {"hello", "what's", "up", "how", "are", "you", "set", "a", "timer", "for", "5", "minutes", "play", "some", "music", "what's", "the", "weather", "like", "today", "tell", "me", "a", "joke", "what's", "the", "time", "search", "for", "pizza", "restaurants", "near", "me", "turn", "on", "the", "lights"};

public void setup()
{
  size(640, 360);
  background(255);

  /** GEOMETRATIVE **/
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  in = new AudioIn(this, 0);
  in.start();
  waveform = new Waveform(this, samples);
  waveform.input(in);

  pointsText = new RPoint[0];
}

public void draw()
{
  background(0);
  stroke(0, 255, 224);
  strokeWeight(2);
  noFill();

  translate(width/2, height/2);
  //scale(0.7,0.7);
  waveform.analyze();

  //beginShape();
  pointsWave = new RPoint[samples+2];
  for (int i = 0; i < samples; i++)
  {
    pointsWave[i] = new RPoint( map(i, 0, samples, -width/2, width/2), map(waveform.data[i], -1, 1, -height/2, height*0.45));
    //vertex(
    //  map(i, 0, samples, 0, width),
    //  map(waveform.data[i], -1, 1, 0, height)
    //);
  }
  pointsWave[samples] = new RPoint(width*0.5,height*0.5);
  pointsWave[samples+1] = new RPoint(-width*0.5,height*0.5);
  //mergedPoints = new RPoint[pointsWave.length + pointsText.length];
  //mergeArrays(pointsWave, pointsText, mergedPoints);
  //sortPoints(mergedPoints);
  //endShape();
 //if(pointsText.length>0)
 //  {
 //   RShape shape = new RShape(new RPath(mergeTwoArraysWithQuantifiedUnion()));
 //   shape.draw();
 //  }
  //RContour contour = new RContour(mergedPoints);
  //contour.draw();
  //RPath env = cycleThroughAllPoints();
  //env.draw();

  
  //RShape shapeWave = new RShape(new RPath(pointsWave));
  RPolygon polyWave = new RPolygon(pointsWave);
  RPolygon polyText = new RPolygon(pointsText);
  //fill(0,255,0);
  //shapeWave.draw();
  noFill();
  if(pointsText.length>0)
   {
   // RShape shapeText = new RShape(new RPath(pointsText));
   ////shapeText.draw();  
   //grp.draw();
   RPolygon poly = polyWave.union(polyText);
   poly.draw();
 }
  // if(pointsText.length>0)
  // {
  // RShape shapeText = new RShape(new RPath(pointsText));
  // RShape shape = shapeWave.intersection(shapeText);
  // shape = shapeWave.diff(shape);
  // shape = shape.diff(shapeText);
  // shape.draw();
  // }
  // else
  // {
  // shapeWave.draw();
  // }
   



  //if(pointsText != null){
  //  noFill();
  //  stroke(0,225,224);

  //  //beginShape();
  //  //for(int i=0; i<points.length; i++){
  //  //  vertex(width/2+points[i].x, height/2+points[i].y);
  //  //}
  //  //endShape();

  //  fill(0,255,224,50);
  //  stroke(0,255,224,20);
  //  for(int i=0; i<pointsText.length; i++){
  //    ellipse(width/2+pointsText[i].x,height/2+ pointsText[i].y,5,5);
  //  }
  //}
}
void getShapeOfText()
{
  /** GEOMETRATIVE **/
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("Hello", "humane-vf.ttf", 200, CENTER);
  //RG.setPolygonizer(RG.UNIFORMLENGTH);
  //RG.setPolygonizer(RG.ADAPTATIVE);
  RG.setPolygonizer(RG.UNIFORMSTEP);
  RG.setPolygonizerLength(3);// map(mouseY, 0, height, 3, 200));
  pointsText = grp.getPoints();
}
void keyPressed()
{
  getShapeOfText();
}
void mergeArrays(RPoint[] arr1, RPoint[] arr2, RPoint[] result) {
  System.arraycopy(arr1, 0, result, 0, arr1.length);
  System.arraycopy(arr2, 0, result, arr1.length, arr2.length);
}
RPoint[] mergeTwoArraysWithQuantifiedUnion()
{
  ArrayList<RPoint> arrTmp = new ArrayList<RPoint>();
  for (int j=1; j<pointsWave.length; j++)
  {
    RPoint curWave = pointsWave[j];
    RPoint prevWave = pointsWave[j-1];
    println("index:"+j);
    for (int i=1; i<pointsText.length; i++)
    {
      RPoint curTex = pointsText[i];
      RPoint prevTex = pointsText[i-1];
      
        
      int tx1 = (int)prevTex.x;
      int tx2 = (int)curTex.x;
      
      if (prevTex.x>curTex.x)
      {
        tx2 = (int)prevTex.x;
        tx1 = (int)curTex.x;
      }
  boolean waveReverse = false;
      int wx1 = (int)prevWave.x;
      int wx2 = (int)curWave.x;
      if (prevWave.x>curWave.x) {
        wx1 = (int)curWave.x;
        wx2 = (int)prevWave.x;
        waveReverse = true;
      }
      
      if (wx2<tx1 || wx1>tx2)
      {
        //add line to arrTmp if arrTmp doesn't already contain it;
        if(! (arrTmp.contains(curWave) && arrTmp.contains(prevWave)))
        {
          if(waveReverse)
          {
            arrTmp.add(curWave);
            arrTmp.add(prevWave);
          }
          else
          {
            arrTmp.add(prevWave);
            arrTmp.add(curWave);
          }
        }
      }
      else if(wx1<tx1 && wx2<tx2 && wx2>tx1)
      {
        //add line to arrTmp but shorten wx2 to be equal to tx1
        if(waveReverse)
        {
          //curWave.x = tx1;
          arrTmp.add(new RPoint(tx1,curWave.y));
          arrTmp.add(prevWave);
        }
        else
        {
          //prevWave.x = tx1;
          arrTmp.add(new RPoint(tx1,prevWave.y));
          arrTmp.add(curWave);
        }
      }
      else if(wx1>tx1 && wx1<tx2 && wx2>tx2)
      {
        //add line to arrTmp but move wx1 to be equal to tx2
        if(waveReverse)
        {
          //curWave.x = tx2;
          arrTmp.add(new RPoint(tx2,curWave.y));
          arrTmp.add(prevWave);
        }
        else
        {
          //prevWave.x = tx2;
          arrTmp.add(new RPoint(tx2,prevWave.y));
          arrTmp.add(curWave);
        }
      }
      else if(wx1 < tx1 && wx2 > tx2)
      {
        //add two lines to arrTmp having wx1 tx1 and tx2 wx2
        if(waveReverse)
        {
            arrTmp.add(new RPoint(wx1,curWave.y));
          arrTmp.add(new RPoint(tx1,curWave.y));
           arrTmp.add(new RPoint(tx2,prevWave.y));
          arrTmp.add(new RPoint(wx2,prevWave.y));
        }
        else
        {
          
          arrTmp.add(new RPoint(wx1,prevWave.y));
          arrTmp.add(new RPoint(tx1,prevWave.y));
           arrTmp.add(new RPoint(tx2,curWave.y));
          arrTmp.add(new RPoint(wx2,curWave.y));
          
        }
      }
    }
  }
  println("ready to return with :"+arrTmp.size());
  return arrTmp.toArray(new RPoint[arrTmp.size()]);
}
