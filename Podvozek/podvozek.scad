$fn = 25;

round = 2;
thickness = 3;
vertexes = [
	[0 + round, 0],
	[7 + 0.6*round, 23.5 - 0.8*round],
	[65 + 0.6*round, 23.5 - 0.8*round],
	[95 - 0.6*round, 80 - 0.8*round],
	[249 - 0.6*round, 80 - 0.8*round],
	[281 - 0.6*round, 21 - 0.8*round],
	[322 - 0.6*round, 21 - 0.8*round],
	[331 - 0.8*round, 14 - 0.6*round],

	[331 - 0.8*round, -(14 - 0.6*round)],
	[322 - 0.6*round, -(21 - 0.8*round)],
	[281 - 0.6*round, -(21 - 0.8*round)],
	[249 - 0.6*round, -(80 - 0.8*round)],
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

module hole() {
	translate([0, 0, -0.01]) cylinder(d = 6, h = 0.4*thickness);
	cylinder(d = 3, h = 1.01*thickness);
}

module smallHole() {
	translate([0, 0, -0.01]) cylinder(d = 5, h = 0.4*thickness);
	cylinder(d = 3, h = 1.01*thickness);
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
	translate([60, 17, 0]) hole();
	translate([60, -17, 0]) hole();

	// middle part
	translate([95, 24, 0]) hole();
	translate([95, -24, 0]) hole();
	translate([104, 23, 0]) hole();
	translate([103.5, 31, 0]) smallHole();
	translate([152, 22, 0]) hole();
	translate([152.5, 30, 0]) smallHole();

	translate([257, -12.5, 0]) hole();
	translate([259, 9.5, 0]) hole();
	translate([259, 32.5, 0]) hole();
	translate([264, 40, 0]) hole();

	// back part
	translate([327, 11, 0]) hole();
	translate([327, -11, 0]) hole();
	translate([312.5, 16.5, 0]) smallHole();
	translate([312.5, -16.5, 0]) smallHole();
	translate([305.5, 16.5, 0]) hole();
	translate([305.5, -16.5, 0]) hole();
	translate([294.5, 16.5, 0]) hole();
	translate([294.5, -16.5, 0]) hole();

	translate([-10, -100, -1]) cube([250, 200, 5]);
}