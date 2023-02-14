
//class Particle {
//  PVector position;
//  PVector velocity;
//  PVector acceleration;
//  float mass;
//  float spring;
//  float damping;
//  RPoint target;
  
//  Particle(float x, float y, float mass, float spring, float damping) {
//    position = new PVector(x, y);
//    velocity = new PVector();
//    acceleration = new PVector();
//    this.mass = mass;
//    this.spring = spring;
//    this.damping = damping;
//    target = null;
//  }
  
//  void update() {
//    if (target != null) {
//      // move towards target with easing or spring animation
//      PVector targetPosition = new PVector(target.x, target.y);
//      PVector toTarget = targetPosition.sub(position);
//      if (toTarget.mag() > 1) {
//        PVector force = spring * toTarget;
//        acceleration.add(force);
//        velocity.mult(damping);
//      } else {
//        target = null;
//        velocity.mult(0);
//        acceleration.mult(0);
//      }
//    } else {
//      // move towards original position
//      PVector toOrigin = new PVector(width/2, height/2).sub(position);
//      PVector force = spring * toOrigin;
//      acceleration.add(force);
//    }
    
//    velocity.add(acceleration);
//    position.add(velocity);
//    acceleration.mult(0);
//  }
  
//  void addForce(float newForce) {
//    PVector toOrigin = new PVector(width/2, height/2).sub(position);
//    PVector force = toOrigin.normalize().mult(newForce);
//    acceleration.add(force.div(mass));
//  }
  
//  void setTarget(RPoint newTarget) {
//    target = newTarget;
//  }
//}
