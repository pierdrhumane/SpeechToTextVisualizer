class ParticleCharacter {
  PVector startPoint, middlePoint, endPoint;
  color c;

  float startRotation, middleRotation, endRotation;

  PVector currentPos;
  float currentRotation;

  PVector prevPos;
  float prevRotation;

  String character;
  RShape shape;
  RShape drawableShape;

  ParticleCharacter(String s, float x, float y, RShape s_) {
    initPath();
    c = color(random(0, 255), random(0, 255), random(0, 255));
    character = s;

    middlePoint = new PVector(x, y);
    middleRotation = 0;
    shape = s_;
    prevRotation = 0;
    prevPos = new PVector(x, y);
  }

  void initPath() {
    startPoint  = new PVector(random(-width/2, width/2), random(height/4, height/2));
    endPoint    = new PVector(random(-width/4, width/4), random(-height/2,-height/4));
    startRotation = random(90);
    endRotation = random(90);
  }



  void update(float lerpValue, float animationValue) {

    if (animationValue<=0.5)
    {
      currentPos = PVector.lerp(startPoint, middlePoint, lerpValue );
      currentRotation = lerp(startRotation, middleRotation, lerpValue);
    } else
    {
      currentPos = PVector.lerp(middlePoint, endPoint, lerpValue );
      currentRotation = lerp(middleRotation, endRotation, lerpValue);
    }
    //PVector translator = new PVector(prevPos.x-currentPos.x, prevPos.y-currentPos.y);
    //float diffRotation = currentRotation - prevRotation;

    fill(red(c), green(c), blue(c), map(animationValue, 0.75, 1, 255, 0));
   
    RPoint[] transformedPoints = shape.getPoints();
    
    if(transformedPoints == null)
   {
     return;
   }
    for (int i = 0; i < transformedPoints.length; i++) {
      RPoint point = transformedPoints[i];
      float x = point.x;
      float y = point.y;
      x = x * cos(radians(currentRotation)) - y * sin(radians(currentRotation));
      y = x * sin(radians(currentRotation)) + y * cos(radians(currentRotation));
      x += currentPos.x;
      y += currentPos.y;
      transformedPoints[i] = new RPoint(x, y);
    }
    drawableShape = new RShape(new RPath(transformedPoints));
    //drawableShape.draw();
    //pushMatrix();
    //translate(currentPos.x, currentPos.y);
    //rotate(radians(currentRotation));
    ////shape.draw();
    //rect(0, 10, 30, 30);
    //ellipse(0, 0, 30, 30);
    //fill(255);
    ////text(character, 0, 0);
    //popMatrix();

  }
  void resetPath()
  {
    startPoint.x = endPoint.x;
    startPoint.y = endPoint.y;
    startRotation = endRotation;
  }
}

void drawCharacters()
{

  for (CharContainer w : wordsContainer)
  {
    if (w.didEnd)
    {
      continue;
    }
    float lVal = 0.0;
    float aVal = w.animVal;
    if (aVal<=0.5)
    {
      lVal = map2( 1.0-abs(aVal*2 -1), 0, 1, 0, 1, EXPONENTIAL, EASE_IN_OUT);
    } else
    {
      lVal = map2( ( aVal*2 -1), 0, 1, 0, 1, EXPONENTIAL, EASE_IN_OUT);
    }
    for (int i = 0; i < w.particles.length; i++) {
      if (w.particles[i]!=null)
      {
        w.particles[i].update(lVal, aVal);
      }
    }
  }
  //fill(255);
  //text(wordsContainer.size()+"", 30, 30);
  //text(nf(animationValue, 1, 1)+" : "+nf(lerpValue, 1, 1)+" : "+nf( animationValue*2 -1, 1, 1), 30, 30);
}
