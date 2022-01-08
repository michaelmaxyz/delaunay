class Point {
  float x;
  float y;
  float vx;
  float vy;
  float centerX;
  float centerY;
  float radiusX;
  float radiusY;
  public Point (float x, float y) {
    this.x = x;
    this.y = y;
    centerX = x;
    centerY = y;
    radiusX = random(-100, 100);
    radiusY = random(-100, 100);

  }

  public boolean isEqual(Point other) {
    return x == other.x && y == other.y;
  }

  public float distance(Point other) {
    float xDiff = other.x - x;
    float yDiff = other.y - y;
    return sqrt(xDiff * xDiff + yDiff * yDiff);
  }

  public void move (double time) {
    double radian = (PI / 16) * time;
    x = (float) (centerX + radiusX * Math.cos(radian));
    y = (float) (centerY + radiusY * Math.sin(radian));
  }
}
