# ruby-sketchup
Ruby plugins for sketchup.
To install copy into plugins folder, typically this is:
`C:\Users\XXXXXXX\AppData\Roaming\Google\Google SketchUp 8\SketchUp\Plugins`  
where XXXXXXX is replaced by your username

### fds_obs
FDS is a fire and smoke modelling analysis software. (https://pages.nist.gov/fds-smv/)
Takes sketchup components and outputs coordinates onto console in format for FDS file. Output looks like:
```
&OBST XB=x1,x2,y1,y2,z1,z2 / name
```

### ies_gem
IES is an analysis software for building physics and thermal calculations. (https://www.iesve.com/)
Takes sketchup groups and outputs coordinates of vertices and faces onto console in format for IES GEM file. Output looks like:
```
Nvertices Nfaces 0
x1    y1    z1
x2    y2    z2

Nvertices v1 v2 v3 
0
Nvertices v1 v2 v3 
0
```
