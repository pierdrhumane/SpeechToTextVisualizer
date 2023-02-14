import geomerative.*;
class Particle {
  PVector originalPos;
  PVector pos;
  PVector displacement;
  boolean triggered;
  RPoint[] shape;
  
  Particle(float x, float y, float displacementMagnitude, RPoint[] shape) {
    originalPos = new PVector(x, y);
    pos = new PVector(x, y);
    displacement = PVector.fromAngle(random(TWO_PI)).mult(displacementMagnitude);
    this.shape = shape;
  }
  
  void update() {
    pos.add(displacement);
    if (triggered) {
      pos = PVector.lerp(pos,new PVector( shape[0].x,shape[0].y), 0.1);
      for (int i = 0; i < shape.length - 1; i++) {
        PVector tmp = PVector.lerp(new PVector( shape[i].x,shape[i].y), new PVector( shape[i+1].x,shape[i+1].y), 0.1);
        shape[i].x = tmp.x;
        shape[i].y = tmp.y;
      }
      PVector tmp1 = PVector.lerp(new PVector(shape[shape.length - 1].x,shape[shape.length - 1].y), originalPos, 0.1);
      shape[shape.length - 1].x = tmp1.x;
      shape[shape.length - 1].x = tmp1.y;
    }
  }
  
  void display() {
    ellipse(pos.x, pos.y, 5, 5);
  }
  
  void trigger() {
    triggered = true;
  }
}

Particle[] particles;

/** GEOMETRATIVE **/
RFont f;
RShape grp;
RPoint[] pointsText = new RPoint[0];

void setup() {
  size(500, 500);
  particles = new Particle[100];
  RG.init(this);
  grp = RG.getText("HELLO", "humane-vf.ttf", 150, CENTER);
  
  // SHAPE
  RG.setPolygonizer(RG.ADAPTATIVE);
  //grp.draw();

  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(6);// map(mouseY, 0, height, 3, 200));
  pointsText = grp.getPoints();
  
  RPoint[] shape = {
    new RPoint(width/2, height/2 - 100),
    new RPoint(width/2 + 100, height/2),
    new RPoint(width/2, height/2 + 100),
    new RPoint(width/2 - 100, height/2),
    new RPoint(width/2, height/2 - 100)
  };
  for (int i = 0; i < particles.length; i++) {
    float angle = map(i, 0, particles.length, 0, TWO_PI);
    float x = width/2 + cos(angle) * 200;
    float y = height/2 + sin(angle) * 200;
    particles[i] = new Particle(x, y, 2 ,shape);
  }
}

void draw() {
  background(255);
  
  for (Particle p : particles) {
    p.update();
    p.display();
  }
}

void mousePressed() {
  for (Particle p : particles) {
    p.trigger();
  }
}

//class RPoint {
//  PVector pos;
  
//  RPoint(float x, float y) {
//    pos = new PVector(x, y);
//  }
//}
