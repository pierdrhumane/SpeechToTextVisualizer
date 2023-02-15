import processing.sound.*;
import geomerative.*;




/** SOUND - MICROPHONE **/
AudioIn in;
Waveform waveform;

final static int samples = 512;


/** UTILS AND PARTICLES **/
Particle p[] = new Particle[samples];


/** INCOMING WORDS **/
String newWord;

/** GEOMETRATIVE **/
RFont f;
RShape grp;
RPoint[] pointsText = new RPoint[0];
String[] words = {"hello", "what's", "up", "how", "are", "you", "set", "a", "timer", "for", "5", "minutes", "play", "some", "music", "what's", "the", "weather", "like", "today", "tell", "me", "a", "joke", "what's", "the", "time", "search", "for", "pizza", "restaurants", "near", "me", "turn", "on", "the", "lights"};
int wordsIndex = 0;

/** BOTTOM BAR **/
PImage bottomBar;

void setup() {
  size(800, 720);
  background(255);
  RG.init(this);
  /** INIT PARTICLES **/
  initParticles();
  
  /** INIT AUDIO **/
  in = new AudioIn(this, 0);
  in.start();
  waveform = new Waveform(this, samples);
  waveform.input(in);

  /** INIT **/
  initGeomerative();
  
  /** INIT OSC **/
  initOSC();
  
  /** BOTTOM BAR **/
  bottomBar = loadImage("Bottom Bar.png");
}

void draw() {
  background(0,0,0);
  pushMatrix();
   translate(width/2,height/2);
  
  waveform.analyze();
  
  for (int i = 0; i < samples; i++)
  { 
    p[i].addForce( map(waveform.data[i], -0.5, 0.5, -100, 100));
  }
  
  for(int i = 0;i<p.length;i++)
  {
    p[i].update();
    p[i].display();
  }
  popMatrix();
  image(bottomBar,0,height-84);
  
}
void keyPressed()
{
  if(key == 'b')
  {
    PVector target =  new PVector();
    target.x = mouseX-width/2;
    target.y = mouseY-height/2;
    //p.setTarget(target);
  }
  else if(key == 'm')
  {
    for(int i = 0;i<p.length;i++)
    { 
      p[i].addForce(random(-10,10));
    }
  }
  else if(key == 'n')
  {
    String wordTmp = words[wordsIndex];
    wordsIndex = (wordsIndex+1)%words.length;
    
   updateWord(wordTmp);
  }
}
void updateWord(String newWord_)
{
   RPoint[] points = getPoints(newWord_);
    for(int i = 0;i<p.length;i++)
    { 
      int pointIndex = i;
      while (pointIndex > points.length-1) {
        pointIndex = pointIndex - points.length;
      }
      RPoint tmp = points[pointIndex];
      p[i].setTarget(new PVector(tmp.x,tmp.y));
      p[i].setNoiseAmount(2);
    }
}
