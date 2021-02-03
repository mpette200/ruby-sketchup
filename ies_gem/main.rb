
# string to reload
# load 'ies_gem/main.rb'
require 'sketchup.rb'

module MPETT
  module IESGEM
    def self.output(group)
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
      puts "LAYER"
      puts "1"
      puts "COLOUR"
      puts "0"
      puts "CATEGORY"
      puts "1"
      puts "TYPE"
      puts "1"
      puts "SUBTYPE"
      puts "2001"
      puts "COLOURRGB"
      puts "16711680"
      puts "IES #{group.name}"
      
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
      puts "#{vertices.length} #{faces.length} 0"
      vertices.each { |v|
        x = (group.transformation * v.position).x.to_m
        y = (group.transformation * v.position).y.to_m
        z = (group.transformation * v.position).z.to_m
        puts "    %.6f     %.6f     %.6f" % [x,y,z]
      }
      faces.each { |f|
        print "#{f.length} "
        f.each { |point|
          print "#{point} "
        }
        print "\n"
        puts 0
      }
      return "done"
    end # output

    def self.activate
      puts "COM GEM data file created by MP"
      model = Sketchup.active_model
      selection = model.selection
      selection.each { |g|
        if g.is_a? Sketchup::Group
          output(g)
        end
      }
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
