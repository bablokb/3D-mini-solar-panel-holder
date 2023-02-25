// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD) for a frame for two mini-solar-panels.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-mini-solar-panel-holder
//
// -----------------------------------------------------------------------------

include <BOSL2/std.scad>
include <dimensions.scad>

rim = 10;
x_panel  = 46.1 + 2*gap;
y_panel  = 60.2 + 2*gap;
z_panel  = 3;

x_frame  = 2*x_panel + 3*rim;
y_frame  = y_panel + 2*rim;
z_frame  = 6;
r_frame  = 3;

x_cable = 8;
z_cable = 2.4;

// --- conduits for cable   ----------------------------------------------------

module conduits() {
  translate([-x_frame/4,-y_frame/2+1.8*rim,z_panel])
     xrot(15) cuboid([x_cable,3*rim,z_cable],anchor=BOTTOM+CENTER);
  translate([+x_frame/4,-y_frame/2+1.8*rim,z_panel])
     xrot(15) cuboid([x_cable,3*rim,z_cable],anchor=BOTTOM+CENTER);
}

// --- the base plate with cutouts   -------------------------------------------

module plate() {
  difference() {
    cuboid([x_frame,y_frame,z_frame],
            rounding=r_frame, anchor=BOTTOM+CENTER,
            edges="Z");
    translate([-x_panel/2-rim/2,0,z_frame-z_panel])
       cuboid([x_panel,y_panel,z_panel+fuzz],
               anchor=BOTTOM+CENTER);
    translate([+x_panel/2+rim/2,0,z_frame-z_panel])
       cuboid([x_panel,y_panel,z_panel+fuzz],
               anchor=BOTTOM+CENTER);
    translate([-x_panel/2-rim/2,0,-fuzz])
       cuboid([x_panel-rim,y_panel-rim,z_panel+2*fuzz],
               anchor=BOTTOM+CENTER);
    translate([+x_panel/2+rim/2,0,-fuzz])
       cuboid([x_panel-rim,y_panel-rim,z_panel+2*fuzz],
               anchor=BOTTOM+CENTER);
  }
}


// --- final frame   -----------------------------------------------------------

difference() {
  plate();
  conduits();
}