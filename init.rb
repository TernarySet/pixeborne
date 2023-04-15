require 'gosu'  

require_relative 'src/engine/raycaster.rb'
require_relative 'src/player.rb'

SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480

MAP_WIDTH = 8
MAP_HEIGHT = 8


class Game < Gosu::Window 
    def initialize
        super(SCREEN_WIDTH, SCREEN_HEIGHT) 
        @pause = true

        # Start raycaster code
        @posX = 6     # x and y start position
        @posY = 6   
        @dirX = -1
        @dirY = -1
        @time = 0       # time of current frame
        @oldTime = 0    # time of previous frame
 
        @planeX = 0
        @planeY = 0.66

        @rotSpeed = 0.02
        @moveSpeed = 0.5

        @worldMap = [
            [1,1,1,1,1,1,1,1],
            [1,0,0,0,0,0,0,1],
            [1,0,0,0,0,0,0,1],
            [1,0,0,0,0,0,0,1],
            [1,0,0,0,0,0,0,1],
            [1,0,0,0,0,0,0,1],
            [1,0,0,0,0,0,0,1],
        ]       
        @raycaster = RayCaster.new(@worldMap, SCREEN_WIDTH, SCREEN_HEIGHT)
        @player = Player.new(@posX, @posY,@dirX,@dirY,@planeX,@planeY)
        @player.rotSpeed = 0.01
        @spr = Gosu::Image.new("#{__dir__}/assets/idle.png")
    end

    def update 
        @w = SCREEN_WIDTH 
        @h = SCREEN_HEIGHT
        @raycaster.update(@player)
        @player.update(self,@w)


    end

    def draw  

        @raycaster.draw
        @spr.draw(@w/2-52,@h/2)
    end 
 
end

Game.new.show