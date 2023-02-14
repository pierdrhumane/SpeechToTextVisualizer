import processing.sound.*;
import geomerative.*;
import de.looksgood.ani.*;
import controlP5.*;
import java.util.Iterator;

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

PVector attractorPos = new PVector(width/2, height/2);

/* DOTS */
final static int pixelNumW = 160;
final static int pixelNumH = 80;
final static int numPixels = pixelNumW*pixelNumH;
Dot[] dots = new Dot[numPixels];

///** RIPPLE **/
//float valuesRipple[] = new float[pixelNumW];

///** WAVE_SHAPE **/
//RShape workingShape = new RShape();
//RPoint[] workingPointArray = new RPoint[numParticles];


/** ANIMATION **/
float animationValue= 0.0;
Ani bAni;

/** GEOMETRATIVE **/
RFont f;
RShape grp;
RPoint[] pointsText = new RPoint[0];

/** TYPOGRAPHY **/
ArrayList<CharContainer> wordsContainer = new ArrayList<CharContainer>();

float lerpValue = 0;

/* BACKGROUND */
float depthBg, progressNoiseField;

void setup() {
  size(800, 400);
  background(255);

  // start the Audio Input
  in = new AudioIn(this, 0);
  in.start();

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

 initDots();

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
  updateSizeDots();
  updateWord();
  
  drawCharacters();
  
  for (int i=0; i < numPixels-1; i++)
  {
    dots[i].show();
    dots[i].update();
  }

  popMatrix();
}
