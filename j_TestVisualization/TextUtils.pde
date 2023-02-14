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
}
