# Snowflake generator

* Used to make random snowflakes using this openscad file from David Eccles
(Gringer) per: http://www.thingiverse.com/thing:39685
* Scad file used under CC-BY-SA

If you'd like to use this generator simply create a file which contains a json
array of objects as:

```javascript
[
    {
        "fname": "Andrew",
        "sname": "Fisher",
        "dob": "1975-01-01"
    },
    {
        "fname": "Santa",
        "sname": "Claus",
        "dob": "1865-12-25"
    }
]
```

Call this with:

```
node snowflakes.js input.json
```

This will generate a random seed for each of the names and then attempt to call
open scad to pass the random seed into the model for generation.

Files will be output to the `output` folder and will be in the form
`<fname>-<sname>-<dob>.dxf`.

The output will be 2D vector DXF files which can then be opened in Inkscape or
some other vector program (eg cambam for laser cutting).
