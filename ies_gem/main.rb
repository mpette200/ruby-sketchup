
# string to reload
# load 'ies_gem/main.rb'
require 'sketchup.rb'

# [0..-2] removes newline at end
LAYER_ROOM = <<HEREDOC[0..-2]
LAYER
1
COLOUR
0
CATEGORY
1
TYPE
1
SUBTYPE
2001
COLOURRGB
16711680
HEREDOC

# [0..-2] removes newline at end
LAYER_SHADE = <<HEREDOC[0..-2]
LAYER
64
COLOUR
0
CATEGORY
1
TYPE
4
SUBTYPE
0
COLOURRGB
65280
HEREDOC

module MPETT
  module IESGEM
    def self.output(group, out, layer_text)
      # turn group into ies gemfile
      # Nvertices Nfaces 0
      #    x1    y1    z1
      #    x2    y2    z2
      ###
      # Nvertices v1 v2 v3 
      # 0
      # Nvertices v1 v2 v3 
      # 0

      # layer definitions
      out.push(layer_text)
      out.push("IES #{group.name}")
      
      vertices = []
      faces = []
      vcheck = {} # hash table to lookup index of vertex
      i = 1 # index
      group.entities.each { |f|
        if f.is_a? Sketchup::Face
          vertexindices = []
          f.outer_loop.vertices.each { |v|
            if vcheck.has_key?(v)
              vertexindices.push(vcheck[v])
            else
              vcheck[v] = i
              vertexindices.push(i)
              vertices.push(v)
              i += 1
            end
          }
          faces.push(vertexindices)
        end # if
      }
      # output points to console
      out.push("#{vertices.length} #{faces.length} 0")
      vertices.each { |v|
        x = (group.transformation * v.position).x.to_m
        y = (group.transformation * v.position).y.to_m
        z = (group.transformation * v.position).z.to_m
        out.push("    %.6f     %.6f     %.6f" % [x,y,z])
      }
      faces.each { |f|
        faces_out = ["#{f.length} "]
        f.each { |point|
          faces_out.push("#{point} ")
        }
        out.push(faces_out.join(""))
        out.push("0")
      }
      return "done"
    end # output

    def self.process_rooms
      out = []
      out.push("COM GEM data file created by MP")
      model = Sketchup.active_model
      selection = model.selection
      selection.each { |g|
        if g.is_a? Sketchup::Group
          output(g, out, LAYER_ROOM)
          if !g.manifold?
            msg = "#{g.name} is not a closed solid. Try solid inspector"
            UI.messagebox(msg)
            raise TypeError, msg
          end
        end
      }
      puts "#{out.join("\n")}"
    end

    def self.process_shade
      out = []
      model = Sketchup.active_model
      selection = model.selection
      selection.each { |g|
        if g.is_a? Sketchup::Group
          output(g, out, LAYER_SHADE)
        end
      }
      puts "#{out.join("\n")}"
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('IES gemfile') {
        self.process_rooms
      }
      menu.add_item('IES gemfile_shade') {
        self.process_shade
      }
      file_loaded(__FILE__)
    end

  end # module IESGEM
end # module MPETT
