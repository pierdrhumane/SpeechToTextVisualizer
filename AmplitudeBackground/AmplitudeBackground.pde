import processing.sound.*;
import geomerative.*;
import de.looksgood.ani.*;

/** AUDIO **/
Amplitude amp;
AudioIn in;

/** VISuALIZATION **/
color laser = color(0,255,224);
color black = color(0,0,0);
color fillColor = color(0,0,0);
float ampVal = 0;
float workingSize = 0;
String wordToDisplay;

/** ANIMATION **/
float b = 0.0;
Ani bAni;
PFont humaneFont;

void setup() {
  size(640, 640);
  background(255);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  
  //INIT OTHERS
   RG.init(this);
   initOSC();
   Ani.init(this);
    
    // The font "andalemo.ttf" must be located in the 
  // current sketch's "data" directory to load successfully
  humaneFont = createFont("humane-black.ttf", 128);
  textFont(humaneFont);
  textAlign(CENTER,CENTER);
}      

void draw() {
  ampVal = amp.analyze();
  background(0,0,0);
  fillColor = lerpColor(black,laser,map(ampVal,0.0,0.25,0.5,1.0));
  fill(fillColor);
  translate(width/2,height/2);
  workingSize = map(ampVal,0.0,0.25,400,600);
  ellipse(0,0,workingSize,workingSize);
   long currentTime = millis();
    if (currentTime - lastTime >= 25) {
      if(newWord != null)
      {
        
        //RShape grp = RG.getText(newWord, "humane-regular.ttf", 200, CENTER);
        ////grp.translate(0,180);
        //RStyle s = new RStyle();
        //s.setFill(color(0,255,224));
        //grp.setStyle(s);
        //grp.draw();
        wordToDisplay = newWord;
        newWord = null;
        
        displayWord();
      }
    }
    if(b>0)
    {
      
      fill(lerpColor(fillColor,black,b));
      text(wordToDisplay,0,-32);
    }
}
