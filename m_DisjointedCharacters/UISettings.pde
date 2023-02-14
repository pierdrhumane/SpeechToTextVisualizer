//ADD UI FOR
//Change between waveform and fft
//Change properties of particles
//     Change damping and try to get less delay
//

final static int WAVE = 0;
final static int FFT = 1;
final static int RIPPLE = 2;
final static int TYPOGRAPHY = 3;
final static int WAVE_SHAPE = 4;

final static int numOfStates = 1;
final static String[] stateNames= {"Typography"};

int waveFormState = TYPOGRAPHY;
controlP5.Controller<Textlabel> label;
float offsetY = 0.05;
float offsetX = 1.0;

void initGUI(PApplet p)
{
  cp5 = new ControlP5(p);

  Group g3 = cp5.addGroup("settings")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  
  //cp5.addBang("swap_crv")
  //   .setPosition(10,20)
  //   .setSize(40,50)
  //   .moveTo(g3)
  //   ;
     
  cp5.addSlider("offsetY")
     .setPosition(60,20)
     .setSize(100,20)
     .setRange(-0.5,0.5)
     .setValue(0.05)
     .moveTo(g3)
     ;
     
  cp5.addSlider("offsetX")
     .setPosition(60,50)
     .setSize(100,20)
     .setRange(-1.0,3.0)
     .setValue(1.0)
     .moveTo(g3)
     ;
   label = cp5.addLabel("FFT").setPosition(60,90)
     .setSize(100,20)
     .setValue("FFT")
     .moveTo(g3)
     ;
  accordion = cp5.addAccordion("acc")
    .setPosition(width-200, 0)
    .setWidth(200)
    .addItem(g3);

  accordion.close(0, 1, 2);
  // use Accordion.MULTI to allow multiple group
  // to be open at a time.
  accordion.setCollapseMode(Accordion.SINGLE);
}

void swap_crv() {
  
 
}
