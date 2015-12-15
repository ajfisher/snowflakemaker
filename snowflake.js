var child_process = require("child_process");

var openscad = "OpenSCAD"; // path to the open scad file.
var snowflake = "snowflake.scad"; // input file
var output = "output/";

var snowflake_list = require("./list.json");

snowflake_list.forEach(function(item) {

    var name = item.fname + " " + item.sname;
    var rs = Math.abs(Date.parse(item.dob)) / 1000;
    var nameval = 0;
    for (var i = 0; i < item.fname.length; i++) {
        nameval += item.fname.charCodeAt(i);
    }
    for (var i=0; i< item.sname.length; i++) {
        nameval += item.sname.charCodeAt(i);
    }

    var radius = nameval / 10 / 2;


    console.log("Making flake for %s", name);
    console.log("RS: %d radius: %d", rs, radius);
    var command = openscad + " " + snowflake + " -D rs=" + rs;
    command += " -D 'pn=\"" + name + "\"' -D el=" + radius;
    command += " -o '" + output + name + ".dxf'";
    child_process.execSync(command);
});
