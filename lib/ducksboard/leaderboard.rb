require 'base64'
require 'json'
module Ducksboard
  class Leaderboard < Widget
   
    def initialize(*args)
      super
      @data[:value] ||={}
    end
    
    def linha 
       @data[:value][:board]
    end
    
    def linha=(linhaa) 
     @data[:value][:board] = linhaa
    end

  end
end
