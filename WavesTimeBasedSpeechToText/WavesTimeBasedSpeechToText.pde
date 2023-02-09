import processing.sound.*;
import geomerative.*;


AudioIn in;
Waveform waveform;

RShape[] shapes = new RShape[30];
int samples = 256;


long lastTime;
String newWord = null;
void setup()
{
  size(640, 360);
  background(255);
  
  in = new AudioIn(this, 0);
  in.start();

  waveform = new Waveform(this, samples);
  waveform.input(in);

  lastTime = millis();
  
  RG.init(this);
  
  for(int i=0 ; i<shapes.length ;i++)
  {
    shapes[i] =  new RShape();
  }
  
  initOSC();
}

void draw()
{
  background(0);
  stroke(0, 255, 224);
  strokeWeight(2);
  noFill();
  

  waveform.analyze();



  long currentTime = millis();
  if (currentTime - lastTime >= 25) {
    if(newWord == null)
    {
      lastTime = currentTime;
      RPoint[] arrTmp = new RPoint[samples];
      for (int i = 0; i < samples; i++)
      {
  
        arrTmp[i] = new RPoint(  map(i, 0, samples, 0, width), map(waveform.data[i], -0.5, 0.5, 0, height));
      }
      RShape tmpShape = new RShape(new RPath(arrTmp));
      addToArray(tmpShape);
    }
    else
    {
      RShape grp = RG.getText(newWord, "humane-regular.ttf", 200, CENTER);
      grp.translate(width/2,180);
      RStyle s = new RStyle();
      s.setFill(color(0,255,224));
      grp.setStyle(s);
      addToArray(grp);
      newWord = null;
    }
  }
  for(int i=0;i<shapes.length;i++)
  {  
    //stroke(0, 255, 224,);
    float alpha = map(i,shapes.length/2,shapes.length,1.0,0);
    pushMatrix();
    translate(i*6.25,sin(map(i,0,shapes.length,0,PI))*-30 );//constrain(map(i,shapes.length/2,shapes.length,0,15),0,105));
    float scaleVal = map(i,0,shapes.length,1.0,0.5);
    scale(scaleVal,scaleVal);
    shapes[i].setAlpha(alpha);
    shapes[i].draw();
    popMatrix();
    //println(shapes[i].setStyle(new Style));
  }
}





void addToArray(RShape shape) {
  System.arraycopy(shapes, 0, shapes, 1, shapes.length - 1);
  shapes[0] = shape;
}
