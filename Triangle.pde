class Triangle {
  PVector A, B, C;
  
  Triangle(PVector p1, PVector p2, PVector p3) {
    A = p1;
    B = p2;
    C = p3;
  }
  
  public void display() {
    vertex(A.x, A.y, A.z);
    vertex(B.x, B.y, B.z);
    vertex(C.x, C.y, C.z);
  }
  
  PVector getMiddle() {
    float mx = (A.x + B.x + C.x) / 3;
    float my = (A.y + B.y + C.y) / 3;
    PVector p = new PVector(mx, my);
    return p;
  }
  
}