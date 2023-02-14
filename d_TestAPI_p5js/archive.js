
//function draw() {
//  background(0);
//  stroke(255);
//  ellipse(100,100,50,50);
//  if(started)
//  {
//    let spectrum = fft.analyze();
//    fill(255);
    
//    console.log(mic.getLevel(),spectrum,fft.waveform());
//    for (let i = 0; i < spectrum.length; i++) {
//      let x = map(i, 0, spectrum.length, 0, width);
//      let h = -height + map(spectrum[i], 0, 15, height, 0);
//      rect(x, height, width / spectrum.length, h);
//    }
//  }
//}
