import processing.sound.*;
import geomerative.*;
import de.looksgood.ani.*;


FFT fft;
AudioIn in;
int bands = 256;
int smoothBands = 16;
float[] spectrum = new float[bands];
String[] words = {"hello", "what's", "up", "how", "are", "you", "set", "a", "timer", "for", "5", "minutes", "play", "some", "music", "what's", "the", "weather", "like", "today", "tell", "me", "a", "joke", "what's", "the", "time", "search", "for", "pizza", "restaurants", "near", "me", "turn", "on", "the", "lights"};
int wordsIndex = 0;


/** PARTICLES **/
int numParticles = 256;
int numRows = 16;
int numCols = 16;
ParticleSpring[] particles = new ParticleSpring[numParticles];

PVector attractorPos = new PVector(width/2, height/2);

/* DOTS */
final static int pixelNumW = 150;
final static int pixelNumH = 75;
final static int numPixels = pixelNumW*pixelNumH;
Dot[] dots = new Dot[numPixels];

/** ANIMATION **/
float b = 0.0;
Ani bAni;

/** GEOMETRATIVE **/

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] pointsText = new RPoint[0];

void setup() {
  size(800, 400);
  background(255);

  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);

  // start the Audio Input
  in.start();

  // patch the AudioIn
  fft.input(in);

  //Start particles
  initParticlesSpring();



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
}

void draw() {
  background(0);
  fill(0, 255, 223, 128);
  stroke(0, 255, 223, 128);
  translate(width/2,height/2);
  fft.analyze(spectrum);

  for (int i = 0; i < smoothBands; i++) {
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    float x = i* (width/(smoothBands));

    //line(x, height/2, x, height/2 - map(spectrum[i],0,0.001,-height/2,height/2) );
    ellipse(x-width/2, height/2 - map(spectrum[i], 0, 0.05, 0, height/4), 20, 20);
  }

  
  //// If there are any points
  //if (pointsText != null) {
  //  noFill();
  //  stroke(0, 225, 224);

  //  //beginShape();
  //  //for(int i=0; i<points.length; i++){
  //  //  vertex(width/2+points[i].x, height/2+points[i].y);
  //  //}
  //  //endShape();

  //  fill(0, 255, 224, 50);
  //  stroke(0, 255, 224, 20);
  //  for (int i=0; i<pointsText.length; i++) {
  //    ellipse(pointsText[i].x,  pointsText[i].y, 5, 5);
  //  }
  //}
  updateTargets();
  updateParticles();
  updateSizeDots();
  
  for (int i=0; i < numPixels-1; i++)
  {  
      dots[i].show();
      dots[i].update();
  }
  
}

void getTextPoints()
{
  //GET NEW TEXT
  grp = RG.getText(words[wordsIndex], "humane-vf.ttf", 200, CENTER);
  
  // SHAPE
  RG.setPolygonizer(RG.ADAPTATIVE);
  grp.draw();

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
  pointsText = grp.getPoints();
}
void updateTargets()
{
  for (int i=0; i< particles.length; i++)
  {

    var indexSpectrum = floor((particles[i].position.x+width/2)/width ) *(smoothBands);

    particles[i].setTarget(new PVector(particles[i].position.x, height/2 - map(spectrum[indexSpectrum], 0, 0.05, 0, height/2)));
  }
}
