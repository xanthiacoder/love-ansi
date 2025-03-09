-- love-ansi by Joash Chee, updated on 2025
-- A library of ansi functions for Text UI
-- bootstrap template with virtual keyboard
-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

-- Stick Fighter II (demo visuals)
--  O  
-- /TL
-- /| 
-- " O \n/TL\n/| "

--  O  
-- LT>
--  X
-- " O \nLT>\n X "

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

game.playerone = {
	hpMax = 100,
	hpNow = 100,
	hpBefore = 100,
}

game.playertwo = {
	hpMax = 100,
	hpNow = 100,
	hpBefore = 100,
}

-- one-time setup of game / app, loading assets
function love.load()
	-- load monospace font, recommended size 13
	monoFont = love.graphics.newFont(FONT, FONT_SIZE)
	love.graphics.setFont( monoFont )
	love.graphics.setColor( color.brightcyan )
	game.tooltip = game.tooltip .. monoFont:getHeight() .. " height in px"
	bgm = love.audio.newSource("audio/CyborgNinja.mp3", "static")
	bgm:play()
	punch = {}
	punch[1] = love.audio.newSource("audio/punch1.wav", "static")
	punch[2] = love.audio.newSource("audio/punch2.wav", "static")
	punch[3] = love.audio.newSource("audio/punch3.wav", "static")
	punch[4] = love.audio.newSource("audio/punch4.wav", "static")
	punch[5] = love.audio.newSource("audio/punch5.ogg", "static")
	punch[6] = love.audio.newSource("audio/punch6.wav", "static")
	punch[7] = love.audio.newSource("audio/punch7.wav", "static")
end

function love.keypressed(key, scancode, isrepeat)
	if key == "return" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "exclusive")
	end

	if key == "escape" then
		love.event.quit()
	end

	if key == "a" then
		local hit = love.math.random(2)
		if hit == 1 then
			punch[love.math.random(7)]:play()
			game.playerone.hpNow = game.playerone.hpNow - love.math.random(10)
		else
			punch[love.math.random(7)]:play()
			game.playertwo.hpNow = game.playertwo.hpNow - love.math.random(10)
		end
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
game.keyboard.show = false
game.keyboard.input = ""
-- inputKeyboard()


-- callback for graceful exit
function love.quit()
	
end


-- to make game state changes frame-to-frame
function love.update(dt)

	-- HP bar transition effects
	if game.playerone.hpBefore > game.playerone.hpNow then
		game.playerone.hpBefore = game.playerone.hpBefore - 0.5
	end
	if game.playertwo.hpBefore > game.playertwo.hpNow then
		game.playertwo.hpBefore = game.playertwo.hpBefore - 0.5
	end

end

-- to render game state onto the screen, 60 fps
function love.draw()

	-- fill full window with background color
	love.graphics.setColor( color.darkgrey )
	love.graphics.rectangle("fill", 0, 0, width, height)

	-- draw demo title
	drawText("STICK FIGHTER II", 57, 3, 16, color.white, color.darkgrey, 1, 1)

	-- check for empty HP bars, game win conditions
	if game.playerone.hpNow <= 0 then
		game.playerone.hpNow = 0
		drawTextBox("\nCann wins!", 60, 12, 12, 3, color.brightcyan, color.blue, "center")
	end
	if game.playertwo.hpNow <= 0 then
		game.playertwo.hpNow = 0
		drawTextBox("\nY.U. wins!", 60, 12, 12, 3, color.brightcyan, color.blue, "center")
	end
	
	-- draw Stick Fighters HP bars
	drawBar("Y.U.", 10, 5, 50, game.playerone.hpNow, game.playerone.hpBefore, game.playerone.hpMax, color.brightyellow, color.brightred, color.black)
	drawReverseBar("Cann", 70, 5, 50, game.playertwo.hpNow, game.playertwo.hpBefore, game.playertwo.hpMax, color.brightyellow, color.brightred, color.black)

	-- draw Stick Fighters
	drawTextBox(" O \n/TL\n/| ", 35, 7, 3, 4, color.black, color.darkgrey, "left")
	drawTextBox(" O \nLT>\n X ", 95, 7, 3, 4, color.black, color.darkgrey, "left")

	-- drawTextColor(text, x, y, width, bgcolor) test
	drawTextColor("^wSo ^chappy ^wthat I got this ^pdone!", 5, 20, 50, color.black)
	drawTextColor("^wWith ^rtextmode ^gU^cI, ^wthe most going for it is ^Rc^Go^Bl^Po^Yr.", 5, 21, 50, color.grey)
	drawTextColor("^wSo this is ^rsuper important^w. A ^gmust-have!", 5, 22, 50, color.black)
	drawTextColor("^WColor for indicating ^yPOWER!", 5, 23, 50, color.black)
	drawTextColor("^WOr even just some fancy ^gc^bo^rl^yo^cr^pful stuff...", 5, 24, 50, color.black)
	drawTextColor("^cLet's test a ^ysuperrr-long string ^cand see if it cuts off ^rcorrectly.", 5, 25, 50, color.black)

	-- drawFatBox
	drawFatBox("", 40, 30, 60, 6, color.brightblue, color.blue)
	-- drawInputTip(text, x, y, framecolor, bgcolor)
	drawInputTip(" ^y[y]^wes  ^y[n]^wo ", 62, 35, color.brightblue, color.blue)
	drawTextColor("^wAre you ready for ^pL^yO^cV^rE ^cJ^yA^pM ^w2025?", 42, 32, 56, color.blue)


	-- draw screen guides for width and height text coordinates
	love.graphics.printf(TEXT_WIDTH, monoFont, 0, 0, game.width, "left")
	love.graphics.printf(TEXT_HEIGHT, monoFont, 0, 0, game.width, "left")

	-- show / hide virtual keyboard
	if game.keyboard.show then
		drawKeyboard(game.keyboard.prompt, game.keyboard.case)
	end

	-- display game tooltip
	love.graphics.setColor( color.brightcyan )
	love.graphics.printf(game.tooltip, monoFont, 0, 18*39, game.width, "left")

	-- display power
	game.power.state, game.power.percent, game.power.timeleft = love.system.getPowerInfo( )
	love.graphics.setColor( color.brightcyan )
	love.graphics.printf(tostring(game.power.state) .. " " .. tostring(game.power.percent) .. "%", monoFont, 0, 18*39, game.width, "right") -- show game power

end