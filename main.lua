local settings = require("settings")
local moonshine = require 'moonshine'
function love.load()
	effect = moonshine(moonshine.effects.crt).chain(moonshine.effects.chromasep).chain(moonshine.effects.scanlines)--.chain(moonshine.effects.glow)
	effect.chromasep.radius=3
	effect.scanlines.opacity=0.5

	clock_text = "%I:%M %p\n%b %d %Y"
	background_color = {30, 30, 46}
	fg_color = {205, 214, 244}

	if settings.bg_color then
		background_color = settings.bg_color
	end

	if settings.fg_color then                                                                                                                                                         
                fg_color = settings.fg_color 
        end

	if settings.clock_format then
		clock_text = settings.clock_format
	end

	local r, g, b = love.math.colorFromBytes(background_color[1], background_color[2], background_color[3])
	love.graphics.setBackgroundColor( r,g,b,0.5 )

	font_path = "FiraCode.ttf"
	if settings.font then
		font_path = settings.font
	end

	clock_size = 20*2

        width=200*2

        height=100*2

	if settings.clock_size then
		clock_size = settings.clock_size
	end

	if settings.width then
		width = settings.width
	end

	if settings.height then
		height = settings.height
	end
	

	font = love.graphics.newFont(font_path,clock_size)
	getW, getH = love.graphics.getWidth, love.graphics.getHeight
	love.graphics.setFont(font)

	love.window.setMode(width,height)
	effect.resize(width,height)
	

	love.window.setTitle( "CRT Clock" )
end

function love.draw()
	local r,g,b = love.math.colorFromBytes(fg_color[1], fg_color[2], fg_color[3])
	love.graphics.setColor(r,g,b)	
	effect(function()
		--love.graphics.rectangle("fill", 0,0, getW(),getH())
		love.graphics.printf(os.date(clock_text), 0, getH() / 2 - font:getHeight() / 2, getW(), "center")
		--love.graphics.printf(os.date("%I:%M"), 0, 0, getW(), "center")
		--love.graphics.printf(os.date("%b %d %Y"), 0, (getH() / 2 - font:getHeight() / 2)+10, getW(), "center")
	end)
	
end

function love.update(dt)
	if love.keyboard.isDown( "lctrl" ) and love.keyboard.isDown( "c" ) then
		os.exit()
	end                                                        
end
