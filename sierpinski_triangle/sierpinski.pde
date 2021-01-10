PShape shape;
int depth     = 1;
int MAX_DEPTH = 10;


void setup() {

  size(1800, 900);
}


void draw() {
  background(255, 255, 255);
  fill(0);                
  int X = 1800;
  int Y = 900;
  PVector left = new PVector(X/4, 8*Y/9);
  PVector right = new PVector(3*X/4, 8*Y/9);
  PVector center = new PVector(X/2, Y/9);
  //triangle(left.x, left.y, right.x, right.y, center.x, center.y);
  draw_triangle(left, right, center, depth, 0, color(0, 0, 0));
}

void mousePressed() {
  if(depth >= MAX_DEPTH) {
    depth = 1;
  } else {
    depth++;
  }  
}

void draw_triangle(PVector lowerLeft, PVector lowerRight, PVector topCenter, int maxDepth, int curDepth, color col){
  if(curDepth < maxDepth) {

    PVector middleLeft = new PVector(lowerLeft.x + (topCenter.x - lowerLeft.x) / 2, 
                                     lowerLeft.y + (topCenter.y - lowerLeft.y) / 2);
    PVector middleRight = new PVector(lowerRight.x + (topCenter.x - lowerRight.x) / 2, 
                                      lowerRight.y + (topCenter.y - lowerRight.y) / 2);
    PVector bottomCenter = new PVector(lowerLeft.x + (lowerRight.x - lowerLeft.x) / 2, lowerLeft.y);
    
    
    PVector middleLeft_c = new PVector(lowerLeft.x + (3 * (lowerRight.x - lowerLeft.x) / 8), topCenter.y  + (3 * (lowerRight.y - topCenter.y) / 4));
    PVector middleRight_c = new PVector(lowerLeft.x + (5 * (lowerRight.x - lowerLeft.x) / 8), topCenter.y  + (3 * (lowerRight.y - topCenter.y) / 4));
    PVector topCenter_c = new PVector(bottomCenter.x, middleLeft.y);
    
    PVector mid_left_left = new PVector(lowerLeft.x + (5 * (lowerRight.x - lowerLeft.x) / 16), topCenter.y  + (5 * (lowerRight.y - topCenter.y) / 8));
    PVector mid_left_right = new PVector(lowerLeft.x + (7 * (lowerRight.x - lowerLeft.x) / 16), topCenter.y  + (5 * (lowerRight.y - topCenter.y) / 8));
    PVector mid_left_center = new PVector(middleLeft_c.x, middleLeft.y);
    
    PVector mid_right_left = new PVector(lowerLeft.x + (9 * (lowerRight.x - lowerLeft.x) / 16), topCenter.y  + (5 * (lowerRight.y - topCenter.y) / 8));
    PVector mid_right_right = new PVector(lowerLeft.x + (11 * (lowerRight.x - lowerLeft.x) / 16), topCenter.y  + (5 * (lowerRight.y - topCenter.y) / 8));
    PVector mid_right_center = new PVector(middleRight_c.x, middleLeft.y);
    
    PVector mid_center_left = new PVector(mid_left_right.x, topCenter.y  + (7* (lowerRight.y - topCenter.y) / 8));
    PVector mid_center_right= new PVector(mid_right_left.x, topCenter.y  + (7* (lowerRight.y - topCenter.y) / 8));
    PVector mid_center_center = new PVector(topCenter_c.x, middleLeft_c.y);
    
    int newDepth = curDepth + 1;
    draw_triangle(middleLeft,   middleRight,  topCenter,   maxDepth, newDepth, col); 
    draw_triangle(lowerLeft,    bottomCenter, middleLeft,  maxDepth, newDepth, col); 
    draw_triangle(bottomCenter, lowerRight,   middleRight, maxDepth, newDepth, col); 
    draw_triangle(middleLeft_c, middleRight_c, topCenter_c, maxDepth, newDepth, color(255, 213, 0)); 
    draw_triangle(mid_left_left, mid_left_right, mid_left_center, maxDepth, newDepth, color(0, 111, 163));
    draw_triangle(mid_right_left, mid_right_right, mid_right_center, maxDepth, newDepth, color(0, 111, 163));
    draw_triangle(mid_center_left, mid_center_right, mid_center_center, maxDepth, newDepth, color(0, 111, 163));

  }else{
    stroke(col);
    shape = createShape();
    shape.beginShape(TRIANGLES);
    shape.fill(255, 255, 255);
    shape.vertex(lowerLeft.x, lowerLeft.y);
    shape.vertex(lowerRight.x, lowerRight.y);
    shape.vertex(topCenter.x, topCenter.y);
    shape.endShape();
    shape(shape);
  }
}
