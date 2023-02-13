class Dot {
  PVector pos;
  float size = 3;
  float minSize = 0;
  float maxSize = 10;
  float targetSize = size;

  public Dot(float x_, float y_)
  {
    pos = new PVector(x_, y_);
  }

  public void show()
  {
    noStroke();
    fill(0, 255, 224);
    ellipse(pos.x, pos.y, size, size);
  }
  public void update()
  {
    //smoothly change the size towards the target size
    size = lerp(size, targetSize, 0.5);
  }
  public void changeSize(float newSize)
  {
    targetSize = newSize; //update the target size
  }
}

void initDots()
{
  //-------------------------------------- d
  int index = 0;
  float unitY = (height/pixelNumH);
  float unitX = (width/pixelNumW);

  for (int y=0; y<height; y+=unitY)
  {
    for (int x=0; x<width; x+=unitX)
    {

      if (index<numPixels)
      {
        dots[index] = new Dot(x+unitX/2-width/2 + (random(unitX)-unitX/2), y+unitY/2-height/2 + (random(unitY)-unitY/2));
      }
      index ++;
    }
  }
  println(dots.length);
}
void updateSizeDots()
{
  switch(waveFormState)
  {
  case TYPOGRAPHY:
   
    RShape masterShape = new RShape();

    for (WordContainer w : wordsContainer)
    {
      for (int i = 0; i < w.particles.length; i++) {
        if (w.particles[i]!=null)
        {
          if(w.particles[i].drawableShape != null)
          {
            masterShape= masterShape.union(w.particles[i].drawableShape);
          }
        }
      }
    }
    
    RPoint[] pointsTmp = masterShape.getPoints();
    for (int i=0; i < numPixels-1; i++)
    {

      float closestParticle= findClosestFast(pointsTmp,dots[i].pos);//PVector.dist(new PVector(mouseX-width/2, mouseY-height/2), dots[i].pos);
      dots[i].changeSize( constrain( map(closestParticle, 0, 30, 5, 0 ), 1, 15) );
    }
    break;
  }
}

float findClosest(RPoint[] points, PVector reference) {
  //RPoint closest = null;
  float closestDistance = Float.MAX_VALUE;

  for (RPoint point : points) {
    float distance = dist(point.x, point.y, reference.x, reference.y);
    if (distance < closestDistance) {
      //closest = point;
      closestDistance = distance;
    }
  }

  return closestDistance;
}
float findClosestFast(RPoint[] points, PVector reference) {
  if(points == null)
  {
    return 160000;
  }
  int n = points.length;
  float closestDistance = Float.MAX_VALUE;
  //RPoint closestPoint = null;

  for (int i = 0; i < n; i++) {
    RPoint point = points[i];
    float distance = dist(point.x, point.y, reference.x, reference.y);
    if (distance < closestDistance) {
      //closestPoint = point;
      closestDistance = distance;
    }
  }

  return closestDistance;
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
