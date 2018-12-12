ArrayList<Circle> background_circles;
ArrayList<PVector> spots;
ArrayList<PImage> frames;

PImage img;
PImage img1;


void setup(){
  size(1280, 850);
  frameRate(10);
	spots = new ArrayList<PVector>();
	img = loadImage("d6d92b4e4be65e9e07ec4ff14a5be101.jpg");
	img.loadPixels();
	img1 = loadImage("quiltomics.jpg");
	img1.loadPixels();

	for (int x = 0; x < img1.width; ++x) {
		for (int y = 0; y < img1.height; ++y) {
			int index = x + y * img1.width;
			color c = img1.pixels[index];
			float b = brightness(c);
			if (b < 1) {
				spots.add(new PVector(x, y));
			}
		}
	}
	background_circles = new ArrayList<Circle>();
	}

 
void draw(){
  background(0);
  int count = 0;
  int total = 10;
  int final_attempts  = 0;
  
  while(count < total){ 
    float x = random(img.width);
    float y = random(img.height);
    int index = int(x) + int(y) * img.width;
    color c = img.pixels[index];
    Circle new_circle = newCircle(c); // new Circle(x, y, c);
    if(new_circle != null){
      background_circles.add(new_circle);
      count ++;
    }
    
    final_attempts++;
  
    if(final_attempts == 500){
      noLoop();
      println("FINISHED");
      break;
    }
  }

  // frames = new ArrayList<PImage>();
  for(Circle c : background_circles){
      c.show();
      // thread("save_image");
      // frames.add(myMovie);
      c.grow();
      c.growing = c.edges();
      touchOtherCircles(c);
  }
  // int temp = 0;
  // for(PImage f: frames){
  //   saveFrame(String.format("img__%d", temp));
  //   temp++;
  // }
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


Circle newCircle(color c_){
  int r = int(random(0, spots.size()));
  PVector spot = spots.get(r);
  float x = spot.x;
  float y = spot.y;
  
  for(Circle c: background_circles){
    float d = dist(c.x, c.y, x, y);
    if (d < c.r){
      return null;
    }
  }

  return new Circle(x, y, c_);
}

void save_image(){
  saveFrame();
}
