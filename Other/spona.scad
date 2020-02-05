$fn = 20;
r = 2;
length = 10;
height = 40;
width = 6.2;
hook = 4;
hole = 2.5;

module block() {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([r, length - r, r]) sphere(r);
		translate([r, length - r, height - r]) sphere(r);
		translate([r, r, height - r]) sphere(r);

		translate([width + hook - r, r, r]) sphere(r);
		translate([width + hook - r, length - r, r]) sphere(r);
		translate([width - r, length - r, height - r]) sphere(r);
		translate([width - r, r, height - r]) sphere(r);
	}
}

module tooth(i) {
	size = hole * (20 + i)/50;
	rotate([0, 45, 0]) cube([size, length + 0.02, size], center=true);
}

module saw() {
	numPieces = 25;
	for (i = [0:numPieces]) {
		translate([0, length/2, 2 + i * (height-8)/numPieces]) tooth(i);
	}
	translate([0, length/2, 0]) rotate([90, 0, 0]) cylinder(r=1.5, h=length+0.02, center=true);
	translate([0, length/2, 34]) rotate([90, 0, 0]) hull() {
		cylinder(r=2, h=length+0.02, center=true);
		translate([0, 2, 0]) cylinder(r=2, h=length+0.02, center=true);
	}
}

module ridge() {
	hull() {
		translate([0, length+0.01, 15]) rotate([90, 0, 0]) cylinder(r=0.7, length + 0.02);
		translate([0, -0.01, -1]) cube([2*0.7, length+0.02, 1]);
	}
}

difference() {
	block();
	translate([3.2, 0, 0]) saw();
	translate([6.2, 0, 0]) ridge();
}