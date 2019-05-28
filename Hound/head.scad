$fn = 40;

module shape() {
    minkowski() {
        translate([400, 0]) rotate([0, 0, -90])
        intersection() {
            translate([0, -30]) circle(50); // top
            translate([67, -50]) circle(100); // sides top
            translate([-67, -50]) circle(100);
            translate([92, 27]) circle(100); // sides middle
            translate([-92, 27]) circle(100);
            translate([0, 54]) circle(50); // bottom
        }
        circle(1, $fn=12);
    }
}

module headPart() {
    translate([0, 0, -10])
    difference() {
        intersection() {
            translate([0, 0, -400]) rotate([90, 0, 0]) rotate_extrude($fn=200) shape();
            cube(60, center=true);
        }
        translate([35, 0, 5]) rotate([0, 40, 0]) cube(30, center=true);
        translate([-30, 0, 0]) rotate([0, -50, 0]) cube(30, center=true);
    }
}

import("headPart.stl");
difference() {
    scale([1.1, 1.1, 1.1]) import("headPart.stl");;
    translate([10, 0, 15]) rotate([0, -50, 0]) cube(50, center=true);
    translate([-2, 0, 0]) rotate([0, -40, 0]) cube(20, center=true);
}
intersection() {
    scale([1.05, 1.1, 1.1]) import("headPart.stl");
    union() {
        translate([0, 10, 5]) rotate([90, 0, 0]) cylinder(h=20,d=15);
        translate([15, 0, 17]) cube(30, center=true);
        translate([-2, 0, 17]) rotate([0, -30, 0]) cube(20, center=true);
    }
}