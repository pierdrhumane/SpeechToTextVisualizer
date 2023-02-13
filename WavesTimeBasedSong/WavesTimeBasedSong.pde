import processing.sound.*;
import geomerative.*;


SoundFile sample;
Waveform waveform;

RShape[] shapes = new RShape[30];
int samples = 256;


long lastTime;
String newWord = null;

//import ddf.minim.*;

//Minim minim;
//AudioPlayer player;


/** LYRICS **/
String[] lines;
String[][] words;
float[] times;
int wordIndex = 0;
int lineIndex = 0;

float previousTime = 0;
float delayDuration = 500; // in milliseconds


void setup()
{
  size(640, 360);
  background(255);

  sample = new SoundFile(this, "blueMonday.wav");
  sample.loop();
  sample.jump(37);
  
  waveform = new Waveform(this, samples);
  waveform.input(sample);

  lastTime = millis();

  RG.init(this);

  for (int i=0; i<shapes.length; i++)
  {
    shapes[i] =  new RShape();
  }

  /** LOAD WORDS **/
  lines = loadStrings("blueMonday.lrc");

  words = new String[lines.length][];
  times = new float[lines.length];

  for (int i = 0; i < lines.length; i++) {
    int firstBracket = lines[i].indexOf("[");
    int lastBracket = lines[i].indexOf("]");
    String timeString = lines[i].substring(firstBracket + 1, lastBracket);
    int time = getTime(timeString);
    times[i] =  time/1000.0 ;

    String line = lines[i].substring(lastBracket + 1);
    words[i] = line.split(" ");
  }
  println(times);
  textSize(100);
}

void draw()
{
  background(0);
  stroke(0, 255, 224);
  strokeWeight(2);
  noFill();


  waveform.analyze();
  AudioSample sampleTmp = ((AudioSample)sample);
  float timePosition = sampleTmp.position() - 0.5;
  //println(timePosition);
  if (timePosition >= times[lineIndex] && millis() - previousTime >= delayDuration) {
    String word = words[lineIndex][wordIndex];
    newWord = word;
    text(word, 0,0);
    previousTime = millis();
    wordIndex++;
    if (wordIndex >= words[lineIndex].length) {
      wordIndex = 0;
      lineIndex++;
      if (lineIndex >= lines.length) {
        lineIndex = 0;
      }
    }
  }



  long currentTime = millis();
  if (currentTime - lastTime >= 25) {
    if (newWord == null)
    {
      lastTime = currentTime;
      RPoint[] arrTmp = new RPoint[samples];
      for (int i = 0; i < samples; i++)
      {

        arrTmp[i] = new RPoint(  map(i, 0, samples, 0, width), map(waveform.data[i], -0.5, 0.5, 0, height));
      }
      RShape tmpShape = new RShape(new RPath(arrTmp));
      addToArray(tmpShape);
    } else
    {
      RShape grp = RG.getText(newWord, "humane-regular.ttf", 200, CENTER);
      grp.translate(width/2, 180);
      RStyle s = new RStyle();
      s.setFill(color(0, 255, 224));
      grp.setStyle(s);
      addToArray(grp);
      newWord = null;
    }
  }
  for (int i=0; i<shapes.length; i++)
  {
    //stroke(0, 255, 224,);
    float alpha = map(i, shapes.length/2, shapes.length, 1.0, 0);
    pushMatrix();
    translate(i*6.25, sin(map(i, 0, shapes.length, 0, PI))*-30 );//constrain(map(i,shapes.length/2,shapes.length,0,15),0,105));
    float scaleVal = map(i, 0, shapes.length, 1.0, 0.5);
    scale(scaleVal, scaleVal);
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
