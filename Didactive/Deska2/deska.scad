$fn = 25;
include<logo.scad>

a = 15; // jednotková vzdálenost
numCubes = 10; // počet jednotek

edgeWidth = 3; // prostor kolem hranolku, respektive vzdálenost mezi nimi
boardHeight = 7; // plná tloušťka destičky
indentDepth = 5; // hloubka díry pro hranolek
extraSpace = 0.5; // rezerva

roundness = 1; // zaoblení
logoDepth = 0.5; // hloubka loga
logoSize = 20; // velikost loga

chunkWidth = a + 2*extraSpace + 2*edgeWidth;

module chunk(size) {
	chunkLength = size*a + 2*extraSpace + 2*edgeWidth;
	minkowski() {
		union() {
			difference() {
				cube([chunkWidth - 2*roundness, chunkLength - 2*roundness, boardHeight]);
				translate([edgeWidth - 2*roundness, edgeWidth - 2*roundness, boardHeight - indentDepth])
				cube([a + 2*extraSpace + 2*roundness, size*a + 2*extraSpace + 2*roundness, 1.01*indentDepth]);
			}
		}
		sphere(roundness);
	}
}

module board() {
	for (i = [0:numCubes-1]) {
		translate([i * (chunkWidth - edgeWidth), 0, 0]) chunk(i+1);
	}
}

difference() {
	board();
	translate([numCubes * (a + edgeWidth + 2*extraSpace) - logoSize - 2, logoDepth - roundness, (boardHeight - 0.15*logoSize) / 2])
	rotate([90, 0, 0]) resize([logoSize, 0, 1.01*logoDepth], auto=true) logoText();
}