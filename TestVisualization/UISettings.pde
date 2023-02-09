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
final static int numOfStates = 5;

int waveFormState = FFT;

void initGUI(PApplet p)
{
  cp5 = new ControlP5(p);

  Group g3 = cp5.addGroup("settings")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150)
                ;
  
  cp5.addBang("swap_crv")
     .setPosition(10,20)
     .setSize(40,50)
     .moveTo(g3)
     ;
     
  cp5.addSlider("max_size")
     .setPosition(60,20)
     .setSize(100,20)
     .setRange(100,500)
     .setValue(100)
     .moveTo(g3)
     ;
     
  cp5.addSlider("min_size")
     .setPosition(60,50)
     .setSize(100,20)
     .setRange(100,500)
     .setValue(200)
     .moveTo(g3)
     ;

  accordion = cp5.addAccordion("acc")
    .setPosition(width-200, 0)
    .setWidth(200)
    .addItem(g3);

  accordion.open(0, 1, 2);
  // use Accordion.MULTI to allow multiple group
  // to be open at a time.
  accordion.setCollapseMode(Accordion.SINGLE);
}

void swap_crv() {
  
  waveFormState = (waveFormState+1)%numOfStates;
  changeCurve();
  println("change curve:"+waveFormState);
  //c = color(random(255),random(255),random(255),random(128,255));
}
