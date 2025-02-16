-- love-ansi by Joash Chee, updated on 2025
-- A library of ansi functions for Text UI
-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

love.filesystem.setIdentity("love-ansi") -- for R36S file system compatibility

require "lib.ansi"

-- lookup table for virtual keyboard ([y][x])
vkey = {}
vkey[1] = {
[1] = "1",
[2] = "2",
[3] = "3",
[4] = "4",
[5] = "5",
[6] = "6",
[7] = "7",
[8] = "8",
[9] = "9",
[10]= "0"
}
vkey[2] = {
[1] = "q",
[2] = "w",
[3] = "e",
[4] = "r",
[5] = "t",
[6] = "y",
[7] = "u",
[8] = "i",
[9] = "o",
[10]= "p"
}
vkey[3] = {
[1] = "-",
[2] = "a",
[3] = "s",
[4] = "d",
[5] = "f",
[6] = "g",
[7] = "h",
[8] = "j",
[9] = "k",
[10]= "l"
}
vkey[4] = {
[1] = ".",
[2] = "z",
[3] = "x",
[4] = "c",
[5] = "v",
[6] = "b",
[7] = "n",
[8] = "m",
[9] = "",
[10]= ""
}
vkey[5] = {
[1] = "",
[2] = "",
[3] = "",
[4] = " ",
[5] = " ",
[6] = " ",
[7] = " ",
[8] = "",
[9] = "",
[10]= ""
}
vkey[6] = {
[1] = "1",
[2] = "2",
[3] = "3",
[4] = "4",
[5] = "5",
[6] = "6",
[7] = "7",
[8] = "8",
[9] = "9",
[10]= "0"
}
vkey[7] = {
[1] = "Q",
[2] = "W",
[3] = "E",
[4] = "R",
[5] = "T",
[6] = "Y",
[7] = "U",
[8] = "I",
[9] = "O",
[10]= "P"
}
vkey[8] = {
[1] = "-",
[2] = "A",
[3] = "S",
[4] = "D",
[5] = "F",
[6] = "G",
[7] = "H",
[8] = "J",
[9] = "K",
[10]= "L"
}
vkey[9] = {
[1] = ".",
[2] = "Z",
[3] = "X",
[4] = "C",
[5] = "V",
[6] = "B",
[7] = "N",
[8] = "M",
[9] = "",
[10]= ""
}
vkey[10] = {
[1] = "",
[2] = "",
[3] = "",
[4] = " ",
[5] = " ",
[6] = " ",
[7] = " ",
[8] = "",
[9] = "",
[10]= ""
}


-- define global variables used in all scenes

game = {}
game.power = {}
game.tooltip = "love-ansi library, Xanthia Coder 2025 | 1280x720, 160x40 chars, font 14pt - " 

game.music = game.music

width, height = love.graphics.getDimensions( )
game.width = width
game.height = height

-- game states

game.keyboard = {
	show = false,
	prompt = "",
	case = "lower",
	input = "",
	selectx = 1,
	selecty = 1,
}

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


-- this function switching all input methods for keyboard entry
-- fixed width = 39 (max string length)
function inputKeyboard()

	local width = 39
	
	function love.keypressed(key, scancode, isrepeat)
		if scancode == "up" and game.keyboard.selecty ~= 1 then
			game.keyboard.selecty = game.keyboard.selecty - 1
		elseif scancode == "left" and game.keyboard.selectx ~= 1 then
			game.keyboard.selectx = game.keyboard.selectx - 1
		elseif scancode == "down" and game.keyboard.selecty ~= 5 then
			game.keyboard.selecty = game.keyboard.selecty + 1
		elseif scancode == "right" and game.keyboard.selectx ~= 10 then
			game.keyboard.selectx = game.keyboard.selectx + 1
		end

		-- when return is pressed
		if scancode == "return" then
			if game.keyboard.case == "lower" and string.len(game.keyboard.input) < width then
				game.keyboard.input = game.keyboard.input .. vkey[game.keyboard.selecty][game.keyboard.selectx]
			elseif game.keyboard.case == "upper" and string.len(game.keyboard.input) < width then
				game.keyboard.input = game.keyboard.input .. vkey[game.keyboard.selecty+5][game.keyboard.selectx]
			end
			if game.keyboard.selecty == 4 and (game.keyboard.selectx == 9 or game.keyboard.selectx == 10) then
			-- delete entered
				game.keyboard.input = game.keyboard.input:sub(1, -2)
			end
			if game.keyboard.selecty == 5 then
				if game.keyboard.selectx <= 3 then -- caps lock entered
					if game.keyboard.case == "lower" then
						game.keyboard.case = "upper"
					else
						game.keyboard.case = "lower"
					end
				elseif game.keyboard.selectx <= 7 then -- spacebar entered
					-- do spacebar stuff
				else -- return entered
					game.keyboard.show = false
				end
			end		
		end -- scancode == "return"

	end
	
end


-- sequential commands for testing
game.keyboard.show = true
game.keyboard.input = ""
inputKeyboard()


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

	drawBox("", 10, 10, 40, 5, color.white, color.green, "rounded", "░")

	if game.keyboard.show then
		drawKeyboard(game.keyboard.prompt, game.keyboard.case)
	end

	-- display game tooltip
--	love.graphics.printf(math.floor(game.height/(game.width/16)), smallFont, 0, 0, game.width, "left")
	love.graphics.setColor( color[11] )
	love.graphics.printf(game.tooltip, monoFont, 0, 18*39, game.width, "left")

	-- display power
	game.power.state, game.power.percent, game.power.timeleft = love.system.getPowerInfo( )
	love.graphics.setColor( color[12] )
	love.graphics.printf(tostring(game.power.state) .. " " .. tostring(game.power.percent) .. "%", monoFont, 0, 18*39, game.width, "right") -- show game power

end