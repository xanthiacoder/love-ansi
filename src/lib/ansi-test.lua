-- testing suite for love-ansi.lua by joash chee to emulate ANSI

---------------------------------------------------------------------------------------
-- Functions:
-- drawText(text, x, y, width, fgcolor, bgcolor, fillvalue, fillmax)
-- drawTextColor(text, x, y, width, bgcolor)
-- drawBar(text, x, y, width, currentvalue, formervalue, maxvalue, fgcolor, bgcolor, textcolor)
-- drawReverseBar(text, x, y, width, currentvalue, formervalue, maxvalue, fgcolor, bgcolor, textcolor)
-- drawTextBox(text, x, y, width, height, fgcolor, bgcolor, alignment)
-- drawBox(title, x, y, width, height, fgcolor, bgcolor, boxtype, fillchar)
-- drawKeyboard(prompt, case)
---------------------------------------------------------------------------------------

-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14pt
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



	-- set initial values for list testing
	local testList = {
		[1] = "^wSome ^ggreen fingers",
		[2] = "^wA ^rred herring",
		[3] = "^wFresh ^cice-cream",
		[4] = "^wRipe ^ybananas",
		[5] = "^wFragrant ^pgrapes",
	}

function testLoad()
	bgm = love.audio.newSource("audio/CyborgNinja.ogg", "static")
	bgm:play()
	punch = {}
	punch[1] = love.audio.newSource("audio/punch1.wav", "static")
	punch[2] = love.audio.newSource("audio/punch2.wav", "static")
	punch[3] = love.audio.newSource("audio/punch3.wav", "static")
	punch[4] = love.audio.newSource("audio/punch4.wav", "static")
	punch[5] = love.audio.newSource("audio/punch5.ogg", "static")
	punch[6] = love.audio.newSource("audio/punch6.wav", "static")
	punch[7] = love.audio.newSource("audio/punch7.wav", "static")
end -- testLoad()


function testRun()

	-- sequential commands for testing
	game.keyboard.show = false
	game.keyboard.input = ""

	-- set intial input scheme
--	inputKeyboard()
	inputDefault()
	
	game.list.selected = 1
	game.list.lastItem = #testList
	game.list.confirm = false

	local saveTable = json.encode(color)
	local file = io.open(love.filesystem.getSaveDirectory().."//ui/color.txt", "w")
	file:write(saveTable)
	file:close()

end

function testUpdate()
	-- HP bar transition effects
	if game.playerone.hpBefore > game.playerone.hpNow then
		game.playerone.hpBefore = game.playerone.hpBefore - 0.5
	end
	if game.playertwo.hpBefore > game.playertwo.hpNow then
		game.playertwo.hpBefore = game.playertwo.hpBefore - 0.5
	end
end

function testDraw()

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
	drawTextColor("^wWith ^rtextmode ^gU^cI, ^wthe most ^Kgoing ^wfor ^kit ^wis ^Rc^Go^Bl^Po^Yr.", 5, 21, 50, color.grey)
	drawTextColor("^wSo this is ^rsuper important^w. A ^gmust-have!", 5, 22, 50, color.black)
	drawTextColor("^WColor for indicating ^yPOWER!", 5, 23, 50, color.black)
	drawTextColor("^WOr even just some fancy ^gc^bo^rl^yo^cr^pful stuff...", 5, 24, 50, color.black)
	drawTextColor("^cLet's test a ^ysuperrr-long string ^cand see if it cuts off ^rcorrectly.", 5, 25, 50, color.black)

	-- drawDialogBox(title, msg, options, x, y, framecolor, bgcolor)
	drawDialogBox("", " ^wAre you ready for ^pL^yO^cV^rE ^cJ^yA^pM ^w2025? ", " ^y[y]^wes  ^y[n]^wo ", 100, 7, color.brightblue, color.blue)
	drawDialogBox("", " ^rQuit? ", " ^y[y]^wes  ^y[n]^wo ", 100, 20, color.brightblue, color.blue)

	-- drawNoScrollList(title, list, options, x, y, width, framecolor, bgcolor)	
	drawNoScrollList("", testList, " ^y"..#testList.." ^witems ", 60, 9, 25, color.brightblue, color.blue)

	-- drawScrollList(title, list, options, selected, x, y, width, framecolor, bgcolor)
	drawScrollList("", testList, " ^w[^yUp/Down^w] Change selection ", game.list.selected, 60, 22, 25, color.brightblue, color.blue)

	-- test saving a table in JSON

	-- draw screen guides for width and height text coordinates
	love.graphics.printf(TEXT_WIDTH, monoFont, 0, 0, game.width, "left")
	love.graphics.printf(TEXT_HEIGHT, monoFont, 0, 0, game.width, "left")

end -- testDraw()