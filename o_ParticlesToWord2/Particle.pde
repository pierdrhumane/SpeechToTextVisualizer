void initParticles()
{
   for(int i = 0;i<p.length;i++)
  {
    float angle = map(i,0,p.length,0,TWO_PI);
    Particle pTmp = new Particle(cos(angle)*width/6, sin(angle)*width/6, 1, 0.1, 0.1);
    p[i] = pTmp;
  }
  
}
class Particle {
  PVector position;
  PVector originalPosition;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spring;
  float damping;
  PVector target;
  float particleSize = 4;
  
  /** NOISE **/
  float lastNoiseEvent = 0;
  float noiseDelay = 100;
  
  float noiseAmount = 10.0;
  
  int targetSetTime;
   
  Particle(float x, float y, float mass, float spring, float damping) {
    position = new PVector(x, y);
    originalPosition = new PVector(x,y);
    velocity = new PVector();
    acceleration = new PVector();
    this.mass = mass;
    this.spring = spring;
    this.damping = damping;
    target = new PVector(x,y);
    noiseDelay = random(200,400);
    lastNoiseEvent = random(400,500);
    targetSetTime = -1;  // initialize targetSetTime to -1 to indicate no target has been set yet
  }
  
  void update() {
    if (target != null) {
      // move towards target with easing or spring animation
      PVector targetPosition = new PVector(target.x, target.y);
      PVector toTarget = targetPosition.sub(position);
      PVector force = toTarget.mult(spring);
      acceleration.add(force);
      velocity.mult(damping);
    }
    if(millis() - lastNoiseEvent > noiseDelay)
    {
      addForce(random(-noiseAmount,noiseAmount));
      lastNoiseEvent = millis();
    }
      //if (toTarget.mag() > 1) {
      //  PVector force = toTarget.mult(spring);
      //  acceleration.add(force);
      //  velocity.mult(damping);
      //} else {
      //  target = null;
      //  velocity.mult(0);
      //  acceleration.mult(0);
      //}
    //} else {
    //  // move towards original position
    //  PVector toOrigin = new PVector(width/2, height/2).sub(position);
    //  PVector force =  toOrigin.mult(spring);
    //  acceleration.add(force);
    //}
    
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    
    if (targetSetTime != -1 && millis() - targetSetTime >= 2000) {
        targetSetTime = -1;  // reset targetSetTime to indicate no target is currently set
        setTarget(new PVector(originalPosition.x,originalPosition.y));
      }
  }
  
  void addForce(float newForce) {
    PVector toOrigin = new PVector(0,0).sub(position);
    PVector force = toOrigin.normalize().mult(newForce);
    acceleration.add(force.div(mass));
  }
  
  void display()
  {
    fill(0,255,224);
    noStroke();
    ellipse(position.x, position.y, particleSize, particleSize);
  }
  
  void setTarget(PVector newTarget) {
    target = newTarget;
    targetSetTime = millis(); 
  }
  void setNoiseAmount(float newAmount)
  {
    noiseAmount = newAmount;
  }
}
