el = 46.1; // edge length at max radius
ft = 2; // flake thickness
cmt = el / 5; // crystal max thickness
xw = 2; // extrude width
nc = 18; // number of crystals
bw = 2; // backbone width

pn = "Test"; // person name

make_2d = true; // set to true for 2d output (e.g. DXF)

//rs = floor(rands(0,pow(10,6),1)[0]); // random number seed.
//rs = 1416261; // Uncomment to get a consistent snowflake
rs = 16120121;

echo("Random number seed: ", rs);
echo("Name: ", pn);
echo("Edge length: ", el);

cit = xw; // crystal min thickness
th = sqrt(3) * el/2; // triangle height

// random vector (x, y, length, direction, thickness)
rv = rands(0,1,nc*5, seed_value = rs);

// the idea on how to do this is loosely based on origami snowflakes as at:
// http://www.marthastewart.com/276331/how-to-make-paper-snowflakes
// combined with Wilson Bentley's observations of snowflakes
// http://en.wikipedia.org/wiki/Wilson_Bentley

module flake_part(){
	rotate([0,0,30]) translate([0,-el/2,0])
		square([bw,el], center = true);
	for(i = [0:nc-1]){
		assign(yr = sqrt(rv[i*4]),
		   xr = rv[i*4+1] * sqrt(rv[i*4]),
		   rt = (rv[i*4+2]<(1/3))?0:(rv[i*4+2]<(2/3))?60:120,
		   sl = rv[i*4+3],
		   ct = (rv[i*4+4])*(rv[i*4+4])){
			if(((rt != 120) || (yr + sl/2 < 1)) && (sl*el/2 > xw)){
				translate([xr*el/2, -yr*th,0]) rotate(rt)
					square([sl*el/2, cit + max(0,cmt*ct/2-cit)], 
					   center = true, $fa = 60);
			}
		}
	}
}

if(make_2d){
    translate([el, el]) {
        for(ri = [0:60:300]){
            rotate([0,0,ri]) flake_part();
            rotate([0,180,ri]) flake_part();
        }
        translate ([el, el]) {
            text(pn, size=1.5);
        }
    }
} else {
	linear_extrude(height=ft){
		for(ri = [0:60:300]){
			rotate([0,0,ri]) flake_part();
			rotate([0,180,ri]) flake_part();
		}
	}
}

echo("Done!");