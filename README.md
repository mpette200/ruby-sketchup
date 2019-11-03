# ruby-sketchup
Ruby plugins for sketchup.


### fds_obs
Takes sketchup components and outputs coordinates onto console in format for FDS file. Output looks like:
```
&OBST XB=x1,x2,y1,y2,z1,z2 / name
```

### ies_gem
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
