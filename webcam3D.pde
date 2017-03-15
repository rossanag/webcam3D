/*
 Author: Rossana Guerra
 Date: March 2017
 Licence: MIT
 
 webcam3D is free software: you can redistribute it and/or modify
it under the terms of the MIT License as published by
the Free Software Foundation.
webcam3D is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
MIT License for more details.
*/

import processing.opengl.*;
import processing.video.*;
import com.jogamp.opengl.GL;
import com.jogamp.opengl.GL2ES2;
 
Capture video;

PJOGL pgl;
GL2ES2 gl;

boolean rotar = false;
 
void setup() {
    size(1024, 768, OPENGL);
     
    video = new Capture(this, width, height);
    
    video.start();  
    
}
 
void draw() {
     
    noFill();
    lights();
    
    strokeWeight(3);
    background(0);
    
    pgl = (PJOGL) beginPGL();  
      gl = pgl.gl.getGL2ES2();

    if (video.available()) {
      video.read();
      video.loadPixels();
      background(0);
       
     gl.glBlendColor(0.0,0.0,1,0.8);
    
      gl.glDisable(GL.GL_DEPTH_TEST);
      gl.glEnable(GL.GL_BLEND);      
      gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);
      
      pushMatrix();
      
      if (rotar){
        translate(width/2, height/2, 0);
        rotateZ(radians((mouseX-(width))));
        
        //rotateZ(radians(mouseX));
        rotateY(radians(-(mouseY-(height)))); //rotateY -(mouseY
        //rotateY(radians(mouseX/TWO_PI));
        translate(-width/2, -height/2, 0);
      }  

   
      for (int y = 0; y < video.height; y+=5) {  //antes 5
   
          beginShape(POINTS);
            for (int x = 0; x < video.width; x++) {
     
                    int pixelValue = video.pixels[x+(y*video.width)];
         
                    stroke(red(pixelValue*2), green(pixelValue*2), blue(pixelValue*3), 255); //255
         
                    vertex (x*2, y*2, -(brightness(pixelValue)*2));  //100                                          
            }
          endShape();   
      }
                  
      popMatrix();
      endPGL();
      saveFrame("img_###.png");
    }
}

void mouseClicked(){
  rotar = !rotar;
}


