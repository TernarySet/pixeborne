class Player
    attr_accessor :planeX, :planeY, :dirX, :dirY, :posX, :posY, :rotSpeed
    def initialize(posX, posY, dirX, dirY, px = 0, py = 0.66)
        @spr = Gosu::Image.new("#{__dir__}/../assets/idle.png")
        @planeX = px
        @planeY = py 
        @dirX = dirX
        @dirY = dirY
        @rotSpeed = 0.2
        @posX = posX
        @posY = posY
    end

    def update(win,w) 
    end

    def turnLeft()
        oldDirX = @dirX.to_f
        @dirX = @dirX * Math.cos(@rotSpeed) - @dirY * Math.sin(@rotSpeed)
        @dirY = oldDirX * Math.sin(@rotSpeed) + @dirY * Math.cos(@rotSpeed)
        oldPlaneX = @planeX.to_f
        @planeX = @planeX * Math.cos(@rotSpeed) - @planeY * Math.sin(@rotSpeed)
        planeY = oldPlaneX * Math.sin(@rotSpeed) + @planeY * Math.cos(@rotSpeed)
    end

    def turnRight()
        oldDirX = @dirX.to_f
        @dirX = @dirX * Math.cos(@rotSpeed) - @dirY * Math.sin(@rotSpeed)
        @dirY = oldDirX * Math.sin(@rotSpeed) + @dirY * Math.cos(@rotSpeed)
        oldPlaneX = @planeX.to_f
        @planeX = @planeX * Math.cos(@rotSpeed) - @planeY * Math.sin(@rotSpeed)
        planeY = oldPlaneX * Math.sin(@rotSpeed) + @planeY * Math.cos(@rotSpeed)
    end

    def draw
        @spr.draw(@posX,@posY,0)
    end
end
