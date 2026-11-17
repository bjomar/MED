// PCB
pcb_x = 100;
pcb_y = 75;
pcb_mount_offset = 5;
pcb_thickness = 1.6;

// Enclosure
clearance = 1;  // Luft je Seite
wall      = 5;
screw_hole_d = 2.6;
floor     = 2;
inner_h   = 45;
spacer_height = 3;
spacer_radius = 5;
mountpin_height = 6;
mountpin_radius = screw_hole_d/2;
screw_pos_div = 1.66;
lid_thickness = 5;


// Maße
inner_x = pcb_x + 2 * clearance;  
inner_y = pcb_y + 2 * clearance;  
outer_x = inner_x + 2 * wall;     
outer_y = inner_y + 2 * wall;     

pcb_s_x = wall + clearance;
pcb_e_x = pcb_s_x + pcb_x;
pcb_s_y = wall + clearance;
pcb_e_y = pcb_s_y + pcb_y;

pcb_ms_x = pcb_s_x + pcb_mount_offset;
pcb_me_x = pcb_e_x - pcb_mount_offset;
pcb_ms_y = pcb_s_y + pcb_mount_offset;
pcb_me_y = pcb_e_y - pcb_mount_offset;

terminal_cutout_w = 17;
terminal_cutout_h = 15;


module spacer() { 
    $fn=128;
    translate([pcb_ms_x, pcb_ms_y,floor])
        cylinder(h=spacer_height, r=spacer_radius);
    translate([pcb_ms_x, pcb_me_y,floor])
        cylinder(h=spacer_height, r=spacer_radius);
    translate([pcb_me_x, pcb_ms_y,floor])
        cylinder(h=spacer_height, r=spacer_radius);
    translate([pcb_me_x, pcb_me_y,floor])
        cylinder(h=spacer_height, r=spacer_radius);
}

module mountPins(){
    $fn=128;
    translate([pcb_ms_x, pcb_ms_y,floor/2])
        cylinder(h=mountpin_height, r=mountpin_radius);
    translate([pcb_ms_x, pcb_me_y,floor/2])
        cylinder(h=mountpin_height, r=mountpin_radius);
    translate([pcb_me_x, pcb_ms_y,floor/2])
        cylinder(h=mountpin_height, r=mountpin_radius);
    translate([pcb_me_x, pcb_me_y,floor/2])
        cylinder(h=mountpin_height, r=mountpin_radius);   
}

module pcbMount() {
    
    difference(){
        spacer();
        mountPins();
    }
}

screw_positions = [
    [wall / screw_pos_div, wall / screw_pos_div],
    [outer_x - wall / screw_pos_div, wall / screw_pos_div],
    [wall / screw_pos_div, outer_y - wall / screw_pos_div],
    [outer_x - wall / screw_pos_div, outer_y - wall / screw_pos_div]
];

module cutout(){
    translate([0,0,pcb_thickness+spacer_height])
        cube([terminal_cutout_w,wall+0.2, terminal_cutout_h-pcb_thickness]);
    
    translate([0,0,pcb_thickness+spacer_height+terminal_cutout_h-5])
        rotate([15,0,0])
                cube([terminal_cutout_w, wall, 10]);
}

module wallcutouts() {
    
    translate([pcb_s_x+45,wall+0.1,floor])
        mirror([0,1,0])
            cutout();
    
    translate([wall+0.1,pcb_s_y+14,floor])
        rotate([0,0,90])
            cutout();
    
    translate([wall+0.1,pcb_s_y+14+terminal_cutout_w+11,floor])
        rotate([0,0,90])
            cutout();
    
    translate([pcb_s_x+14,outer_y-wall-0.1,floor])
        cutout();
    
    translate([pcb_s_x+14+17+8,outer_y-wall-0.1,floor])
        cutout();
    
    translate([pcb_s_x+14+17+8+17+8,outer_y-wall-0.1,floor])
        cutout();
}

module box() { 
    $fn=64;
    difference() {
        cube([outer_x, outer_y, inner_h + floor]);

        translate([wall, wall, floor])
            cube([inner_x, inner_y, inner_h + 0.1]);

        for (p = screw_positions)
            translate([p[0], p[1], floor + inner_h - 10])
                cylinder(d = screw_hole_d, h = 10.1);
        
        wallcutouts();
    }
}

module lid() {
    $fn=64;
    translate([0,100,0]){
        difference() {
            cube([outer_x, outer_y, lid_thickness]);

            for (p = screw_positions)
                translate([p[0], p[1], -0.1])
                    cylinder(d = screw_hole_d, h = 10);
        }
    }
}

//translate([0,-20,0])
//    mirror([0,1,0])
//    cutout(); 

%wallcutouts();

lid();
box();
pcbMount();
