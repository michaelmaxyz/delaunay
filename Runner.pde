ArrayList<Point> points;
final int n = 400;
final float factor = .1;
final int size = 900;
final int radius = 10;
double time = 0;
boolean voronoi = false;
// canvas setup
void setup() {
  points = new ArrayList<Point>();
  background(255);
  size(900, 900);
  initialize();
}

void draw() {
  background(255);
  for (Point p : points) {
    p.move(time);
    circle(p.x, p.y, 4);
  }
  time+= .08;
  
  ArrayList<Triangle> triangles = triangulate(points);
 
  
  if (!voronoi) {
    for (Triangle t: triangles)
      t.drawTriangle();  
  } else {
    for (int i = 0; i < triangles.size(); i++) {
      Triangle one = triangles.get(i);
      Point circumcenter = one.circumcenter();
      fill(0);
      for (int j = i + 1; j < triangles.size(); j++) {
        Triangle two = triangles.get(j);
        Point otherCircumcenter = two.circumcenter();
        if (one.shareEdge(two)) {
          line(circumcenter.x, circumcenter.y, otherCircumcenter.x, otherCircumcenter.y); 
        }
      
      }
    }
  }
}

void mouseClicked() {
  voronoi = !voronoi;  
}

void initialize() {
  float x;
  float y;

  for (int i = 0; i < sqrt(n); i++) {

    for (int j = 0; j < sqrt(n); j++) {

      x = random(size * factor, (1 - factor) * size);
      y = random(size * factor, (1 - factor) * size);

      points.add(new Point(x, y));
    }
  }
}
