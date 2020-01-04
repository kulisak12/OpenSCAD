module unitTriangle() {
	linear_extrude(0.01)
	polygon([[0, 0], [u, 0], [0, u]]);
}

module unitParallelogram() {
	linear_extrude(0.01)
	polygon([[0, 0], [u, 0], [0, u], [-u, u]]);
}

module unitLine() {
	translate([u/2, 0, 0]) cube([u, 0.01, 0.01], center=true);
}

module magnify(thickness) {
	minkowski() {
		children();
		sphere(thickness);
	}
}

module transform(A, B, C) {
	// all y coords are switched
    dA = [0, 0, 0];
    dB = [B.x - A.x, - B.y + A.y, B.z - A.z];
    dC = [C.x - A.x, - C.y + A.y, C.z - A.z];
    m = [
        [dB.x, dC.x, 1, u*A.x],
        [dB.y, dC.y, 1, -u*A.y],
        [dB.z, dC.z, 1, u*A.z],
        [0, 0, 0, 1]
    ];
    
    multmatrix(m) children();
} 