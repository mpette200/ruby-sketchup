
# list ies gem format in console

require 'sketchup.rb'
require 'extensions.rb'

module MPETT
  module IESGEM

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('IES gemfile', 'ies_gem/main')
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module IESGEM
end # module MPETT
