class ParticleCharacter {
  PVector startPoint, middlePoint, endPoint;
  color c;

  float startRotation, middleRotation, endRotation;

  PVector currentPos;
  float currentRotation;
  
  String character;

  ParticleCharacter(String s, float x, float y) {
    initPath();
    c = color(random(0, 255), random(0, 255), random(0, 255));
    character = s;
    
    middlePoint = new PVector(x,y);
    middleRotation = 0;
    
  }

  void initPath() {
    startPoint  = new PVector(random(width), random(height));
    endPoint    = new PVector(random(width), random(height));
    startRotation = random(360);
    endRotation = random(360);
  }



    void update(float lerpValue,float animationValue) {

   if(animationValue<=0.5)
   {
    currentPos = PVector.lerp(startPoint, middlePoint, lerpValue );
    currentRotation = lerp(startRotation, middleRotation, lerpValue);
   }
   else
   {
     currentPos = PVector.lerp(middlePoint, endPoint, lerpValue );
    currentRotation = lerp(middleRotation, endRotation, lerpValue);
   }
   
    fill(c);
    alpha((int)lerpValue*255);
    pushMatrix();
    translate(currentPos.x, currentPos.y);
    rotate(radians(currentRotation));
    fill(c);
    rect(0,10,30,30);
    ellipse(0, 0, 30, 30);
    fill(255);
    text(character,0,0);
    popMatrix();
  }
  void resetPath()
  {
    startPoint.x = endPoint.x;
    startPoint.y = endPoint.y;
    startRotation = endRotation;
  }
}
