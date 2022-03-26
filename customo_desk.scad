room_width = 225;
room_lenght = 305;
room_height = 260;
door_lenght = 78;
door_height = 205;
door_diff = 67;   // from wall to door
wall_thickness = 1;
bed_width = 134;
bed_height = 60;

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
        color("brown")
        translate( [room_lenght-bed_width, wall_thickness/2, 0])
        cube([bed_width, room_width, bed_height]);
    }
        

    
    if (show_room) {
        room();
    }
    if (show_bed) {
        bed();
    }
}
    
desk(
    show_room=true,
    show_bed=true
);