room_shape = [225, 305, 260];
door_lenght = 78;
door_height = 205;
door_diff = 67;   // from wall to door
wall_thickness = 1;

module room(
    show_room = true,
    show_bed = true,
    desk_style,
    
    base_size = 4.5,
    base_thickness = 0.2,
    leg_deep = 80,
    leg_heigth = 100,
    desk_base_deep = 60,
    desk_base_width = 120,
    tabletop = [150, 80, 5],
    between_legs = 20
){
    module room_wall() {
        color("LightSkyBlue")
        difference() {
            
        translate( [0, 0, 0])
        cube([room_shape.y+wall_thickness, room_shape.x+wall_thickness, room_shape.z]);
          
        translate( [wall_thickness+1, wall_thickness/2, wall_thickness/2])
        cube([room_shape.y, room_shape.x, room_shape.z+1]);
            
        translate( [door_diff, wall_thickness, wall_thickness])
        cube([door_lenght, room_shape.y+wall_thickness, door_height]);
        
        }
    }
    
    module bed() {
        bed_width = 134;
        bed_height = 60;
        color("brown")
        translate( [room_shape.y-bed_width, wall_thickness/2, 0.5])
        cube([bed_width, room_shape.x, bed_height]);
    }
    
    module button() {
        button_size = 5;
        button_death = 2;
        z_position = 74;
        x_position = 48.5;
        color("white")
        translate([x_position, room_shape.x, z_position])
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
        tabletop_leg_margin = 5;
        difference(){
            linear_extrude(75) {
            points = [[0,0], [70,0], [70,42], [45,42], [45,130], [0,130]];
            paths = [[0, 1, 2, 3, 4, 5, 6]];
            polygon(points = points, paths = paths, convexity = 10);
            }
            for (x = [-1:0])
		    translate ([-10, box_thickness, tabletop_leg_margin + x * box_togheter])
                cube([100, 42 - 2*box_thickness, box]);
            translate([2, 42, -0.5])
                cube([50, 85+box_thickness, 75-tabletop_leg_margin]);
            translate([-10, 42, -0.5])
                cube([80, 85+box_thickness, 26]);
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
        tabletop_leg_margin = 5;
        difference(){
        cube([locker_death, locker_width, locker_height]);
            for (x = [-1:box_n])
		    translate ([box_thickness/2, box_thickness,
            tabletop_leg_margin + x * box_togheter])
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
    
    
    module new_desk(

    ) {
        module base(
        length
        ) {
            difference(){
            cube([base_size, base_size, length]);
            translate([base_thickness/2, base_thickness/2, -1])
            cube(
                [
                    base_size-base_thickness, 
                    base_size-base_thickness, 
                    length +2
                ]);
            }
        }    

        module frame(){
            leg_margin = (leg_deep - between_legs - 2 * base_size) / 2;
            for ( i = [0:1])
            translate([0, i*desk_base_width, 0])
            mirror( [0, i, 0] )
            color("black")
            union(){
            rotate([0, 90, 0])        
            base(length=leg_deep);
                
            for (x = [0:1])
                rotate([0, 0, -90])
                translate(
                    [-base_size, 
                    leg_margin + x *(between_legs + base_size),
                    0])
                union(){
                base(length=leg_heigth);
                translate([0, 0, leg_heigth])
                rotate([0, -90, 0])
                base(length=desk_base_width/2);
                }
            
            translate(
                [
                    (leg_deep-desk_base_deep)/2, 
                    0, 
                    leg_heigth+base_size
                ])
            rotate([0, 90, 0])
            base(length=desk_base_deep);
            }
        }
        color("white")
        translate([0, 0, leg_heigth + 2*base_size])
        cube([tabletop.x, tabletop.y, tabletop.z]);
        translate([
            (tabletop.x - leg_deep) /2,
            (tabletop.y - desk_base_width) / 2, 
            base_size])
        frame();
        
    }
        

    if (show_room) {
        room_wall();
        button();
    }
    if (show_bed) {
        bed();
    }
    
    if (desk_style == "current"){
        translate([42, 15, 0])
        old_desc();
        
        translate([42, 15 + 130, 0])
        locker();
    }
    
    if (desk_style == "office"){
        translate([5, 5, 0])
        color("white")
        office_desk();
    }
    
    if (desk_style == "new"){
        translate([5, 5, 0.5])
        new_desk();
    }
}
    
room(
    show_room=true,             // true or false. Около двери выключатель
    show_bed=true,              // true or false
    desk_style="new",            // new, current, office
// Настройки работают только для new
    base_size = 3,            // размер швеллера в см
    base_thickness = 2,       // толщина швеллера в см
    tabletop = [100, 200, 5],   // столешница [глубина, ширина, толщина]
    leg_deep = 80,              // глубина ножек в основании (около пола) в см
    between_legs = 20,          // расстояние между ножками
    leg_heigth = 100,           // высота ножек (без учета швеллера) в см
    desk_base_deep = 60,        // глубина основания под столешницу в см
    desk_base_width = 150       // ширина всей рамы под столешницей
);
