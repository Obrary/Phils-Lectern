// DIY Table Top Lecturn Plans
//Laser Cut or CNC
//Author: Mark D. Rasmussen
//contact info: myfourkids at gmail.com 
//Version 1.1
//December 20, 2015
// Units in English.
// Released under Creative Commons License Attribution-ShareAlike
//CC BY-SA

wood_thickness = .25; //Wood thickness Maximum is probably .25 without much modification, all wood is same thickness
width = 16; //Width of Lecturn
depth = 12; //Depth of Lectern
front_height = 13; //front_height of Lectern < Back Height
back_height = 15; //back_height of Lectern

book_holder = 1 + wood_thickness;  //
book_holder_width = .6*width;
overhang = 1;

base_width = width - 2 * overhang;
base_depth = depth - 2 * overhang;
height_diff = back_height - front_height;
ratio = (back_height-front_height)/(depth+wood_thickness);
angle =asin(ratio);

front_intersection = front_height + overhang * ratio;
back_intersection = back_height - overhang * ratio;

tabletop_depth = sqrt(depth*depth+height_diff*height_diff);

x_scaled_cutout = (width - overhang*4-wood_thickness*2)/width; //Front and Back
y_scaled_cutout = (front_height - overhang*3)/front_height;//All Sides
sides_scaled_cutout = (depth - overhang*4-wood_thickness*2)/depth;//x for Sides


// Uncomment item you'd like to see, Render to see clean design
//sides();  
//top();
//back();
//front();
//assembly(); 

// for DXF files. Comment all above and uncomment below. Choose Render and then export DXF Files.
projection ( cut = true) construction();

module construction(){
    translate ([depth * 2.2,0,0])  top();
    translate ([0, back_height*1.1,0])  front();
    translate ([width *1.1, back_height*1.1,0]) back();
    translate ([0,0,0]) sides();
    translate ([depth *1.1,0,0]) sides();
}
module assembly(){
    translate ([0,0,front_height- ratio * overhang]) rotate ([asin(ratio),0,0]) top();
    translate ([0,overhang+wood_thickness,0]) rotate ([90,0,0]) front();
    translate ([0,depth-overhang,0]) rotate ([90,0,0]) back();
    translate ([width - overhang - wood_thickness,0,0]) rotate ([90,0,90]) sides();
    translate ([overhang,0,0]) rotate ([90,0,90]) sides();
}

module side_shape(){
  difference() {
        cube ([depth,back_height,wood_thickness]);
        translate ([0,front_height,0]) rotate ([0,0,asin(ratio)]) cube ([depth*2,back_height,wood_thickness]); 
}
}
module sides(){
    difference() {
        side_shape();
//slots
    rotate ([0,0,90])  translate ([front_intersection/2,-wood_thickness-overhang,0])cube ([front_intersection/2 +wood_thickness,wood_thickness,wood_thickness]);
    rotate ([0,0,90])  translate ([back_intersection/2,-depth+overhang,0])cube ([back_intersection/2 +wood_thickness,wood_thickness,wood_thickness]);
    //cutout   
    translate([(1-sides_scaled_cutout)/2*depth,overhang,0]) scale ([sides_scaled_cutout,y_scaled_cutout,1])        cube ([depth,front_height,wood_thickness]);;
        }
}

module front(){
    difference(){
    union() {
        cube ([width ,front_height + overhang * ratio,wood_thickness]);
        color("red") translate ([(width - book_holder_width)/2 ,front_height,0]) cube ([book_holder_width, book_holder,wood_thickness]);
        }
//slots
       translate ([overhang+wood_thickness,-wood_thickness,0])rotate ([0,0,90]) cube ([front_intersection/2 +wood_thickness,wood_thickness,wood_thickness]);
               translate ([width-overhang,-wood_thickness,0])rotate ([0,0,90]) cube ([front_intersection/2 +wood_thickness,wood_thickness,wood_thickness]);
//cutout
    
    translate([(1-x_scaled_cutout)/2*width,overhang,0]) scale ([x_scaled_cutout,y_scaled_cutout,1]) cube ([width ,front_height + overhang * ratio,wood_thickness]);
}    
}

module back(){
    difference(){
        cube ([width, back_height - overhang * ratio,wood_thickness]);
    //slots
       translate ([overhang+wood_thickness,-wood_thickness,0])rotate ([0,0,90]) cube ([back_intersection/2+wood_thickness ,wood_thickness,wood_thickness]);
               translate ([width-overhang,-wood_thickness,0])rotate ([0,0,90]) cube ([back_intersection/2+wood_thickness ,wood_thickness,wood_thickness]);
 //cutout
    
    translate([(1-x_scaled_cutout)/2*width,overhang,0]) scale ([x_scaled_cutout,y_scaled_cutout,1]) cube ([width ,front_height + overhang * ratio,wood_thickness]);
        }
}

module top(){
    
    difference(){
        cube ([width, tabletop_depth ,wood_thickness]);
    //lip hole
      translate ([(width - book_holder_width)/2, overhang  * depth/tabletop_depth ,0]) cube ([book_holder_width, wood_thickness + 2 *ratio* wood_thickness,wood_thickness]);
        }
}

