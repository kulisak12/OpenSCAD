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
	linear_extrude(height = 2) {
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

module hole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*thickness);
	cylinder(d = 3, h = 1.01*thickness);
}

module smallHole() {
	translate([0, 0, -0.01]) cylinder(d = 5, h = 1.01*thickness);
}

intersection() {
	union() {
		translate([0, 0, thickness]) rim();
		translate([50, -1, thickness]) cube([250, 2, 2]); // center stripe
	}
	translate([212, 0, -135]) rotate([0, -5, 0]) cube(300, center=true);
	translate([175, 0, -140]) rotate([0, 4, 0]) cube(300, center=true);
}

difference() {
	base();
	// front part
	translate([7, 0, 0]) hole();
	translate([14, 19, 0]) hole();
	translate([14, -19, 0]) hole();
	translate([40, 17, 0]) smallHole();
	translate([40, -17, 0]) smallHole();
	translate([47.5, 17, 0]) hole();
	translate([47.5, -17, 0]) hole();
	translate([61, 17, 0]) hole();
	translate([61, -17, 0]) hole();

	// middle part
	translate([97.5, 24, 0]) hole();
	translate([96.5, -24.5, 0]) hole();
	translate([105, 23, 0]) hole();
	translate([105.5, 31, 0]) smallHole();
	translate([153, 22, 0]) hole();
	translate([152.5, 30, 0]) smallHole();

	translate([259, -12.5, 0]) hole();
	translate([261.5, 10.5, 0]) hole();
	translate([262, 34, 0]) hole();
	translate([267.5, 41, 0]) hole();

	// back part
	translate([329, 11, 0]) hole();
	translate([329, -11, 0]) hole();
	translate([314.5, 16.5, 0]) smallHole();
	translate([314.5, -16.5, 0]) smallHole();
	translate([307.5, 16.5, 0]) hole();
	translate([307.5, -16.5, 0]) hole();
	translate([296.5, 16.5, 0]) hole();
	translate([296.5, -16.5, 0]) hole();
}

// fuel cell holders
translate([115, -80, thickness]) cube([2, 65, 10]);
translate([218.5, -80, thickness]) cube([2, 65, 10]);