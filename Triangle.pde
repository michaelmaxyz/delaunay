class Triangle {
  Point one;
  Point two;
  Point three;
  
  public Triangle(Point one, Point two, Point three) {
    this.one = one;
    this.two = two;
    this.three = three;
  }

  void drawTriangle() {
    line(one.x, one.y, two.x, two.y);
    line(one.x, one.y, three.x, three.y);
    line(two.x, two.y, three.x, three.y);
  }

  public boolean shareEdge(Triangle other) {
    int counter = 0;
    if (sharesVertex(other.one)) counter++;
    if (sharesVertex(other.two)) counter++;
    if (sharesVertex(other.three)) counter++;

    
    return counter > 1;
  }

  public boolean sharesAnyVertex(Triangle other) {
    return sharesVertex(other.one) || sharesVertex(other.two) || sharesVertex(other.three);
  }

  public boolean sharesVertex(Point other) {
    if (other.x == one.x && other.y == one.y) return true;
    if (other.x == two.x && other.y == two.y) return true;
    if (other.x == three.x && other.y == three.y) return true;
    return false;
  }

  Point circumcenter() {
    float ax = one.x;
    float ay = one.y;
    float bx = two.x;
    float by = two.y;
    float cx = three.x;
    float cy = three.y;
    float d = 2 * (one.x * (two.y - three.y) + two.x * (three.y - one.y) + three.x * (one.y - two.y));
    float ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) + (cx * cx + cy * cy) * (ay - by)) / d;
    float uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) + (cx * cx + cy * cy) * (bx - ax)) / d;

    return new Point(ux, uy);
  }

  void drawCircumcenter() {
    Point center = circumcenter();
    float radius = center.distance(two);
    circle(center.x, center.y, radius*2);
  }
  
  void voronoi() {
    Point center = circumcenter();

    circle(center.x, center.y, 2);
    fill(0);
  }
  
}
