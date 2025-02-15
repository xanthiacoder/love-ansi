-- love-ansi by Joash Chee, updated on 2025
-- A library of ansi functions for Text UI
-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

love.filesystem.setIdentity("love-ansi") -- for R36S file system compatibility

require "lib.ansi"

-- define global variables used in all scenes

TEXT_WIDTH = "0---------1---------2---------3---------4---------5---------6---------7---------8---------9---------0---------1---------2---------3---------4---------5---------"
TEXT_HEIGHT = "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n"
TEXT_BLOCKS = "▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▀ ▔ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▐ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟ ░ ▒ ▓ "
TEXT_CIRCLES = "● ○ ◯ ◔ ◕ ◶ ◌ ◉ ◎ ◦ "
TEXT_SQUARES = "◆ ◇ ◈ ◊ ■ □ ▪ ▫ ◧ ◨ ◩ ◪ ◫ "
TEXT_TRIANGLES = "▲ ▶ ▼ ◀ △ ▷ ▽ ◁ ► ◄ ▻ ◅ ▴ ▸ ▾ ◂ ▵ ▹ ▿ ◃ "
TEXT_BOXES = "╦ ╗ ╔ ═ ╩ ╝ ╚ ║ ╬ ╣ ╠ ╥ ╖ ╓ ┰ ┒ ┧ ┎ ┟ ╁ ┯ ┑ ┩ ┍ ┡ ╇ ╤ ╕ ╒ ╍ ╏ ╻ ┳ ┓ ┏ ━ ╸ ╾ ┉ ┋ ╺ ┅ ┇ ╹ ┻ ┛ ╿ ┗ ┃ ╋ ┫ ┣ ╅ ┭ ┵ ┽ ┲ ┺ ╊ ╃ ╮ ╭ ╯ ╰ ╳ ╲ ╱ ╌ ╎ ╷ ┬ ┐ ┌ ─ ╴ ╼ ┈ ┊ ╶ ┄ ┆ ╵ ╽ ┴ ┘ └ │ ┼ ┤ ├ ╆ ┮ ┶ ┾ ┱ ┹ ╉ ╄ ╨ ╜ ╙ ╀ ┸ ┦ ┚ ┞ ┖ ╈ ┷ ┪ ┙ ┢ ┕ ╧ ╛ ╘ ╫ ╢ ╟ ╂ ┨ ┠ ┿ ┥ ┝ ╪ ╡ ╞ "


game = {}
game.power = {}
game.tooltip = "love-ansi library, Xanthia Coder 2025 | 1280x720, 160x40 chars, font 14pt - " 

game.music = game.music

width, height = love.graphics.getDimensions( )
game.width = width
game.height = height


-- one-time setup of game / app, loading assets
function love.load()
	-- load monospace font, recommended size 13
	monoFont = love.graphics.newFont(FONT, FONT_SIZE)
	love.graphics.setFont( monoFont )
	love.graphics.setColor( color.brightcyan )
	game.tooltip = game.tooltip .. monoFont:getHeight() .. " height in px"
end

function love.keypressed(key, scancode, isrepeat)
	if key == "return" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end
end

-- callback for graceful exit
function love.quit()
	
end


-- to make game state changes frame-to-frame
function love.update(dt)

end

-- to render game state onto the screen, 60 fps
function love.draw()


--	love.graphics.printf(TEXT_WIDTH, monoFont, 0, 0, game.width, "left")
--	love.graphics.printf(TEXT_HEIGHT, monoFont, 0, 0, game.width, "left")

	love.graphics.setColor( color.brightblue )
	love.graphics.printf(TEXT_BLOCKS .. TEXT_CIRCLES .. TEXT_SQUARES .. TEXT_TRIANGLES .. TEXT_BOXES, monoFont, 0, 0, game.width, "left")

	love.graphics.setColor( color[1] )
	love.graphics.printf("█████████", monoFont, 0, 18*10, game.width, "left")
	love.graphics.setColor( color[2] )
	love.graphics.printf("█ Joash █", monoFont, 0, 18*11, game.width, "left")
	love.graphics.setColor( color[3] )
	love.graphics.printf("█ CHEE  █", monoFont, 0, 18*12, game.width, "left")
	love.graphics.setColor( color[4] )
	love.graphics.printf("█████████", monoFont, 0, 18*13, game.width, "left")
	love.graphics.setColor( color[5] )
	love.graphics.printf("│││││││││\n│", monoFont, 0, 18*14, game.width, "left")

local xsize = 8

	love.graphics.setColor( color[6] )
	love.graphics.printf("│", monoFont, xsize*1, 18*15, game.width, "left")
	love.graphics.setColor( color[7] )
	love.graphics.printf("│", monoFont, xsize*2, 18*15, game.width, "left")
	love.graphics.setColor( color[8] )
	love.graphics.printf("│", monoFont, xsize*3, 18*15, game.width, "left")
	love.graphics.setColor( color[9] )
	love.graphics.printf("│", monoFont, xsize*4, 18*15, game.width, "left")
	love.graphics.setColor( color[10] )
	love.graphics.printf("│", monoFont, xsize*5, 18*15, game.width, "left")

	love.graphics.setColor( color.red )
	love.graphics.printf("red", monoFont, 0, FONT_HEIGHT*16, game.width, "left")
	love.graphics.setColor( color.green )
	love.graphics.printf("green", monoFont, 0, FONT_HEIGHT*17, game.width, "left")
	love.graphics.setColor( color.yellow )
	love.graphics.printf("yellow", monoFont, 0, FONT_HEIGHT*18, game.width, "left")
	love.graphics.setColor( color.blue )
	love.graphics.printf("blue", monoFont, 0, FONT_HEIGHT*19, game.width, "left")
	love.graphics.setColor( color.magenta )
	love.graphics.printf("magenta", monoFont, 0, FONT_HEIGHT*20, game.width, "left")
	love.graphics.setColor( color.cyan )
	love.graphics.printf("cyan", monoFont, 0, FONT_HEIGHT*21, game.width, "left")
	love.graphics.setColor( color.gray )
	love.graphics.printf("gray", monoFont, 0, FONT_HEIGHT*22, game.width, "left")
	love.graphics.setColor( color.darkgray )
	love.graphics.printf("dark gray", monoFont, 0, FONT_HEIGHT*23, game.width, "left")
	love.graphics.setColor( color.brightred )
	love.graphics.printf("bright red", monoFont, 0, FONT_HEIGHT*24, game.width, "left")
	love.graphics.setColor( color.brightgreen )
	love.graphics.printf("bright green", monoFont, 0, FONT_HEIGHT*25, game.width, "left")
	love.graphics.setColor( color.brightyellow )
	love.graphics.printf("bright yellow", monoFont, 0, FONT_HEIGHT*26, game.width, "left")
	love.graphics.setColor( color.brightblue )
	love.graphics.printf("bright blue", monoFont, 0, FONT_HEIGHT*27, game.width, "left")
	love.graphics.setColor( color.brightmagenta )
	love.graphics.printf("bright magenta", monoFont, 0, FONT_HEIGHT*28, game.width, "left")
	love.graphics.setColor( color.brightcyan )
	love.graphics.printf("bright cyan", monoFont, 0, FONT_HEIGHT*29, game.width, "left")
	love.graphics.setColor( color.white )
	love.graphics.printf("white", monoFont, 0, FONT_HEIGHT*30, game.width, "left")

	drawText(" Haste", 100, 20, 20, color.black, color.brightyellow, 45, 60)
	drawText(" Blur ", 100, 21, 20, color.black, color.brightyellow, 30, 120)
	drawText(" Flying", 100, 22, 20, color.brightcyan, color.brightblue, 1, 1)


	-- display game tooltip
--	love.graphics.printf(math.floor(game.height/(game.width/16)), smallFont, 0, 0, game.width, "left")
	love.graphics.setColor( color[11] )
	love.graphics.printf(game.tooltip, monoFont, 0, 18*39, game.width, "left")

	-- display power
	game.power.state, game.power.percent, game.power.timeleft = love.system.getPowerInfo( )
	love.graphics.setColor( color[12] )
	love.graphics.printf(tostring(game.power.state) .. " " .. tostring(game.power.percent) .. "%", monoFont, 0, 18*39, game.width, "right") -- show game power

end