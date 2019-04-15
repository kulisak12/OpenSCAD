$fn = 25;

round = 3;
thickness = 3;
vertexes = [
	[0 + round, 0],
	[7 + 0.6*round, 23.5 - 0.8*round],
	[65 + 0.6*round, 23.5 - 0.8*round],
	[95 - 0.6*round, 80 - 0.8*round],
	[251 - 0.6*round, 80 - 0.8*round],
	[283 - 0.6*round, 21 - 0.8*round],
	[324 - 0.6*round, 21 - 0.8*round],
	[333 - 0.8*round, 14 - 0.6*round],

	[333 - 0.8*round, -(14 - 0.6*round)],
	[324 - 0.6*round, -(21 - 0.8*round)],
	[283 - 0.6*round, -(21 - 0.8*round)],
	[251 - 0.6*round, -(80 - 0.8*round)],
	[95 - 0.6*round, -(80 - 0.8*round)],
	[65 + 0.6*round, -(23.5 - 0.8*round)],
	[7 + 0.6*round, -(23.5 - 0.8*round)],
];

module base() {
	linear_extrude(height = 3) {
		minkowski() {
			polygon(points = vertexes);
			circle(r = round);
		}
	}
}

module rim() {
	linear_extrude(height = 4) {
		difference() {
			minkowski() {
				polygon(points = vertexes);
				circle(r = round);
			}
			minkowski() {
				polygon(points = vertexes);
				circle(r = round - 1);
			}
		}
	}
}

module screwHole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*thickness);
	cylinder(d = 3, h = 1.01*thickness);
}

module hole(dia) {
	translate([0, 0, -0.01]) cylinder(d = dia, h = 1.01*thickness);
}

module podvozek() {
	// rims
	intersection() {
		union() {
			translate([0, 0, thickness]) rim();
			translate([50, -1, thickness]) cube([250, 2, 4]); // center stripe
		}
		translate([197, 0, -130]) rotate([0, -8, 0]) cube(300, center=true);
		translate([176, 0, -135]) rotate([0, 7, 0]) cube(300, center=true);
	}

	difference() {
		base();
		// front part
		translate([7, 0, 0]) screwHole();
		translate([14, 19, 0]) screwHole();
		translate([14, -19, 0]) screwHole();
		translate([40, 17, 0]) hole(5);
		translate([40, -17, 0]) hole(5);
		translate([47.5, 17, 0]) screwHole();
		translate([47.5, -17, 0]) screwHole();
		translate([61, 17, 0]) screwHole();
		translate([61, -17, 0]) screwHole();

		// middle part
		translate([97.5, 24, 0]) screwHole();
		translate([96.5, -24.5, 0]) screwHole();
		translate([105, 23, 0]) screwHole();
		translate([105.5, 31, 0]) hole(5);
		translate([153, 22, 0]) screwHole();
		translate([152.5, 30, 0]) hole(5);

		translate([259, -12.5, 0]) screwHole();
		translate([261.5, 10.5, 0]) screwHole();
		translate([262, 34, 0]) screwHole();
		translate([267.5, 41, 0]) screwHole();

		// back part
		translate([329, 11, 0]) screwHole();
		translate([329, -11, 0]) screwHole();
		translate([314.5, 16.5, 0]) hole(5);
		translate([314.5, -16.5, 0]) hole(5);
		translate([307.5, 16.5, 0]) screwHole();
		translate([307.5, -16.5, 0]) screwHole();
		translate([296.5, 16.5, 0]) screwHole();
		translate([296.5, -16.5, 0]) screwHole();

		// for holder
		translate([137.5, 71, 0]) screwHole();
		translate([149.5, 71, 0]) screwHole();
		translate([227.5, 71, 0]) screwHole();
		translate([239.5, 71, 0]) screwHole();
		translate([237.5, -68, 0]) screwHole();
		translate([249.5, -68, 0]) screwHole();
	}

	// fuel cell holders
	translate([112, -80, thickness]) difference() {
		cube([2, 68, 8]);
		translate([0, 6, 3]) rotate([0, 90, 0]) hole(2);
		translate([0, 58, 3]) rotate([0, 90, 0]) hole(2);
	}
	translate([218, -80, thickness]) difference() {
		cube([2, 68, 8]);
		translate([0, 6, 3]) rotate([0, 90, 0]) hole(2);
		translate([0, 58, 3]) rotate([0, 90, 0]) hole(2);
	}
}

module leg() {
	difference() {
		translate([0, 0, 1.5]) cube([18, 6, 3], center=true);
		translate([-6, 0, 0]) hole(2);
		translate([6, 0, 0]) hole(2);
	}
	translate([-3, -3, 0]) cube([6, 6, 38]);
}

module holder() {
	holderThickness = 3;
	holderPoints = [
		[-1, -2], // screw 3
		[10, -18],
		[90, -18], // screw 2
		[140, -30],
		[140, -95],
		[173, -95],
		[173, -18], // screw 1a
		[173, 50],
		[35, 50],
		[25, 10],
		[-1, 4],
	];

	difference() {
		linear_extrude(height = holderThickness) {
			polygon(points = holderPoints);
		}
		translate([4, 0]) hole(6); // 3
		translate([90, -14]) hole(2); // 2
		translate([170.5, -10]) hole(2); // 1a
		translate([168.5, -35]) hole(2); // 1b
		translate([45, -5, -0.01]) cube([20, 40, 5]);
		translate([75, -5, -0.01]) cube([20, 40, 5]);
		translate([105, -5, -0.01]) cube([20, 40, 5]);
		translate([135, -5, -0.01]) cube([20, 40, 5]);
		translate([148, -85, -0.01]) cube([15, 50, 5]);
	}

	translate([50, 47, -37]) leg();
	translate([140, 47, -37]) leg();
	translate([150, -92, -37]) leg();
}

podvozek();
//translate([93.5, 24, 40]) holder();