//
// loads traffic sign images and displays them randomly
// GPL (c) 2023 R.O.
//
import processing.core.PImage;
import g4p_controls.*;

String imgdir="";

String[] filenames;
PImage[] images;

int maximages = 0;
int s_size = 1000;
int x = 0;
int scalefactor=0;
GTextField txf0, txf1;
GLabel label1, label2;
GButton btn;
boolean inputvars=true;
boolean loading=false;
boolean startdemo=false;

int currentimg=0;

void settings() {
    size(s_size,s_size);    
}

// Create numeric text field controls for integer and decimal numbers
void createNumericTextFieldControls() {
  
  label1 = new GLabel(this, 20, 40, 120, 38);
  label1.setText("Amount of images to load");
  label1.setTextAlign(GAlign.CENTER, GAlign.CENTER);
  label1.setOpaque(true);
  txf0 = new GTextField(this, 20, 80, 120, 20);
  txf0.setNumeric(1, 500, 0);

  label2 = new GLabel(this, 160, 40, 120, 38);
  label2.setText("Scale factor");
  label2.setTextAlign(GAlign.CENTER, GAlign.CENTER);
  label2.setOpaque(true);
  txf1 = new GTextField(this, 160, 80, 120, 20);
  txf1.setNumeric(1, 20, 0);
 
}

void handleTextEvents(GEditableTextControl source, GEvent event) { 
  if (inputvars == false)
    return;
  if (source == txf0) {
    println("maximages: " + txf0.getValueI());
    maximages = txf0.getValueI();
  } else if (source == txf1) {
    println("scalefactor: " + txf1.getValueI());
    scalefactor = txf1.getValueI();
  }
}


void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    imgdir = selection.getAbsolutePath();
  }
}

void handleButtonEvents(GButton button, GEvent event) {
  if (button == btn)
    startdemo = true;
}

void setup() {
  
  background(51);
  G4P.messagesEnabled(false);
  G4P.setDisplayFont("Arial", G4P.PLAIN, 14); 
  G4P.setInputFont("Arial", G4P.PLAIN, 14); 
  cursor(CROSS);
  createNumericTextFieldControls();
  btn = new GButton(this, 120, 120, 60, 60, "Start");
  
  selectFolder("Select a folder to process:", "folderSelected");

  while(imgdir.length()==0) {
     delay(50);
  }
}  

void loadFileNames() {
  File folder = dataFile(imgdir);
  File[] pics = folder.listFiles();  
  filenames = new String[pics.length];
  
  for (int i = 0; i < pics.length; filenames[i] = pics[i++].getPath()); 
  if (maximages>pics.length) { 
    maximages=pics.length;
  }    
  images = new PImage[maximages+1];
}

void loadImage(int n) {  
  println("loading :", filenames[n]);
  loading = true;
  images[n] = loadImage(filenames[n]);
}

  
void draw(){
  if (loading) {
    if (currentimg==maximages) {
      loading = false;
      background(51);
      return;
    }
    loadImage(currentimg);
    background(51);
    String msg="Loading: " + filenames[currentimg]; 
    text(msg,20,45);
    currentimg += 1;
    //delay(50);
    return; 
  }
  if (inputvars == true) {
    background(255, 255, 230);
    stroke(0xFF000088);
    strokeWeight(2);
    fill(0xFFAAAAFF);
    rect(4, 4, 300, 200, 6); 
    if (maximages>0 && scalefactor>0 && startdemo) {
       inputvars=false;
       loadFileNames();
       loading = true;
       txf0.setVisible(false);
       txf1.setVisible(false);
       label1.setVisible(false);
       label2.setVisible(false);
       btn.setVisible(false);
       background(51);
    }
  }
  else if (startdemo == true) { 
    if (x==maximages){
      x = 0;
    }
    pushMatrix();
    translate(random(s_size), random(s_size));
    image(images[x],0,0,images[x].width/scalefactor, images[x].height/scalefactor);
    popMatrix();
    x = x+1;
  }
}
