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


void updateSizeDots()
{
  for (int i=0; i < numPixels-1; i++)
  {

    float closestText = 16000;

    if (pointsText.length >0)
    {
      closestText = findClosest(pointsText, dots[i].pos);
    }
    float closestParticle = findClosest(particles, dots[i].pos);
    float value = lerp(closestText, closestParticle, b);

    dots[i].changeSize( constrain(map(value, 0, 30, 5, 0 ), 1, 15));
  }
}
float findClosest(RPoint[] points, PVector reference) {
  RPoint closest = null;
  float closestDistance = Float.MAX_VALUE;

  for (RPoint point : points) {
    float distance = dist(point.x, point.y, reference.x, reference.y);
    if (distance < closestDistance) {
      closest = point;
      closestDistance = distance;
    }
  }

  return closestDistance;
}

float findClosest(ParticleSpring[] points, PVector reference) {
  ParticleSpring closest = null;
  float closestDistance = Float.MAX_VALUE;

  for (ParticleSpring point : points) {
    float distance = dist(point.position.x, point.position.y, reference.x, reference.y);
    if (distance < closestDistance) {
      closest = point;
      closestDistance = distance;
    }
  }

  return closestDistance;
}
