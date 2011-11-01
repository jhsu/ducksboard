require 'base64'
require 'json'
module Ducksboard
  class Image < Widget

    def initialize(*args)
      super
      @data[:value] ||={}
    end

    def source
      @data[:value][:source]
    end

    def source=(image_location)
      source_value = if image_location =~ /^http/
        image_location
      else
        'data:image/png;base64,' + 
          Base64.encode64(File.read(File.expand_path(image_location)))
      end
      @data[:value][:source] = source_value
    end

    def caption
      @data[:value][:caption]
    end

    def caption=(text=nil)
      @data[:value][:caption] = caption.to_s
    end

    def timestamp
      @data[:timestamp]
    end

    def timestamp=(time)
      @data[:timestamp] = time
    end

  end
end
