$fn = 25;
include<logo.scad>

a = 15; // jednotková vzdálenost
includeMarks = true; // zářezy na hranolku
markSize = 0.5; // velikost zážezu

edgeHeight = 5; // výška okraje destičky
edgeWidth = 3; // tloušťka okraje destičky
boardHeigth = 2; // tloušťka destičky
extraSpace = 2; // rezerva

roundness = 1; // zaoblení
logoDepth = 0.5; // hloubka loga

boardSize = 10*a + extraSpace + 2*edgeWidth;

module roundedCuboid(size = [1, 1, 1], r = 1) {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([r, size[1] - r, r]) sphere(r);
		translate([r, r, size[2] - r]) sphere(r);
		translate([r, size[1] - r, size[2] - r]) sphere(r);

		translate([size[0] - r, r, r]) sphere(r);
		translate([size[0] - r, size[1] - r, r]) sphere(r);
		translate([size[0] - r, r, size[2] - r]) sphere(r);
		translate([size[0] - r, size[1] - r, size[2] - r]) sphere(r);
		}
}

module markedCuboid(size) {
	difference() {
		roundedCuboid([size*a, a, a], roundness);
		if (includeMarks && size > 1) {
			for (i = [1 : size - 1]) {
				translate([i * a, 0, 0]) cube([markSize, markSize, a]);
				translate([i * a, a - markSize, 0]) cube([markSize, markSize, a]);
			}
		}
	}
}

module edge() {
	roundedCuboid([boardSize, edgeWidth, boardHeigth + edgeHeight], roundness);
}

module board() {
	difference() {
		union() {
			roundedCuboid([boardSize, boardSize, boardHeigth], roundness);
			edge();
			translate([0, boardSize - edgeWidth, 0]) edge();
			translate([edgeWidth, 0, 0]) rotate([0, 0, 90]) edge();
			translate([boardSize, 0, 0]) rotate([0, 0, 90]) edge();
		}
		translate([35, 5, 0]) mirror([1, 0, 0])
		resize([30, 0, 1.01*logoDepth], auto=true) logo();
	}
}

board();
translate([0, -20, 0]) markedCuboid(1);
translate([20, -20, 0]) markedCuboid(3);