room_width = 225;
room_lenght = 305;
room_height = 260;
door_lenght = 78;
door_height = 205;
door_diff = 67;   // from wall to door
wall_thickness = 1;

module desk(
    show_room = true,
    show_bed = true,
    desk_type

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
        locker_death = 44;
        locker_width = 39;
        locker_height = 119;
        box_thickness = 3;
        box_width = 42 - (box_thickness * 2);
        box_togheter = 65;
        box = box_togheter - box_thickness;
        margin = 5;
        difference(){
            linear_extrude(75) {
            points = [[0,0], [70,0], [70,42], [45,42], [45,130], [0,130]];
            paths = [[0, 1, 2, 3, 4, 5, 6]];
            polygon(points = points, paths = paths, convexity = 10);
            }
            for (x = [-1:0])
		    translate ([-10, box_thickness,
            margin + x * box_togheter])
		    cube([
            100, 
            42 - 2*box_thickness,
            box]);
        }
        
        translate([-27-10, 75, 0])
        cube([27, 27, 80]);
        
        color("black")
        translate([-25, 65, 80])
        cube([5, 50, 35]);
    }

    module locker() {
        locker_death = 44;
        locker_width = 39;
        locker_height = 119;
        box_n = 5;
        box_thickness = 3;
        box_width = locker_width - (box_thickness * 2);
        box_togheter = 19;
        box = box_togheter - box_thickness;
        margin = 5;
        difference(){
        cube([locker_death, locker_width, locker_height]);
            for (x = [-1:box_n])
		    translate ([box_thickness/2, box_thickness,
            margin + x * box_togheter])
		    cube([
            locker_death+10, 
            locker_width - 2*box_thickness,
            box]);
        }
    }
    
    
    module office_desk() {
        thickness = 2;
        height = 70;
        deep = 70;
        width = 150;
        side_deep = 50;
        translate([0, 0, height - thickness])
        cube([deep, width, thickness]);
        
        translate([(deep-side_deep)/2, 0, 0])
        cube([side_deep, thickness, height - thickness]);
        translate([(deep-side_deep)/2, width - thickness, 0])
        cube([side_deep, thickness, height - thickness]);
        translate([0, width+5, 0])
        locker();
    }
        

    button();
    if (show_room) {
        room();
        button();
    }
    if (show_bed) {
        bed();
    }
    
    if (desk_type == "old"){
        translate([42, 15, 0])
        old_desc();
        
        translate([42, 15 + 130, 0])
        locker();
    }
    
        if (desk_type == "office"){
        translate([5, 5, 0])
        color("white")
        office_desk();

    }
}
    
desk(
    show_room=true,
    show_bed=true,
    desk_type="old"
);