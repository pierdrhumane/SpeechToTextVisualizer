
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float spring;
  float damping;
  PVector target;
  
  /** NOISE **/
  float lastNoiseEvent = 0;
  float noiseDelay = 100;
  
  Particle(float x, float y, float mass, float spring, float damping) {
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    this.mass = mass;
    this.spring = spring;
    this.damping = damping;
    target = new PVector(x,y);
    noiseDelay = random(200,400);
    lastNoiseEvent = random(400,500);
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
      addForce(random(-10,10));
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
  }
  
  void addForce(float newForce) {
    PVector toOrigin = new PVector(0,0).sub(position);
    PVector force = toOrigin.normalize().mult(newForce);
    acceleration.add(force.div(mass));
  }
  
  void display()
  {
    fill(0,255,224);
    ellipse(position.x, position.y, 2, 2);
  }
  
  void setTarget(PVector newTarget) {
    target = newTarget;
  }
}
