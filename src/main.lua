-- love-ansi by Joash Chee, updated on 2025
-- A library of ansi functions for Text UI
-- bootstrap template with virtual keyboard
-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

love.filesystem.setIdentity("love-ansi") -- for R36S file system compatibility

require "lib.ansi" -- love-ansi main library
require "lib.ansi-test" -- love-ansi test suite


-- define global variables used in all scenes

game = {}
game.power = {}
game.tooltip = "love-ansi library, Xanthia Coder 2025 | 1280x720, 160x40 chars, font 14pt - " 

game.music = game.music

width, height = love.graphics.getDimensions( )
game.width = width
game.height = height

-- requires lib.ansi
game.keyboard = {
	show = false,
	done = false,
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
	
	-- test suite (remove when not testing) from lib.ansi-test
	testLoad()

end


-- test suite (remove when not testing) from lib.ansi-test
testRun()


-- callback for graceful exit
function love.quit()
	
end


-- to make game state changes frame-to-frame
function love.update(dt)

	-- test suite (to remove) from lib.ansi-test
	testUpdate()
	
end

-- to render game state onto the screen, 60 fps
function love.draw()

	-- test suite (remove when using template) from lib.ansi-test
	testDraw()
	
	-- show / hide virtual keyboard
	if game.keyboard.show then
		drawKeyboard(game.keyboard.prompt, game.keyboard.case)
	end -- returns game.keyboard.input

	-- display game tooltip
	love.graphics.setColor( color.brightcyan )
	love.graphics.printf(game.tooltip, monoFont, 0, 18*39, game.width, "left")

	-- display power
	game.power.state, game.power.percent, game.power.timeleft = love.system.getPowerInfo( )
	love.graphics.setColor( color.brightcyan )
	love.graphics.printf(tostring(game.power.state) .. " " .. tostring(game.power.percent) .. "%", monoFont, 0, 18*39, game.width, "right") -- show game power

end