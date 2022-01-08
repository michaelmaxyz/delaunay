class Edge {
  public Point p1;  
  public Point p2;  

  public boolean IsEqual(Edge other) {
    if (other == null)
      return false;
    return (p1.isEqual(other.p1) && p2.isEqual(other.p2)) || (p1.isEqual(other.p2) && p2.isEqual(other.p1));
  }

  public Edge(Point a, Point b) {
    p1 = a;
    p2 = b;
  }
  
  void drawEdge() {
    line(p1.x, p1.y, p2.x, p2.y);  
  }
  
}
