import processing.sound.*;
import geomerative.*;

FFT fft;
AudioIn in;
int bands = 256;
int smoothBands = 16;
float[] spectrum = new float[bands];
String[] words = {"hello", "what's", "up", "how", "are", "you", "set", "a", "timer", "for", "5", "minutes", "play", "some", "music", "what's", "the", "weather", "like", "today", "tell", "me", "a", "joke", "what's", "the", "time", "search", "for", "pizza", "restaurants", "near", "me", "turn", "on", "the", "lights"};



/** PARTICLES **/
int numParticles = 256;
int numRows = 16;
int numCols = 16;
ParticleSpring[] particles = new ParticleSpring[numParticles];

PVector attractorPos = new PVector(width/2, height/2);


/** GEOMETRATIVE **/

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] points;

void setup() {
  size(512, 360);
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
}      

void draw() { 
  background(0);
  fill(0,255,223,128);
  stroke(0,255,223,128);
  fft.analyze(spectrum);

  for(int i = 0; i < smoothBands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  float x = i* (width/(smoothBands));

  //line(x, height/2, x, height/2 - map(spectrum[i],0,0.001,-height/2,height/2) );
    ellipse(x, height/2 - map(spectrum[i],0,0.05,0,height/4) ,20,20);
  } 
  
  // SHAPE
  
  RG.setPolygonizer(RG.ADAPTATIVE);
  grp.draw();
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
  points = grp.getPoints();
  // If there are any points
  if(points != null){
    noFill();
    stroke(0,225,224);
    
    //beginShape();
    //for(int i=0; i<points.length; i++){
    //  vertex(width/2+points[i].x, height/2+points[i].y);
    //}
    //endShape();
  
    fill(0,255,224,50);
    stroke(0,255,224,20);
    for(int i=0; i<points.length; i++){
      ellipse(width/2+points[i].x,height/2+ points[i].y,5,5);  
    }
  }
  updateTargets();
  updateParticles();
}

void updateTargets()
{
  for(int i=0; i< particles.length;i++)
  {
   
    var indexSpectrum = floor(particles[i].position.x/width)*(smoothBands);
    
    particles[i].setTarget(new PVector(particles[i].position.x,height/2 - map(spectrum[indexSpectrum],0,0.05,0,height/2)));
  }
}
