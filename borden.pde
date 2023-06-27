import processing.core.PImage;

String[] filenames;
PImage[] images;

int maximages = 150;
int s_size = 1000;
int x = 0;

void setup() {
  size(1000,1000);
  background(127);
 
 
  File folder = dataFile("/run/media/reinold/SEAGATEHUB/Content/Verkeersborden/informatiebord");
  println(folder);

  File[] pics = folder.listFiles();
  println("# of files found at folder above:", pics.length, ENTER);
  printArray(pics);
  println();

  filenames = new String[pics.length];
  for (int i = 0; i < pics.length; filenames[i] = pics[i++].getPath()); 

  images = new PImage[maximages+1];
  for (int j=0; j<maximages; j++) {
     images[j] = loadImage(filenames[j]); 
  }
  x = 0;
}  

void draw(){  
    if (x==maximages){
        x = 0;
    }
    pushMatrix();
    translate(random(s_size), random(s_size));
    image(images[x],0,0,images[x].width/3, images[x].height/3);
    popMatrix();
    x = x+1;
}
