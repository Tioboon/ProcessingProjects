//polygon that is drawed number of sides;
private int _numberOfSides;
//Size of UI font;
private int textS = 32;
//Variable that controls rotation;
private float rotVar;
//Variables that controls color;
private int R, G, B;
//Variables that controls variable colors to not be less than 0 and more than 255;
private boolean Rsobe, Gsobe, Bsobe;
//Variable that controls polygon ray;
private float varR;
//Variables that control rotation variation and ray variation;
private float rotVariation;
private float rayVariation;
//Variables that control the variation of each color components;
private int rVar, gVar, bVar;
//Variable that controls alpha percent;
private int alpha;
//Variable that controls alpha to be between 0 and 255;
private int AlpSobe;
//Variable that control variation of Alpha;
private int AlpVar;
//Variable that check if the image was saved in the end;
private boolean saved;

public float rotationVelocity = 250;
public float shrinkVelocity = 0.4f;
public int redChangeVelocity = 2;
public int greenChangeVelocity = 1;
public int blueChangeVelocity = 2;

void setup(){
  //Canvas size
  size(600, 600);
  //Define saved to true to not save when is initiated
  saved = true;
  //Initial sides of polygon.
  _numberOfSides = 3;
}

void draw(){
  //Check if color components are going to values that RGB doesn't suport.
  //Than if is it going, inverts the value of color variation by changing
  //the boolean that refers to the positive or negative setting of the variable.
  if(R >= 255){
    Rsobe = false; 
  }
  if(R <= 0){
    Rsobe = true; 
  }
  if(G >= 255){
    Gsobe = false; 
  }
  if(G <= 0){
    Gsobe = true; 
  }
  if(B >= 255){
    Bsobe = false; 
  }
  if(B <= 0){
    Bsobe = true; 
  }
  //Make the colors variable change depending on the booleans that are active.
  if(Rsobe){
   R += rVar; 
  } else R -= rVar;
  if(Gsobe){
   G += gVar; 
  } else G -= gVar;
  if(Bsobe){
   B += bVar; 
  } else B -= bVar;
  //Make the polygon shrinks
  if(varR > 0){
    varR -= rayVariation;
  } else {
    varR = 0;
    //check if the image was saved...
    if(!saved){
      //if not, save it;
      save("mandala" + _numberOfSides);
      saved=true;
    }
    //Set the initial poligon ray;
    varR = width/2 + width/4;
    //reset the image canvas;
    background(0);
    //Re-randomize initial colors;
    R = int(random(0, 255));
    G = int(random(0, 255));
    B = int(random(0, 255));
    //Make save boolean false since the save and reset of image was done;
    saved = false;
    //Add one side to the polygon;
    _numberOfSides += 1;
    }
  //remove the polygon stroke
  noStroke();
  //Defines color
  fill(R, G, B);
  //change the polygon position to the center;
  translate(width/2, height/2);
  //rotate the polygon in the actual rotation variable value;
  rotate(rotVar);
  //Draw the polygon
  regularPol(_numberOfSides, varR); 
  //Change the rotation to the next polygon
  rotVar += rotVariation;
  //set the rotation variation
  rotVariation = rotationVelocity;
  //set the ray variation
  rayVariation = shrinkVelocity;
  //set the color components variation;
  rVar = redChangeVelocity;
  gVar = greenChangeVelocity;
  bVar = blueChangeVelocity;
}

void mouseClicked(){
  //Support to the UI created to choose one option of Number of Sides
  //Left cells
  if(mouseX < width/4 && mouseY < height/4){
    _numberOfSides = 3;
  }
  else if(mouseX < width/4 && mouseY < height/4 * 2){
    if(mouseY > height/4){
      _numberOfSides = 4;
    }
  }
  else if(mouseX < width/4 && mouseY < height/4 * 3){
    if(mouseY > height/4 * 2){
      _numberOfSides = 5;
    }
  }
  else if(mouseX < width/4 && mouseY > height/3){
    _numberOfSides = 6;
  }
  //Right cells
  if(mouseX > width/4 * 3 && mouseY < height/4){
    _numberOfSides = 7;
  }
  else if(mouseX > width/4 * 3 && mouseY < height/4 * 2){
    if(mouseY > height/4){
      _numberOfSides = 8;
    }
  }
  else if(mouseX > width/4 * 3 && mouseY < height/4 * 3){
    if(mouseY > height/4 * 2){
      _numberOfSides = 9;
    }
  }
  else if(mouseX > width/4 * 3 && mouseY > height/3){
    _numberOfSides = 10;
  }
  //Upper cells
  else if(mouseY < height/4 && mouseX < width/4*2){
     if(mouseX > width/4){
       _numberOfSides = 11; 
     }
  }
  else if(mouseY < height/4 && mouseX < width/4*3){
     if(mouseX > width/4*2){
       _numberOfSides = 12; 
     }
  }
  //Bottom cells
  else if(mouseY > height/4*3 && mouseX < width/4*2){
     if(mouseX > width/4){
       _numberOfSides = 13; 
     }
  }
  else if(mouseY > height/4*3 && mouseX < width/4 * 3){
     if(mouseX > width/4*2){
       _numberOfSides = 14; 
     }
  }
}

//Make a polygon by the angle divided by the number of sides.
void regularPol(int lados, float r){
  float alpha = TWO_PI / lados;
  beginShape();
  for (float a = 0; a < TWO_PI; a += alpha){
   float px = cos(a) * r;
   float py = sin(a) * r;
   vertex(px, py);
  }
  endShape(CLOSE);
}
