$fn = 100;

module shape() {
    translate([-6, -10])
    difference() {
        intersection() {
            polygon([
                [0, 0],
                [0, 20],
                [11, 25],
                [15, 22],
                [8, 0]
            ]);
            translate([100, 10]) circle(100);
        }
        translate([106, -19]) circle(100);
    }
}

module joint() {
    difference() {
        cylinder(d1=2, d2=3, h=1);
        cylinder(d1=1.7, d2=1, h=1);
    }
}

difference() {
    linear_extrude(height=2, scale=0.9) shape();
    translate([1, 8, 1.7]) joint();
}