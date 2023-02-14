import processing.sound.*; //<>//
import geomerative.*;
import de.looksgood.ani.*;
import controlP5.*;

/** UI CONTROL **/
ControlP5 cp5;
Accordion accordion;

/** FFT,WAVE AND AUDIO IN**/
FFT fft;
AudioIn in;
int bands = 256;
int smoothBands = 16;
float[] spectrum = new float[bands];
String[] words = {"hello", "what's", "up", "how", "are", "you", "set", "a", "timer", "for", "5", "minutes", "play", "some", "music", "what's", "the", "weather", "like", "today", "tell", "me", "a", "joke", "what's", "the", "time", "search", "for", "pizza", "restaurants", "near", "me", "turn", "on", "the", "lights"};
int wordsIndex = 0;
Waveform waveform;
int waveFormSamples = 256;
Amplitude amp;

/* STRING TO DISPLAY */
String newWord = null;
String wordToDisplay = "";

/** PARTICLES **/
int numParticles = 256;
int numRows = 16;
int numCols = 16;
ParticleSpring[] particles = new ParticleSpring[numParticles];

PVector attractorPos = new PVector(width/2, height/2);

/* DOTS */
final static int pixelNumW = 160;
final static int pixelNumH = 80;
final static int numPixels = pixelNumW*pixelNumH;
Dot[] dots = new Dot[numPixels];

/** RIPPLE **/
float valuesRipple[] = new float[pixelNumW];

/** WAVE_SHAPE **/
RShape workingShape = new RShape();
RPoint[] workingPointArray = new RPoint[numParticles];


/** ANIMATION **/
float animationValue= 0.0;
Ani bAni;

/** GEOMETRATIVE **/
RFont f;
RShape grp;
RPoint[] pointsText = new RPoint[0];



void setup() {
  size(800, 400);
  background(255);

  // start the Audio Input
  in = new AudioIn(this, 0);
  in.start();


  //Start particles
  initParticlesSpring();
  changeCurve();
  /** UI **/
  initGUI(this);

  /** GEOMETRATIVE **/
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);
  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("Hello", "humane-vf.ttf", 200, CENTER);


  // Enable smoothing
  smooth();

  //--------------------------------------
  int index = 0;
  float unitY = (height/pixelNumH);
  float unitX = (width/pixelNumW);

  for (int y=0; y<height; y+=unitY)
  {
    for (int x=0; x<width; x+=unitX)
    {

      if (index<numPixels)
      {
        dots[index] = new Dot(x+unitX/2-width/2, y+unitY/2-height/2);
      }
      index ++;
    }
  }
  println(dots.length);

  Ani.init(this);

  initOSC();
}

void draw() {
  background(0);
  fill(0, 255, 223, 128);
  stroke(0, 255, 223, 128);
  pushMatrix();
  translate(width/2, height/2);

  updateWaveForm();
  updateTargets();
  updateParticlesSpring();
  updateSizeDots();
  updateWord();

  for (int i=0; i < numPixels-1; i++)
  {
    dots[i].show();
    dots[i].update();
  }

  popMatrix();
}



void updateTargets()
{
  //switch(waveFormState)
  //{
  //  case WAVE_SHAPE:
  //  {
  //    break;
  //  }
  //}

  for (int i=0; i< particles.length; i++)
  {
    
    switch (waveFormState) {
    case FFT:
      {
        int indexSpectrum = constrain(abs((int)map((particles[i].position.x + width/2), 0, width, -smoothBands*2, smoothBands*2)), 0, particles.length);
        particles[i].setTarget(new PVector(particles[i].position.x, height * -0.10 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
        break;
      }
    case WAVE:
      {
        int indexSpectrum = constrain((int)map((particles[i].position.x + width/2), 0, width, 0, bands/2), 0, bands/2);
        particles[i].setTarget(new PVector(particles[i].position.x, height * -0.10 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
        break;
      }
    case RIPPLE:
      {

        PVector center = new PVector(0, 0);
        PVector direction = PVector.sub(particles[i].position, center);
        direction.normalize();
        direction.mult(map(valuesRipple[0], 0.0, 0.25, 1, 100));
        PVector targetVector =  PVector.add(particles[i].originalPos, direction);
        if (PVector.dist(center, targetVector)>width)
        {
          targetVector = new PVector(0, 0);
        }
        particles[i].setTarget(targetVector);

        //int indexSpectrum = constrain((int)map((particles[i].position.x + width/2), 0, width, 0, bands/2), 0, bands/2);
        //particles[i].setTarget(new PVector(particles[i].position.x, height * -0.10 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
        break;
      }
    case TYPOGRAPHY:
      break;
    case WAVE_SHAPE:
      {

        int indexSpectrum = constrain((int)map((particles[i].position.x + width/2), 0, width, 0, bands/2), 0, bands/2);
        particles[i].setTarget(new PVector(particles[i].position.x, height * -0.05 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
        workingPointArray[i] = new RPoint(particles[i].position.x, particles[i].position.y);
       

        break;
      }
    }
  }
  switch(waveFormState)
  {
  case WAVE_SHAPE:
    {
      //workingShape = workingShape.union(grp);
      workingPointArray[0] = new RPoint(-width/2-20, 0);
      workingPointArray[numParticles-3] = new RPoint(width/2+20, 0);
      workingPointArray[numParticles-2] = new RPoint(width/2+20, height);
      workingPointArray[numParticles-1] = new RPoint(-width/2-20, height);
      workingShape = new RShape(new RPath(workingPointArray));
      workingShape.draw();
      if(grp!=null)
      {
        RShape txt = new RShape(grp);

        txt.translate(0,map(animationValue,1,0,height/2,-height*offsetY));
        workingShape = workingShape.union(txt);
        
      }
      break;
    }
    //if(waveFormState == FFT)
    //{
    //  int indexSpectrum =   constrain( abs((int)map( (particles[i].position.x+width/2)  ,0,width,-smoothBands*2,smoothBands*2) ),0,particles.length ); //floor((particles[i].position.x+width/2)/width ) *(smoothBands);
    //  particles[i].setTarget( new PVector(  particles[i].position.x, height*-0.10 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
    //}
    //else if(waveFormState == WAVE)
    //{
    //  int indexSpectrum =   constrain((int)map( (particles[i].position.x + width/2)  ,0 , width ,0,bands/2),0,bands/2); //floor((particles[i].position.x+width/2)/width ) *(smoothBands);
    //  particles[i].setTarget( new PVector(  particles[i].position.x, height*-0.10 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/4)));
    //}
    //else if(waveFormState == RIPPLE)
    //{
    //  //println("updatingPartiles");
    //}
    //else if(waveForm)
  }
}
