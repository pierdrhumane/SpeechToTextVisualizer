import processing.sound.*;
import geomerative.*;




/** SOUND - MICROPHONE **/
AudioIn in;
Waveform waveform;

final static int samples = 256;


/** UTILS AND PARTICLES **/
Particle p[] = new Particle[samples];

void setup() {
  size(400, 400);
  background(255);
  RG.init(this);
  /** INIT PARTICLES **/
  for(int i = 0;i<p.length;i++)
  {
    float angle = map(i,0,p.length,0,TWO_PI);
    Particle pTmp = new Particle(cos(angle)*width/4, sin(angle)*height/4, 1, 0.1, 0.1);
    p[i] = pTmp;
  }
  
  /** INIT AUDIO **/
  in = new AudioIn(this, 0);
  in.start();
  waveform = new Waveform(this, samples);
  waveform.input(in);
}

void draw() {
  background(0,0,0);
  
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
  
}
void keyPressed()
{
  if(key == 'n')
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
}
