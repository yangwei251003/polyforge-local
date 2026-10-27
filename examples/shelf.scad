// PolyForge template: shelf_bracket
// units: millimetres
// L-profile wall shelf: a vertical back plate (against the wall, with mounting
// holes) fused to a horizontal shelf plate, spanning the shelf width in X.
// Hole placement is expressed as fractions of shelf_width/back_height so it
// stays valid for any override of those dimensions.

/* [Primary dimensions] */
shelf_width = 200.0;   // X, length of the shelf
shelf_depth = 150.0;   // Y, how far the shelf sticks out from the wall
back_height = 60.0;   // Z, height of the vertical wall plate
thickness = 5;       // plate thickness

/* [Mounting holes, through the back plate] */
hole_diameter = 4.5;
hole_count = 2;
hole_margin_fraction = 0.1;   // end margin, as a fraction of shelf_width
hole_z_fraction = 0.5;             // hole row height, as a fraction of back_height
hole_margin = shelf_width * hole_margin_fraction;
hole_z = back_height * hole_z_fraction;

/* [Quality] */
$fn = $preview ? 32 : 96;
eps = 0.01;

assert(shelf_depth > thickness, "shelf_depth must exceed thickness");
assert(back_height > thickness, "back_height must exceed thickness");
assert(hole_count >= 1, "hole_count must be at least 1");
assert(hole_margin_fraction > 0 && hole_margin_fraction < 0.5, "hole_margin_fraction must be between 0 and 0.5");
assert(hole_z_fraction > 0 && hole_z_fraction < 1, "hole_z_fraction must be between 0 and 1");
assert(hole_diameter < thickness * 4, "hole_diameter looks implausibly large for this plate thickness");

module back_plate() {
    cube([shelf_width, thickness, back_height]);
}

module shelf_plate() {
    cube([shelf_width, shelf_depth, thickness]);
}

module mounting_holes() {
    step = (hole_count > 1) ? (shelf_width - 2 * hole_margin) / (hole_count - 1) : 0;
    for (i = [0 : hole_count - 1]) {
        x = hole_margin + i * step;
        translate([x, -eps, hole_z])
            rotate([-90, 0, 0])
                cylinder(h = thickness + 2 * eps, d = hole_diameter);
    }
}

difference() {
    union() {
        back_plate();
        shelf_plate();
    }
    mounting_holes();
}
