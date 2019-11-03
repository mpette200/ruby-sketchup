
# string to reload
# load 'Fds_Obs/main.rb'
require 'sketchup.rb'

module MPETT
  module FDSOBS
    def self.outputline(instance)
      # turn component instance into FDS coordinates
      # &OBST XB=x1,x2,y1,y2,z1,z2 / comment
      comment = instance.name
      x1 = instance.bounds.min.x.to_m
      x2 = instance.bounds.max.x.to_m
      y1 = instance.bounds.min.y.to_m
      y2 = instance.bounds.max.y.to_m
      z1 = instance.bounds.min.z.to_m
      z2 = instance.bounds.max.z.to_m
      return "&OBST XB=#{x1},#{x2},#{y1},#{y2},#{z1},#{z2} / #{comment}"
    end

    def self.activate
      model = Sketchup.active_model
      entities = model.entities
      entities.each { |entity|
        if entity.is_a? Sketchup::ComponentInstance
          # coordinates to show on console
          puts outputline(entity)
        end
      }
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('FDS coordinates') {
        self.activate
      }
      file_loaded(__FILE__)
    end

  end # module FDSOBS
end # module MPETT
