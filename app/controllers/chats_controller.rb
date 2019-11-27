class ChatsController < ApplicationController
  
  def video
    gon.skyway_key = ENV['SKYWAY_KEY']
  end
end
