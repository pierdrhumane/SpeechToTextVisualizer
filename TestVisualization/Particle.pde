

void initParticles()
{

  // Create the particles and place them in a grid
  //int particleSpacing =(int)(width / sqrt(numParticles));
  //int index= 0;
  //float unitX = width/numCols;
  //float unitY = height/numRows;
  //for (int x = 0; x< numCols; x++) {
  //  //int x = i * particleSpacing;
  //  for(int y=0;y<numRows;y++)
  //  {
  //    //int y = i * particleSpacing;
  //    particles[index] = new Particle(x*unitX+unitX/2, y*unitY+unitY/2);
  //    index ++;
  //  }
  //}
}

void updateParticles() {
  for (ParticleSpring p : particles) {
    //p.applyForce(p.attract(attractorPos));
    p.update();
    p.display();
  }
}

void mousePressed() {
  attractorPos = new PVector(mouseX, mouseY);
}

class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector originalPos;
  float maxSpeed = 4;

  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    originalPos = new PVector(x, y);
  }

  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  PVector attract(PVector target) {
    PVector force = PVector.sub(target, pos);
    float d = force.mag();
    d = constrain(d, 5, 100);
    force.normalize();
    float strength = (1 / d) * 5;
    force.mult(strength);
    return force;
  }

  void display() {
    strokeWeight(2);
    stroke(0,225,223, 100);
    //line(pos.x, pos.y, originalPos.x, originalPos.y);
    ellipse(pos.x, pos.y, 5, 5);
  }
}
