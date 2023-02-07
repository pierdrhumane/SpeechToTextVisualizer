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

int samples = 512;
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
  stroke(0,255,224);
  strokeWeight(2);
  noFill();

  translate(width/2,height/2);
  waveform.analyze();

  //beginShape();
  pointsWave = new RPoint[samples];
  for(int i = 0; i < samples; i++)
  {
    pointsWave[i] = new RPoint( map(i, 0, samples, -width/2, width/2) , map(waveform.data[i], -0.1, 0.1, -height/2, height/2));
    //vertex(
    //  map(i, 0, samples, 0, width),
    //  map(waveform.data[i], -1, 1, 0, height)
    //);
  }
  //mergedPoints = new RPoint[pointsWave.length + pointsText.length];
  //mergeArrays(pointsWave, pointsText, mergedPoints);
  //sortPoints(mergedPoints);
  //endShape();
  RShape shapeWave = new RShape(new RPath(pointsWave));
  if(pointsText.length>0)
  {
    RShape shapeText = new RShape(new RPath(pointsText));
    RShape shape = shapeWave.intersection(shapeText);
    shape.draw();
  }
  else
  {
    shapeWave.draw();
  }
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
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
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
  for(int i=0;i<pointsWave.length;i++)
  {
    RPoint wavePoint = pointsWave[i];
    int xTmp = parseInt( wavePoint.x );
    boolean isThereATextPoint = false;
    for(int j=0;j<pointsText.length;j++)
    {
      RPoint textPoint = pointsText[j];
      if(textPoint.x == xTmp)
      {
        isThereATextPoint = true;
        if(textPoint.y<height*0.2)
        {
          arrTmp.add(textPoint);
        }
      }
      
    }
    if(!isThereATextPoint)
    {
      arrTmp.add(wavePoint);
    }
  }
  return arrTmp.toArray(new RPoint[arrTmp.size()]);
  
}
//void sortPoints(RPoint[] arr) {
//  RPoint reference = arr[0];
//  PVector refVector = new PVector(reference.x, reference.y);
//  for (int i = 0; i < arr.length - 1; i++) {
//    for (int j = 0; j < arr.length - 1 - i; j++) {
//      PVector currentVector = new PVector(arr[j].x, arr[j].y);
//      if (PVector.dist(refVector,currentVector) > PVector.dist(new PVector(arr[i].x, arr[i].y),refVector)) {
//        RPoint temp = arr[j];
//        arr[j] = arr[j + 1];
//        arr[j + 1] = temp;
//      }
//    }
//  }
//}
//void sortPoints(RPoint[] arr) {
//  for (int i = 0; i < arr.length - 1; i++) {
//    RPoint reference = arr[i];
//    PVector refVector = new PVector(reference.x, reference.y);
//    for (int j = i + 1; j < arr.length; j++) {
//      PVector currentVector = new PVector(arr[j].x, arr[j].y);
//      if (PVector.dist(currentVector, refVector) < PVector.dist(new PVector(arr[i].x, arr[i].y), refVector)) {
//        RPoint temp = arr[i];
//        arr[i] = arr[j];
//        arr[j] = temp;
//      }
//    }
//  }
//}
