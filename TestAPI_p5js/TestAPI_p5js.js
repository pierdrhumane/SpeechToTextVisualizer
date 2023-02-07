let mic;
let fft;
var workingMicLev = 0;
function setup() {
  var cnv = createCanvas(windowWidth, windowHeight);
   cnv.mousePressed(userStartAudio);
  
    mic = new p5.AudioIn();
    mic.start();
    fft = new p5.FFT(0.9,16);

    console.log(mic.getSources());
  
}

function draw(){
  background(0);
  
  workingMicLev = map(mic.getLevel(),0,1.0,100,500);
  
  ellipse(width/2,height/2,workingMicLev,workingMicLev);

 

  
}
