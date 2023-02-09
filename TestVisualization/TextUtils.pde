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
void findClosestPoints(RShape shape, RPoint[] points, RPoint inPoint) {
  RPoint pointA = points[0];
  RPoint pointB = points[0];
  float minDist = Float.MAX_VALUE;
  PVector pVec = new PVector(inPoint.x,inPoint.y);
  for (int i = 0; i < points.length; i++) {
    for (int j = i + 1; j < points.length; j++) {
      RPoint a = points[i];
      RPoint b = points[j];
      
      PVector closestPoint = getClosestPoint(new PVector(a.x,a.y),new PVector(b.x,b.y), pVec);
      float dist = closestPoint.dist(pVec);
      if (dist < minDist) {
        minDist = dist;
        pointA = a;
        pointB = b;
      }
    }
  }

  // Determine if inPoint is inside shape
  boolean insideShape = shape.contains(inPoint);

  // Code to visualize the closest points and determine the distance from the line formed between them to inPoint
  // ...
}
PVector getClosestPoint(PVector a, PVector b, PVector inPoint) {
  PVector line = b.sub(a);
  PVector ap = inPoint.sub(a);
  float dot = ap.dot(line);
  if (dot <= 0.0) {
    return a;
  }
  float lineLength = line.mag();
  if (dot >= lineLength) {
    return b;
  }
  PVector projection = line.normalize().mult(dot);
  PVector result = a.add(projection);
  return result;
}
