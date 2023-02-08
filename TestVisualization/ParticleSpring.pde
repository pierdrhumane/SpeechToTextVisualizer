class ParticleSpring {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float damping;
  PVector target;

  ParticleSpring(float x, float y, float mass) {
    position = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    this.mass = mass;
    damping = 0.85;
    target= new PVector(x,y);
  }

  void update() {
    PVector force = PVector.sub(target, position);
    force.mult(0.05);
    acceleration = PVector.div(force, mass);
    velocity.add(acceleration);
    velocity.mult(damping);
    position.add(velocity);
  }

  void display() {
    ellipse(position.x, position.y, mass , mass );
  }

  void setTarget(PVector t) {
    target = t;
  }
}
void initParticlesSpring()
{
  float unit = width/particles.length;
  for (int i = 0; i < particles.length; i++) {
    //particles[i] = new ParticleSpring(random(width), random(height), random(1, 3));
    particles[i] = new ParticleSpring( (unit*i)-width/2 , height/2, 1);
  }
}
