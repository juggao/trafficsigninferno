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

void setup() {
  size(1000,1000);
  background(127);

  //File folder = dataFile("/run/media/reinold/SEAGATEHUB/Content/Verkeersborden/informatiebord");
  File folder = dataFile("/home/reinold/Pictures");
  File[] pics = folder.listFiles();  
  filenames = new String[pics.length];
  
  for (int i = 0; i < pics.length; filenames[i] = pics[i++].getPath()); 
  
  if (maximages>pics.length) { 
    maximages=pics.length;
  }    
  images = new PImage[maximages+1];
  
  for (int j=0; j<maximages; j++) {
     images[j] = loadImage(filenames[j]); 
  }
}  

void draw(){  
  if (x==maximages){
    x = 0;
  }
  pushMatrix();
  translate(random(s_size), random(s_size));
  //image(images[x],0,0,images[x].width/3, images[x].height/3);
  image(images[x],0,0,images[x].width, images[x].height);
  popMatrix();
  x = x+1;
}
