class Particle {
  PVector startPoint, middlePoint, endPoint;
  color c;

  float startRotation, middleRotation, endRotation;

  PVector currentPos;
  float currentRotation;

  Particle() {
    initPath();
    c = color(random(0, 255), random(0, 255), random(0, 255));
  }

  void initPath() {
    startPoint  = new PVector(random(width), random(height));
    middlePoint = new PVector(random(width), random(height));
    endPoint    = new PVector(random(width), random(height));
    startRotation = random(360);
    middleRotation = random(360);
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
    rect(0, 10, 30, 30);
    ellipse(0, 0, 30, 30);
    popMatrix();
  }
  void resetPath()
  {
    startPoint.x = endPoint.x;
    startPoint.y = endPoint.y;
    startRotation = endRotation;
  }
}
import de.looksgood.ani.*;
/** ANIMATION **/
float animationValue= 0.0;
Ani bAni;
Particle[] particles;
float lerpValue = 0;
void setup() {
  size(500, 500);
  Ani.init(this);
  particles = new Particle[5];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  background(0);
  //float lerpValue = (float)frameCount / 100.0;
   if (animationValue<=0.5)
    {
      lerpValue = map2( 1.0-abs(animationValue*2 -1), 0, 1, 0, 1, EXPONENTIAL, EASE_IN_OUT);
    } else
    {
      lerpValue = map2( ( animationValue*2 -1), 0, 1, 0, 1, EXPONENTIAL, EASE_IN_OUT);
    }
  for (int i = 0; i < particles.length; i++) {
    particles[i].update(lerpValue,animationValue);
  }
  fill(255);
  text(nf(animationValue, 1, 1)+" : "+nf(lerpValue, 1, 1)+" : "+nf( animationValue*2 -1, 1, 1), 30, 30);
}

void keyPressed()
{
  println("start animationa"+millis());
  animationValue = 0;
  phaseIn();
}
void phaseOut() {
  bAni = Ani.to(this, 1.0, "animationValue", 1.0, Ani.LINEAR, "");
  bAni.start();
}

void wait3()
{
  bAni = Ani.to(this, 2.0, "animationValue", 0.5, Ani.LINEAR, "onEnd:phaseOut");
  bAni.start();
}
void phaseIn()
{
  if (bAni !=null)
  {
    //bAni.end();
    Ani.killAll();
  }
  bAni = Ani.to(this, 1.0, "animationValue", 0.5, Ani.LINEAR, "onEnd:wait3");
  bAni.start();
}
