ArrayList<Circle> background_circles;
ArrayList<PVector> spots;
ArrayList<PImage> frames;

PImage img;
PImage img1;
int final_attempts = 0;
int round = 0;
Circle zeus = newCircle(color(255), true);

void setup(){
  size(1000, 650);
  spots = new ArrayList<PVector>();
  background_circles = new ArrayList<Circle>();
  }

 
void draw(){
  background(0);
  int count = 0;
  int total = 2;
  if(!zeus.growing){
    round++;
  }
  zeus.show();
  zeus.grow();
  zeus.growing = zeus.edges();
  if(round > 0){
  while(count < total){ 
    Circle new_circle = newCircle(color(255), false); // new Circle(x, y, c);
    if(new_circle != null){
      background_circles.add(new_circle);
      count ++;
    }
    
    final_attempts++;
    println(final_attempts);
    if(final_attempts == 1000){
      noLoop();
      println("FINISHED");
      break;
    }
  }

  for(Circle c : background_circles){
      c.show();
      c.grow();
      c.growing = c.edges();
      touchOtherCircles(c);
    }
  }
}

boolean touchOtherCircles(Circle circle){
  for(Circle c: background_circles){
    if(c != circle){
    float d = dist(c.x, c.y, circle.x, circle.y);
    if(d - 2 < circle.r + c.r){
        circle.growing = false;
        break;
      }
    }
  }
return true;
}


Circle newCircle(color c_, boolean init){
  //int r = int(random(0, spots.size()));
  //PVector spot = spots.get(r);
  if(init){
    return new Circle(500, 325, c_);
  }
  float x = random(width);
  float y = random(height);
  if( pow(y - 325, 2) + pow(x - 500, 2) < pow(325, 2)){
    for(Circle c: background_circles){
      float d = dist(c.x, c.y, x, y);
      if (d < c.r){
        return null;
      }
    }
  return new Circle(x, y, c_);
  }
  return null;
}

void save_image(){
  saveFrame();
}
