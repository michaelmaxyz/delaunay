
Triangle superTriangle(ArrayList<Point> points) {
  float xMin = points.get(0).x;
  float yMin = points.get(0).y;
  float xMax = xMin;
  float yMax = yMin;

  for (Point p : points) {
    if (p.x < xMin) xMin = p.x;
    if (p.x > xMax) xMax = p.x;
    if (p.y < yMin) yMin = p.y;
    if (p.y > yMax) yMax = p.y;
  }

  float dx = xMax - xMin;
  float dy = yMax - yMin;
  float dMax = max(dx, dy);
  float xMid = (xMin + xMax) / 2f;
  float yMid = (yMin + yMax) / 2f;

  dMax *= 2;

  Point one = new Point(xMid - 2 * dMax, yMid - dMax);
  Point two = new Point(xMid, yMid + 2 * dMax);
  Point three = new Point(xMid + 2 * dMax, yMid - dMax);
  return new Triangle(one, two, three);
}

ArrayList<Triangle> triangulate(ArrayList<Point> points) {

  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  Triangle superTriangle = superTriangle(points);
  triangles.add(superTriangle);
  ArrayList<Edge> edges = new ArrayList<Edge>();

  for (Point current : points) {
    edges.clear();

    for (int j = triangles.size() - 1; j >= 0; j--) {
      Triangle tri = triangles.get(j);
      Point centerOfTri = tri.circumcenter();
      float radius = centerOfTri.distance(tri.one);

      if (inCircle(current, centerOfTri, radius)) {
        edges.add(new Edge(tri.one, tri.two));
        edges.add(new Edge(tri.two, tri.three));
        edges.add(new Edge(tri.three, tri.one));
        triangles.remove(j);
      }
    }

    for (int j = 0; j < edges.size() - 1; j++) {
      Edge currEdge = edges.get(j);
      if (currEdge != null) {
        for (int k = j + 1; k < edges.size(); k++) {
          Edge otherEdge = edges.get(k);
          if (currEdge.IsEqual(otherEdge)) {
            edges.set(j, null);
            edges.set(k, null);
          }
        }
      }
    }

    for (int j = 0; j < edges.size(); j++) {
      Edge currEdge = edges.get(j);
      if (currEdge != null)
        triangles.add(new Triangle(currEdge.p1, currEdge.p2, current));
    }
  }

  for (int i = triangles.size() - 1; i >= 0; i--) {
    if (triangles.get(i).sharesAnyVertex(superTriangle))
      triangles.remove(i);
  }

  return triangles;
}

boolean inCircle(Point point, Point center, float radius) {
  return point.distance(center) < radius;
}
