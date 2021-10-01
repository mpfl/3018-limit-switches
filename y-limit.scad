thickness = 3;
switch_hole_pitch = 20;
extrusion_width = 20;
switch_bolt_diameter = 3;
switch_nut_diameter = 5.5;
extrusion_bolt_diameter = 5;
mount_height = 35;
mount_width = switch_hole_pitch + switch_nut_diameter;

$fn = 60;

extrusion_plate();
translate([0,0,mount_height-thickness])
    switch_plate();
translate([-thickness, 0, 0])
    side_plate();
translate([mount_width, 0, 0])
    side_plate();

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
                    translate([0,-(extrusion_width/2 - switch_bolt_diameter)])      
                        circle(d = switch_bolt_diameter + 0.2);
                }
        }
}    

module side_plate() {
    cube([thickness, extrusion_width, mount_height]);
}
