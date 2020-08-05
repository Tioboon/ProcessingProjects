//Canvas size
int w = 700;
int h = 700;
//Depth of the square made (by fractal "parts")
int depth = 1;
//space betwen the sides and the canvas.
int border = 50;
//color components
int r, g, b;
//color mannagers
boolean rdesce, gdesce, bdesce;

void settings(){
  //set canvas size
  size(w, h);
}

void setup(){
  //Cancel the auto-Loop
 noLoop();
}

void draw(){
  //Draw the square
  quadFract(0, depth, new PVector(border, border), new PVector(border, height - border), new PVector(width - border, height - border), new PVector(width - border, border));
}

void quadFract(int level, int maxLevel, PVector u, PVector i, PVector o, PVector p){
 //level is the actual depth of the drawing
  level++;
  
  //Make the function stop after making a new depth of the fractal
  if(level > maxLevel){
   return;
 }
 
 //set the color
 fill(r, g, b);
 //remove stroke
 noStroke();
 //draw a square with the points u, i, o and p
 quad(u.x, u.y, i.x, i.y, o.x, o.y, p.x, p.y);
 
 //vector size
 PVector VecX = PVector.sub(p, u);
 PVector VecY = PVector.sub(i, u);
 
 //Subdivide the square with four (with the sides) paralel lines in width and four in height
 //and two in height, than calculate the intersection points between that lines
 //unless the original 4 initial points (u, i, o and p)
 //each "p" is an poin of intersection;
 
 //Upper part of the Square
 PVector p1 = PVector.add(u , PVector.div(VecX, 3));
 PVector p2 = PVector.add(u, PVector.mult(PVector.div(VecX, 3), 2));

 //Left part of the Square
 PVector p3 = PVector.add(u, PVector.div(VecY, 3));
 PVector p7 = PVector.add(u, PVector.mult(PVector.div(VecY, 3), 2));
 
 //Rigth part of the Square
 PVector p6 = new PVector(PVector.add(u, VecX).x,
              PVector.add(u, PVector.div(VecY, 3)).y);
 PVector p10 = new PVector(PVector.add(u, VecX).x,
               PVector.add(u, PVector.mult(PVector.div(PVector.sub(i, u), 3), 2)).y);
               print("p: ", p10);
 //Bottom part of the Square
 PVector p11 = new PVector(PVector.add(u, PVector.div(PVector.sub(p, u), 3)).x,
               PVector.add(u, PVector.sub(i, u)).y);
 PVector p12 = new PVector(PVector.add(u, PVector.mult(PVector.div(PVector.sub(p, u), 3), 2)).x, 
               PVector.add(u, PVector.sub(i, u)).y);
               
 //Internal part of the Square
 PVector p4 = new PVector(PVector.add(u, PVector.div(VecX, 3)).x, PVector.add(u, PVector.div(PVector.sub(i, u), 3)).y);
 PVector p5 = new PVector(PVector.add(u, PVector.mult(PVector.div(PVector.sub(p, u), 3), 2)).x, PVector.add(u, PVector.div(PVector.sub(i, u), 3)).y);
 PVector p8 = new PVector(PVector.add(u, PVector.div(PVector.sub(p, u), 3)).x, PVector.add(u, PVector.mult(PVector.div(PVector.sub(i, u), 3), 2)).y);
 PVector p9 = new PVector(PVector.add(u, PVector.mult(PVector.div(PVector.sub(p, u), 3), 2)).x, PVector.add(u, PVector.mult(PVector.div(PVector.sub(i, u), 3),2)).y);
 
 
 //Draw the squares that are inside the actual square
 //Upper squares
 quadFract(level, maxLevel, u, p3, p4, p1);
 quadFract(level, maxLevel, p1, p4, p5, p2);
 quadFract(level, maxLevel, p2, p5, p6, p);
 //Center squares
 quadFract(level, maxLevel, p3, p7, p8, p4);
 quadFract(level, maxLevel, p5, p9, p10, p6);
 //Bottom Squares
 quadFract(level, maxLevel, p7, i, p11, p8);
 quadFract(level, maxLevel, p8, p11, p12, p9);
 quadFract(level, maxLevel, p9, p12, o, p10);
 
 
 //Check if the color is variating out of the color range (0, 255) and chages the boolean controlers value.
 if(r >= 255){
  rdesce = true;
 }
 if(g >= 250){
  gdesce = true;
 }
 if(b >= 250){
  bdesce = true;
 }
 if(r <= 0){
    rdesce = false; 
 }
 if(g <= 0){
    gdesce = false; 
 }
 if(b <= 0){
    bdesce = false; 
 }
 
 //Than changes the value corresponding with the boolean controlers
 if(!rdesce){
   r+=random(1, 6);
 }
 else r-=random(1, 4);
 if(!gdesce){
   g+=random(1, 5);
 }
 else g-=random(1, 5);
 if(!bdesce){
   b+=random(1, 7);
 }
 else b-=random(1, 3);
}

//Made the fractal more depth when mouse is cliked
void mouseClicked(){
 depth ++;
 redraw();
}
