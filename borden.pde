//
// loads traffic sign images and displays them randomly
// GPL (c) 2023 R.O.
//
import processing.core.PImage;

String[] filenames;
PImage[] images;

int maximages = 50;
int s_size = 1000;
int x = 0;
int scalefactor=7;

void setup() {
  size(1000,1000);
  background(127);

  //File folder = dataFile("/run/media/reinold/SEAGATEHUB/Content/Verkeersborden/informatiebord");
  File folder = dataFile("/home/reinold/Pictures/Cactussen");
  File[] pics = folder.listFiles();  
  filenames = new String[pics.length];
  
  for (int i = 0; i < pics.length; filenames[i] = pics[i++].getPath()); 
  
  if (maximages>pics.length) { 
    maximages=pics.length;
  }    
  images = new PImage[maximages+1];
  
  for (int j=0; j<maximages; j++) {
     println("loading :", filenames[j]);
     images[j] = loadImage(filenames[j]); 
  }
}  

void draw(){  
  if (x==maximages){
    x = 0;
  }
  pushMatrix();
  translate(random(s_size), random(s_size));
  image(images[x],0,0,images[x].width/scalefactor, images[x].height/scalefactor);
  popMatrix();
  x = x+1;
}
