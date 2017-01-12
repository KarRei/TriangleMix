class Particle {
  //final static float RAD = 4;
  final static float BOUNCE = -1;
  final static float SPEED_MAX = 2.2;
  final static float DIST_MAX = 85;
  final static int DIST = 250;
  PVector speed = new PVector(random(-SPEED_MAX, SPEED_MAX), random(-SPEED_MAX, SPEED_MAX), random(-SPEED_MAX, SPEED_MAX));
  PVector acc = new PVector(0,0,0);
  PVector pos;
  //neighboors contains particles within DIST_MAX distance, as well as itself
  ArrayList<Particle> neighboors;
  
  Particle() {
    pos = new PVector(random(-DIST, DIST), random(-DIST, DIST), random(-DIST, DIST));
  }
  
  public void move() {
    pos.add(speed);
    
    acc.mult(0);
    
    if(pos.x < -DIST) {
      pos.x = -DIST;
      speed.x *= BOUNCE;
    }
    else if(pos.x > DIST){
      pos.x = DIST;
      speed.x *= BOUNCE;
    }
    
    if(pos.y < -DIST) {
      pos.y = -DIST;
      speed.y *= BOUNCE;
    }
    else if(pos.y > DIST){
      pos.y = DIST;
      speed.y *= BOUNCE;
    }
    
    if(pos.z < -DIST) {
      pos.z = -DIST;
      speed.z *= BOUNCE;
    }
    else if(pos.z > DIST){
      pos.z = DIST;
      speed.z *= BOUNCE;
    }
  }
  
  public void display() {
    //fill(255, 28);
    strokeWeight(2);
    point(pos.x, pos.y, pos.z);
    //ellipse(pos.x, pos.y, RAD, RAD);
    //translate(0, 0, -pos.z);
  }
  
}