room_width = 225;
room_lenght = 305;
room_height = 260;
door_lenght = 78;
door_height = 205;
door_diff = 67;   // from wall to door
wall_thickness = 1;

module desk(
    show_room = true,
    show_bed = true

){
    module room() {
        difference() {
            
        color("LightSkyBlue")
        translate( [0, 0, 0])
        cube([room_lenght+wall_thickness, room_width+wall_thickness, room_height]);
          
        //color("LightSkyBlue")  
        translate( [wall_thickness+1, wall_thickness/2, wall_thickness/2])
        cube([room_lenght, room_width, room_height+1]);
            
        //color("LightSkyBlue")
        translate( [door_diff, wall_thickness, wall_thickness])
        cube([door_lenght, room_lenght+wall_thickness, door_height]);
        
        }
    }
    
    module bed() {
        bed_width = 134;
        bed_height = 60;
        color("brown")
        translate( [room_lenght-bed_width, wall_thickness/2, 0])
        cube([bed_width, room_width, bed_height]);
    }
    
    module button() {
        button_size = 5;
        button_death = 2;
        z_position = 74;
        x_position = 48.5;
        color("white")
        translate([x_position, room_width, z_position])
        rotate([90, 0, 0])
        cube([button_size, button_size, button_death]);
    }
    
    module old_desc() {
        translate([42, 15, 0])
        linear_extrude(75) {
        points = [[0,0], [70,0], [70,42], [45,42], [45,130], [0,130]];
        paths = [[0, 1, 2, 3, 4, 5, 6]];
        polygon(points = points, paths = paths, convexity = 10);
        }
    }
        

    button();
    if (show_room) {
        room();
    }
    if (show_bed) {
        bed();
    }
    old_desc();
}
    
desk(
    show_room=true,
    show_bed=true
);