int cols, rows;

int w = 2000; //How many pixels wide we want to simulate
int h = 5000; //How many pixels forward we want to simulate

float[][] terrain; //store height values for terrain

float flying = 0; //stores our position over the terrain
float zoff = 0;
float inc = 0.1;
int scale = 10;

void setup(){
  fullScreen(P3D);
  cols = (int) (w/scale);
  rows = (int) (h/scale);
  terrain = new float[cols][rows];
}

void draw() {
  background(0);
  flying -= 0.1;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = noise(xoff,yoff,zoff) * 200 - 100;
      xoff += inc;
    }
    yoff += inc;
  }
  zoff += inc/10;


  noStroke();
  translate(width/2, height/2+50);
  rotateX(PI/3);
  
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      fill(map(terrain[x][y],-100,100,0,255)); //color based on height
      vertex(x*scale, y*scale, terrain[x][y]); //triangle vertex
      vertex(x*scale, (y+1)*scale, terrain[x][y+1]); //triangle vertex
    }
    endShape();
  }
}
