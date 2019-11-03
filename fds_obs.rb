
# list coordinates in format for fds

require 'sketchup.rb'
require 'extensions.rb'

module MPETT
  module FDSOBS

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('FDS coordinates', 'Fds_Obs/main')
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module FDSOBS
end # module MPETT
