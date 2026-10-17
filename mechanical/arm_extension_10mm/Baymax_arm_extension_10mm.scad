// Units: mm. Round fit prototype, NOT a model of the SG90 spline teeth.
// The male projection of 3 mm is assumed to match the requested socket depth.
$fn=128;
body_length=10;
body_diameter=8;
male_diameter=4;
male_length=3;
female_diameter=4;
female_depth=3;
difference() {
    union() {
        cylinder(h=body_length,d=body_diameter);
        translate([0,0,body_length]) cylinder(h=male_length,d=male_diameter);
    }
    translate([0,0,-0.01]) cylinder(h=female_depth+0.01,d=female_diameter);
}
