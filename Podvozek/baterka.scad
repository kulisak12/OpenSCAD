$fn = 25;

module outerShape() {
	hull() {
		translate([-12, 0]) circle(d=32);
		translate([12, 0]) circle(d=32);
	}
}

module innerShape() {
	hull() {
		translate([-12, 0]) circle(d=24);
		translate([12, 0]) circle(d=24);
	}
}

module screwHole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*6);
	cylinder(d = 3, h = 1.01*6);
}

module battery(includeHole) {
	linear_extrude(height=3) {
		difference() {
			outerShape();
			if (includeHole) square([15, 12], center=true);
		}
	}

	translate([0, 0, 3]) difference() {
		linear_extrude(height=15) {
			difference() {
				outerShape();
				innerShape();
				translate([10, 13]) rotate([0, 0, 50]) square(30, center=true);
				translate([-10, 13]) rotate([0, 0, -50]) square(30, center=true);
			}
		}
		translate([12, -11, 8]) rotate([90, 0, 0]) screwHole();
		translate([-12, -11, 8]) rotate([90, 0, 0]) screwHole();
	}
}

battery(true);
translate([0, 40, 0]) battery(false);
