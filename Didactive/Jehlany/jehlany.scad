$fn = 50;
include<logo.scad>

a = 50; // strana krychle v mm
magnetDiameter = 16; // prumer magnetu
rawMagnetHeight = 5; // vyska magnetu
logoDepth = 0.5; // hloubka loga

magnetHeight = rawMagnetHeight + 1;

module magnetHole() {
	translate([a/3, a/3, sqrt(0.501) * a - magnetHeight])
		cylinder(d1 = magnetDiameter - 0.3, d2 = magnetDiameter + 0.1, h = magnetHeight);
}

module pyramid() {
	difference() {
		cube(a);
		translate([0, -1, a]) rotate([0, 45, 0]) cube(2*a);
		translate([-1, 0, a]) rotate([-45, 0, 0]) cube(2*a);
		rotate([0, 45, 0]) magnetHole();
		rotate([-45, 0, 0]) magnetHole();
	}
}

difference() {
	pyramid();
	translate([0.05*a, logoDepth, 0.05*a]) rotate([90, 0, 0])
	resize([a/2, 0, 1.01*logoDepth], auto=true) logoText();
}

//translate([-10, 0, 0]) rotate([0, 0, 90]) pyramid();
//translate([-10, -10, 0]) rotate([0, 0, 180]) pyramid();