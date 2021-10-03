thickness = 3;
switch_hole_pitch = 20;
extrusion_width = 20;
switch_bolt_diameter = 3;
switch_nut_diameter = 5.5;
extrusion_bolt_diameter = 5;
mount_height = 33;
mount_width = switch_hole_pitch + switch_nut_diameter;
rod_bracket_height = 9;
rod_bracket_width = 12;
extrusion_trench_width = 8;
extrusion_guide_height = 2;

$fn = 60;

translate([mount_width,0,0])
    extrusion_plate();
translate([0,0,mount_height-thickness])
    switch_plate();
translate([-thickness, 0, rod_bracket_height])
    left_plate();
translate([mount_width, 0, 0])
    right_plate();
translate([0,0,rod_bracket_height])
back_plate();
translate([mount_width * 2, (extrusion_width - extrusion_trench_width)/2,0])
    rotate([-90,0,90])
        extrusion_guide();

module extrusion_plate() {
    linear_extrude(thickness)
        difference() {
            square([mount_width, extrusion_width]);
            translate([(switch_hole_pitch + switch_nut_diameter)/2, extrusion_width/2])
            hull() {
 
                circle(d = extrusion_bolt_diameter + 0.2);
            }
        }
}

module switch_plate() {
    switch_rail();
    translate([switch_hole_pitch, 0, 0])
        switch_rail();
}    

module switch_rail() {
    linear_extrude(thickness)
        difference() {
            square([switch_nut_diameter, extrusion_width]);
            translate([(switch_nut_diameter)/2, extrusion_width/2])
                hull() {
                    translate([0,extrusion_width/2 - switch_bolt_diameter])      
                        circle(d = switch_bolt_diameter + 0.2);
                    translate([0,-(extrusion_width/2 - thickness - switch_bolt_diameter)])      
                        circle(d = switch_bolt_diameter + 0.2);
                }
        }
}    

module left_plate() {
    cube([thickness, extrusion_width, mount_height - rod_bracket_height]);
}

module right_plate() {
    cube([thickness, extrusion_width, mount_height]);
}

module back_plate() {
    difference() {
        cube([mount_width, thickness, mount_height - rod_bracket_height -thickness]);
        translate([thickness, -thickness/2, thickness])
            cube([mount_width - thickness * 2, thickness * 2, mount_height - rod_bracket_height - thickness * 3]);
    }
}

module extrusion_guide() {
    difference() {
    linear_extrude(mount_width)
        polygon(points = [ [0,0], [extrusion_guide_height, extrusion_guide_height], [extrusion_trench_width-extrusion_guide_height, extrusion_guide_height], [extrusion_trench_width, 0] ]);
    translate([extrusion_trench_width/2,extrusion_guide_height * 1.5, mount_width/2])
        rotate([90,0,0])
            linear_extrude(extrusion_guide_height * 2)
                circle(d = extrusion_bolt_diameter + 0.2);
    }
}