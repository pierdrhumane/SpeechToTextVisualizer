ArrayList<PVector> getTextOutlines(String text) {
  PFont font = createFont("Arial", 32);
  textFont(font);
  int textWidth = (int)textWidth(text);
  int textHeight = (int)textAscent() + (int)textDescent();
  PGraphics canvas = createGraphics(textWidth, textHeight);
  canvas.beginDraw();
  canvas.background(255);
  canvas.fill(0);
  canvas.textAlign(CENTER, CENTER);
  canvas.text(text, textWidth/2, textHeight/2);
  canvas.endDraw();
  
  ArrayList<PVector> outlinesTmp = new ArrayList<PVector>();
  canvas.loadPixels();
  for (int x = 0; x < textWidth; x+=2) {
    for (int y = 0; y < textHeight; y+=2) {
      int loc = x + y * textWidth;
      int c = canvas.pixels[loc];
      if (brightness(c) < 128) {
        outlinesTmp.add(new PVector(x, y));
      }
    }
  }
  return outlinesTmp;
}

void getTextPoints()
{
  //GET NEW TEXT
  grp = RG.getText(wordToDisplay, "humane-vf.ttf", 150, CENTER);
  
  // SHAPE
  RG.setPolygonizer(RG.ADAPTATIVE);
  //grp.draw();

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
  pointsText = grp.getPoints();
  for(CharContainer w : wordsContainer)
  {
    w.outro();
  }
  
  CharContainer wc = new CharContainer();
  wordsContainer.add(wc);
  
  //ADDING A SHAPE FOR EVERY CHARACTER:
  char[] cTmp =   wordToDisplay.toCharArray();
  wc.charShapes = new RShape[cTmp.length];
  wc.particles = new ParticleCharacter[cTmp.length];
  wc.internalWord = wordToDisplay;
  
  for (int i = 0; i < cTmp.length; i++) {
    wc.charShapes[i] = RG.getText(cTmp[i]+"", "humane-vf.ttf", 150, LEFT);
    float x = map(i,0,cTmp.length, - (cTmp.length) / 2 * offsetX*100 ,(cTmp.length)/2 * offsetX*100);
    float y = 0; 
    wc.particles[i] = new ParticleCharacter(cTmp[i]+"",x+50,y,wc.charShapes[i]);
   
  }
   wc.play();

}
