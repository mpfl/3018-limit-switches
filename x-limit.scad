thickness = 3;
switch_hole_pitch = 20;
extrusion_width = 20;
switch_bolt_diameter = 3;
switch_nut_diameter = 5.5;
extrusion_bolt_diameter = 5;
extrusion_trench_width = 8;
extrusion_guide_height = 2;
mount_width = 55;
switch_plug_height = 7.5;
switch_plug_width = 10;
switch_rail_length = 15;

$fn = 60;

rotate([90,0,0])
    extrusion_plate();
translate([0,0,extrusion_width-thickness])
    switch_plate();
translate([mount_width - extrusion_width/2 - extrusion_trench_width/2,0,0])
extrusion_guide();

module extrusion_plate() {
    linear_extrude(thickness)
        difference() {
            square([mount_width, extrusion_width]);
            translate([mount_width - extrusion_width/2, extrusion_width/2])
                hull() {
                    circle(d = extrusion_bolt_diameter + 0.2);
                }
            translate([switch_nut_diameter,extrusion_width-switch_plug_height])
                square([switch_hole_pitch - switch_nut_diameter, switch_plug_width]);
        }
}

module extrusion_guide() {
    difference() {
    linear_extrude(extrusion_width)
        polygon(points = [ [0,0], [extrusion_guide_height, extrusion_guide_height], [extrusion_trench_width-extrusion_guide_height, extrusion_guide_height], [extrusion_trench_width, 0] ]);
    translate([extrusion_trench_width/2,extrusion_guide_height * 1.5, extrusion_width/2])
        rotate([90,0,0])
            linear_extrude(extrusion_guide_height * 2)
                circle(d = extrusion_bolt_diameter + 0.2);
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
            square([switch_nut_diameter, switch_rail_length]);
            translate([(switch_nut_diameter)/2, switch_rail_length/2])
                hull() {
                    translate([0,switch_rail_length/2 - switch_bolt_diameter])      
                        circle(d = switch_bolt_diameter + 0.2);
                    translate([0,-(switch_rail_length/2 - thickness - switch_bolt_diameter)])      
                        circle(d = switch_bolt_diameter + 0.2);
                }
        }
}    

