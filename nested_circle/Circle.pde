class Circle{
  float x;
  float y;
  float r;
  color c;
  float center_x;
  float center_y;
  
  boolean growing = true;
  Circle(float x_, float y_, color c_){
    x = x_;
    y = y_;
    r = 1;
    c = c_;
  }
  
  
  void grow(){
    if(growing){
      r = r + 1;
    }
  }
 
 boolean edges(){

   if(x == 500 && y == 325){
     return !(x + r > width || x - r < 0|| y + r > height || y - r < 0);
   }
   return pow(x - 500 - r , 2) + pow(y - 325 - r, 2) - 2*pow(r, 2)< pow(325, 2);
 }
 
 
 void show(){
   stroke(c);
   strokeWeight(2);
   noFill();
   //fill(c);
   //noStroke();
   ellipse(x, y, r*2, r*2);
 }
}
