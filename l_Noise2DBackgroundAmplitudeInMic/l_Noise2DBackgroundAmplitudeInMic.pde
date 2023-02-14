import processing.sound.*;

float wNoise, hNoise, depth, progressNoiseField;

/** AUDIO **/
Amplitude amp;
AudioIn in;

void setup() {
  size(500, 500);
  wNoise = 100;
  hNoise = 100;
  depth = 0.5;
  progressNoiseField = 0;
  
    // Create an Input stream which is routed into the Amplitude analyzer
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
}

void draw() {
  background(255);
  
  progressNoiseField += 0.01;
   depth = amp.analyze()*5.0; 
  for (float x = 0; x < width; x += width/wNoise) {
    for (float y = 0; y < height; y += height/hNoise) {
      float noiseValue = noise(x / width * 1.0 + progressNoiseField, y / height * 1.0);
      float adjustedValue = map(noiseValue, 0, 1, 0.5 - depth / 2, 0.5 + depth / 2);
      fill(255 * adjustedValue);
      rect(x, y, width/wNoise, height/hNoise);
    }
  }
}
