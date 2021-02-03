
# string to reload
# load 'ies_gem/main.rb'
require 'sketchup.rb'

module MPETT
  module IESGEM
    def self.output(group, out)
      # Intro Start
      
      # COM GEM data file created by MP
      # LAYER
      # 1
      # COLOUR
      # 0
      # CATEGORY
      # 1
      # TYPE
      # 1
      # SUBTYPE
      # 2001
      # COLOURRGB
      # 16711680
      # IES *** name ***

      # intro clauses
      out.push("LAYER")
      out.push("1")
      out.push("COLOUR")
      out.push("0")
      out.push("CATEGORY")
      out.push("1")
      out.push("TYPE")
      out.push("1")
      out.push("SUBTYPE")
      out.push("2001")
      out.push("COLOURRGB")
      out.push("16711680")
      out.push("IES #{group.name}")
      
      # turn group into ies gemfile
      # Nvertices Nfaces 0
      #    x1    y1    z1
      #    x2    y2    z2
      ###
      # Nvertices v1 v2 v3 
      # 0
      # Nvertices v1 v2 v3 
      # 0
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

    def self.activate
      out = []
      out.push("COM GEM data file created by MP")
      model = Sketchup.active_model
      selection = model.selection
      selection.each { |g|
        if g.is_a? Sketchup::Group
          output(g, out)
        end
      }
      puts "#{out.join("\n")}"
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('IES gemfile') {
        self.activate
      }
      file_loaded(__FILE__)
    end

  end # module IESGEM
end # module MPETT
