class RayCaster  
    def initialize(world_map, screen_width, screen_height) 
        @world_map = world_map
        @w = screen_width
        @h = screen_height 
        @rayDirX
        @dirY 
    end   

    def update(p)
        @planeX = p.planeX
        @planeY = p.planeY 
        @dirX = p.dirX
        @dirY = p.dirY

        @posX = p.posX
        @posY = p.posY
    end


    def ray(x)
        # calculate ray position and direction
        cameraX = (2 * (x / @w.to_f)) - 1;   # x-coordinate in camera space
        rayDirX = @dirX + (@planeX * cameraX)
        rayDirY = @dirY + (@planeY * cameraX)
        # which box of the map we're in
        mapX = @posX.to_i
        mapY = @posY.to_i 
        deltaDistX = (rayDirX == 0) ? 1e31 : (1 / rayDirX).abs
        deltaDistY = (rayDirY == 0) ? 1e31 : (1 / rayDirY).abs
          
        perpWallDist = nil    # double
          
        # what direction to step in x or y-direction (either +1 or -1)
        stepX = nil    # int
        stepY = nil    # int

                  
        hit = 0        # was there a wall hit? (int) (is this really a boolean)
        side = nil      
        if rayDirX < 0
            stepX = -1
            sideDistX = (@posX - mapX) * deltaDistX
        else
            stepX = 1
            sideDistX = (mapX + 1.0 - @posX) * deltaDistX
        end
        if rayDirY < 0
            stepY = -1
            sideDistY = (@posY - mapY) * deltaDistY
        else
            stepY = 1;
            sideDistY = (mapY + 1.0 - @posY) * deltaDistY
        end
        # perform DDA
        while hit == 0
            # jump to next map square, either in x-direction, or in y-direction
            if sideDistX < sideDistY
                sideDistX += deltaDistX
                mapX += stepX
                side = 0
            else
                sideDistY += deltaDistY
                mapY += stepY
                side = 1
            end
            # Check if ray has hit a wall
            if @world_map[mapX][mapY] > 0
                hit = 1
            end
        end 
        if side == 0
            perpWallDist = (sideDistX - deltaDistX)
        else
            perpWallDist = (sideDistY - deltaDistY)
        end

        # Calculate height of line to draw on screen
        lineHeight = (@h / perpWallDist)

        # calculate lowest and highest pixel to fill in current stripe
        drawStart = ((-lineHeight / 2) + (@h / 2)) 
        if drawStart < 0
            drawStart = 0
        end
        drawEnd = ((lineHeight / 2) + (@h / 2)) 
        if drawEnd >= @h
            drawEnd = @h - 1
        end
        
        [drawStart, drawEnd, mapX, mapY, side]
    end

    def draw
        @w.times do |x| 
            drawStart, drawEnd, mapX, mapY, side = ray(x)
            
            # choose wall color
            color = nil   # rgb
            case @world_map[mapX][mapY]
            when 1
                color = Gosu::Color.new(255, 255, 0, 0)
            when 2
                color = Gosu::Color.new(255, 0, 255, 0)
            when 3
                color = Gosu::Color.new(255, 0, 0, 255)
            when 4
                color = Gosu::Color.new(255, 255, 255, 255)
            else
                color = COLOR_YELLOW
            end
            if side == 1
                color = Gosu::Color.new(255, color.red / 2, color.green / 2, color.blue / 2)
            end
            Gosu::draw_line(x, drawStart,color, x, drawEnd, color)
        end
    end
end
 
