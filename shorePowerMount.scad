
$fn=125;

mount_bolt_radius=32.6;
boltholeSize=4.5;
x=79.5;
y=118.5; //next time change to 119.25 and reprint all pieces
plate_1_thick=1.72;
socketRadius=25;
d_radius=6;
top_x=x+8;
top_y=y+10;
topPlateThick=6;

tensionBlock_x =15;
tensionBlock_y =10;
tensionBlock_thick =11;
tensionMountInset=2.5;
tensionMountOverhang=1.5;
rivnutSize=5.91;

//test rivnut
/*
difference(){
translate([-4,-4,0])cube([8,8,10]);
translate([0,0,-1])linear_extrude(17)circle(5.95/2);
}
*/

//Mounting Plate
difference(){
	translate([0,0,0])tension_plate();
	ac_mount_clearance();
}
//ac_mount_clearance();
difference(){

	translate([0,0,0])rotate([0,0,180])tension_plate();
	ac_mount_clearance();
}


//Back braces
difference(){
    union(){
        inset_mount();
        outset_mount();    
    }
    mount_throughHoles();
	 tension_through_holes(boltholeSize);
	 rotate([0,0,180])	 tension_through_holes(boltholeSize);
		
}


module ac_mount_clearance(){
b_clearance=5;
 //bolt holes 
    translate([0,-mount_bolt_radius,-15])linear_extrude(plate_1_thick+topPlateThick+tensionBlock_thick+16)circle(b_clearance);
    rotate([0,0,120])translate([0,-mount_bolt_radius,-12])linear_extrude(plate_1_thick-topPlateThick+26)circle(b_clearance);
    rotate([0,0,240])translate([0,-mount_bolt_radius,-12])linear_extrude(plate_1_thick-topPlateThick+26)circle(b_clearance);

}
module tension_plate(){

	difference(){
		translate([-x/2 -tensionMountOverhang*3,tensionBlock_y/2-y/2,-tensionBlock_thick])color([1,.5,0])cube([tensionBlock_x,y-tensionBlock_y,tensionBlock_thick]);
		tension_through_holes(rivnutSize);
	}
}

module tension_through_holes(holeSize){

//	translate([-x/2+boltholeSize/2,0,-1-tensionBlock_thick])linear_extrude(plate_1_thick+topPlateThick+tensionBlock_thick+2)circle(boltholeSize/2);

	translate([-x/2+boltholeSize/2+2,-y/4,-1-tensionBlock_thick])linear_extrude(plate_1_thick+topPlateThick+tensionBlock_thick+2)circle(holeSize/2);

	translate([-x/2+boltholeSize/2+2,y/4,-1-tensionBlock_thick])linear_extrude(plate_1_thick+topPlateThick+tensionBlock_thick+2)circle(holeSize/2);
}

module outset_mount(){
    translate([-top_x/2,-top_y/2,plate_1_thick - .01])linear_extrude(topPlateThick)roundedPlate (top_x,top_y,d_radius);
}

module inset_mount(){

    translate([-x/2,-y/2,0])linear_extrude(plate_1_thick)roundedPlate (x,y,d_radius);
}

module mount_throughHoles()
{
    translate([0,0,-1])linear_extrude(plate_1_thick+topPlateThick+2)circle(socketRadius);  
   
   //bolt holes 
    translate([0,-mount_bolt_radius,-1])linear_extrude(plate_1_thick+topPlateThick+2)circle(boltholeSize/2);
    rotate([0,0,120])translate([0,-mount_bolt_radius,-1])linear_extrude(plate_1_thick+topPlateThick+2)circle(boltholeSize/2);
    rotate([0,0,240])translate([0,-mount_bolt_radius,-1])linear_extrude(plate_1_thick+topPlateThick+2)circle(boltholeSize/2);
}


module roundedPlate(x,y,rad)
{
    hull(){
    translate([rad,rad,0])circle(rad);
    translate([x-rad,rad,0])circle(rad);
    translate([x-rad,y-rad,0])circle(rad);
    translate([rad,y-rad,0])circle(rad);
    }
}