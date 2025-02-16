-- love-ansi.lua by joash chee to emulate ANSI

---------------------------------------------------------------------------------------
-- Functions:
-- drawText(text, x, y, width, fgcolor, bgcolor, fillvalue, fillmax)
-- drawTextBox(text, x, y, width, height, fgcolor, bgcolor, alignment)
-- drawBox(title, x, y, width, height, fgcolor, bgcolor, boxtype, fillchar)
-- drawKeyboard(prompt, case)
---------------------------------------------------------------------------------------

-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14pt
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

-- Virtual Keyboard Render (41 x 13, max unput length = 39 )
-- 12345678901234567890123456789012345678901
local keyboard = {
[1] = "╔═══════════════════════════════════════╗",
[2] = "║                                       ║",
[3] = "╟───╥───╥───╥───╥───╥───╥───╥───╥───╥───╢",
[4] = "║ 1 ║ 2 ║ 3 ║ 4 ║ 5 ║ 6 ║ 7 ║ 8 ║ 9 ║ 0 ║",
[5] = "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣",
[6] = "║ q ║ w ║ e ║ r ║ t ║ y ║ u ║ i ║ o ║ p ║",
[7] = "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣",
[8] = "║ - ║ a ║ s ║ d ║ f ║ g ║ h ║ j ║ k ║ l ║",
[9] = "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╩═══╣",
[10]= "║ . ║ z ║ x ║ c ║ v ║ b ║ n ║ m ║  del  ║",
[11]= "╠═══╩═══╩═══╬═══╩═══╩═══╩═══╬═══╩═══════╣",
[12]= "║ caps lock ║     space     ║   enter   ║",
[13]= "╚═══════════╩═══════════════╩═══════════╝",
[14]= "╔═══════════════════════════════════════╗",
[15]= "║                                       ║",
[16]= "╟───╥───╥───╥───╥───╥───╥───╥───╥───╥───╢",
[17]= "║ 1 ║ 2 ║ 3 ║ 4 ║ 5 ║ 6 ║ 7 ║ 8 ║ 9 ║ 0 ║",
[18]= "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣",
[19]= "║ Q ║ W ║ E ║ R ║ T ║ Y ║ U ║ I ║ O ║ P ║",
[20]= "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣",
[21]= "║ - ║ A ║ S ║ D ║ F ║ G ║ H ║ J ║ K ║ L ║",
[22]= "╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╩═══╣",
[23]= "║ . ║ Z ║ X ║ C ║ V ║ B ║ N ║ M ║  del  ║",
[24]= "╠═══╩═══╩═══╬═══╩═══╩═══╩═══╬═══╩═══════╣",
[25]= "║ caps lock ║     space     ║   enter   ║",
[26]= "╚═══════════╩═══════════════╩═══════════╝"
}


local TEXT_WIDTH = "0---------1---------2---------3---------4---------5---------6---------7---------8---------9---------0---------1---------2---------3---------4---------5---------"
local TEXT_HEIGHT = "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n0\n1\n2\n"
local TEXT_BLOCKS = "▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▀ ▔ ▏ ▎ ▍ ▌ ▋ ▊ ▉ ▐ ▕ ▖ ▗ ▘ ▙ ▚ ▛ ▜ ▝ ▞ ▟ ░ ▒ ▓ "
local TEXT_CIRCLES = "● ○ ◯ ◔ ◕ ◶ ◌ ◉ ◎ ◦ "
local TEXT_SQUARES = "◆ ◇ ◈ ◊ ■ □ ▪ ▫ ◧ ◨ ◩ ◪ ◫ "
local TEXT_TRIANGLES = "▲ ▶ ▼ ◀ △ ▷ ▽ ◁ ► ◄ ▻ ◅ ▴ ▸ ▾ ◂ ▵ ▹ ▿ ◃ "
local TEXT_BOXES = "╦ ╗ ╔ ═ ╩ ╝ ╚ ║ ╬ ╣ ╠ ╥ ╖ ╓ ┰ ┒ ┧ ┎ ┟ ╁ ┯ ┑ ┩ ┍ ┡ ╇ ╤ ╕ ╒ ╍ ╏ ╻ ┳ ┓ ┏ ━ ╸ ╾ ┉ ┋ ╺ ┅ ┇ ╹ ┻ ┛ ╿ ┗ ┃ ╋ ┫ ┣ ╅ ┭ ┵ ┽ ┲ ┺ ╊ ╃ ╮ ╭ ╯ ╰ ╳ ╲ ╱ ╌ ╎ ╷ ┬ ┐ ┌ ─ ╴ ╼ ┈ ┊ ╶ ┄ ┆ ╵ ╽ ┴ ┘ └ │ ┼ ┤ ├ ╆ ┮ ┶ ┾ ┱ ┹ ╉ ╄ ╨ ╜ ╙ ╀ ┸ ┦ ┚ ┞ ┖ ╈ ┷ ┪ ┙ ┢ ┕ ╧ ╛ ╘ ╫ ╢ ╟ ╂ ┨ ┠ ┿ ┥ ┝ ╪ ╡ ╞ "

FONT = "JetBrainsMonoNL-Regular.ttf"
FONT_SIZE = 14
FONT_WIDTH = 8
FONT_HEIGHT = 18

--	eg. 	love.graphics.setColor( color.white ) or color[0..15]
color = {
	black 			= {   0,   0,   0, 1 }, [0] 			= {   0,   0,   0, 1 },
	red 			= { 0.5,   0,   0, 1 },	[1] 			= { 0.5,   0,   0, 1 },
	green 			= {   0, 0.5,   0, 1 },	[2] 			= {   0, 0.5,   0, 1 },
	yellow 			= { 0.5, 0.5,   0, 1 },	[3] 			= { 0.5, 0.5,   0, 1 },
	blue 			= {   0,   0, 0.5, 1 },	[4] 			= {   0,   0, 0.5, 1 },
	magenta			= { 0.5,   0, 0.5, 1 },	[5]				= { 0.5,   0, 0.5, 1 },
	cyan 			= {   0, 0.5, 0.5, 1 },	[6] 			= {   0, 0.5, 0.5, 1 },
	gray	 		= { 0.7, 0.7, 0.7, 1 },	[7]		 		= { 0.7, 0.7, 0.7, 1 },
	grey	 		= { 0.7, 0.7, 0.7, 1 },
	darkgray		= { 0.5, 0.5, 0.5, 1 },	[8]				= { 0.5, 0.5, 0.5, 1 },
	darkgrey		= { 0.5, 0.5, 0.5, 1 },
	brightred		= {   1,   0,   0, 1 },	[9]				= {   1,   0,   0, 1 },
	brightgreen		= {   0,   1,   0, 1 },	[10]			= {   0,   1,   0, 1 },
	brightyellow 	= {   1,   1,   0, 1 },	[11]		 	= {   1,   1,   0, 1 },
	brightblue 		= {   0,   0,   1, 1 },	[12]	 		= {   0,   0,   1, 1 },
	brightmagenta 	= {   1,   0,   1, 1 },	[13]		 	= {   1,   0,   1, 1 },
	brightcyan 		= {   0,   1,   1, 1 },	[14]	 		= {   0,   1,   1, 1 },
	white 			= {   1,   1,   1, 1 },	[15] 			= {   1,   1,   1, 1 },
	}



function drawText(text, x, y, width, fgcolor, bgcolor, fillvalue, fillmax)

	-- draw background's background first with fillmax, half all RGB
	-- draw background's background using rectangle
	love.graphics.setColor( bgcolor[1]/2, bgcolor[2]/2, bgcolor[3]/2, bgcolor[4] )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, FONT_HEIGHT)
	-- draw background's fill based on fillvalue/fillmax
	-- draw background's fill using thick line
	love.graphics.setLineWidth( FONT_HEIGHT )
	love.graphics.setColor( bgcolor )
	love.graphics.line(x*FONT_WIDTH, (y*FONT_HEIGHT)+(FONT_HEIGHT/2), (x*FONT_WIDTH)+((width*FONT_WIDTH)*(fillvalue/fillmax)), (y*FONT_HEIGHT)+(FONT_HEIGHT/2))

	-- draw foreground text
	love.graphics.setColor( fgcolor )
	love.graphics.printf(string.sub(text, 1, width), x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')

end -- drawText


function drawTextBox(text, x, y, width, height, fgcolor, bgcolor, alignment)

	-- draw background using rectangle
	love.graphics.setColor( bgcolor )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, height*FONT_HEIGHT)

	-- draw foreground text
	love.graphics.setColor( fgcolor )
	love.graphics.printf(text, x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, alignment)

end -- drawTextBox


-- ansi.box("boxtitle", x, y, width, height, fgcolor, bgcolor, type, fill)
-- type = single, double, rounded, thick, borderless
-- fill = single char to fill the box
function drawBox(title, x, y, width, height, fgcolor, bgcolor, boxtype, fillchar)

	-- draw background using rectangle
	love.graphics.setColor( bgcolor )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, height*FONT_HEIGHT)

	-- draw foreground box
	-- set box glyphs according to boxtype

	local topLeft, topRight, bottomLeft, bottomRight, horizontal, vertical = ""
	if boxtype == "single" then
		topLeft = "┌"
		topRight = "┐"
		bottomLeft = "└"
		bottomRight = "┘"
		horizontal = "─"
		vertical = "│"
	elseif boxtype == "double" then
		topLeft = "╔"
		topRight = "╗"
		bottomLeft = "╚"
		bottomRight = "╝"
		horizontal = "═"
		vertical = "║"	
	elseif boxtype == "rounded" then
		topLeft = "╭"
		topRight = "╮"
		bottomLeft = "╰"
		bottomRight = "╯"
		horizontal = "─"
		vertical = "│"
	elseif boxtype == "thick" then
		topLeft = "┏"
		topRight = "┓"
		bottomLeft = "┗"
		bottomRight = "┛"
		horizontal = "━"
		vertical = "┃"	
	elseif boxtype == "borderless" then
		topLeft = " "
		topRight = " "
		bottomLeft = " "
		bottomRight = " "
		horizontal = " "
		vertical = " "
	end

	love.graphics.setColor( fgcolor )
	-- draw corners
	love.graphics.printf(topLeft, x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf(bottomLeft, x*FONT_WIDTH, (y+height-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf(topRight, (x+width-1)*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf(bottomRight, (x+width-1)*FONT_WIDTH, (y+height-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	-- draw horizontal lines
	local i = 0
	for i = 1,width-2 do
		love.graphics.printf(horizontal, (x+i)*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		love.graphics.printf(horizontal, (x+i)*FONT_WIDTH, (height+y-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	end
	-- draw vertical lines
	for i = 1,height-2 do
		love.graphics.printf(vertical, x*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		love.graphics.printf(vertical, (x+width-1)*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	end

	-- draw fill char
	local j = 0
	for i = 1,height-2 do
		for j = 1,width-2 do
			love.graphics.printf(fillchar, (x+j)*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		end -- j
	end -- i

	-- draw title if it's not blank
	if title ~= "" then
		drawText("["..title.."]", x+2, y, string.len(title)+2, fgcolor, bgcolor, 1, 1)
	end
end -- drawBox

-- virtual keyboard (for console compatibility)
-- uses global from main.lua : game.keyboard.input
-- fixed x, y, width = 41, height = 13, fgcolor, bgcolor, maxinputlength = width-2, case = "upper" or "lower"
function drawKeyboard(prompt, case)

	local dataEntry = ""
	local dataSubmit = false
	local x = 59
	local y = 13
	local width = 41
	local height = 13
	local fgcolor = color.white
	local bgcolor = color.darkgray

	-- draw background using rectangle
	love.graphics.setColor( bgcolor )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, height*FONT_HEIGHT)

	-- draw current selected key (using global in main.lua game.keyboard.selectx and selecty)
	drawTextBox("▗▄▄▄▖\n▐███▍\n▝▀▀▀▘", x+((game.keyboard.selectx-1)*4), y+2+((game.keyboard.selecty-1)*2), 5, 3, color.brightblue, color.darkgray, "left")	

	-- draw upper or lower case keyboard
	local i = 0
	love.graphics.setColor( fgcolor )
	if case == "lower" then
		for i = 0,12 do
			love.graphics.printf(keyboard[i+1], x*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		end
	elseif case == "upper" then
		for i = 0,12 do
			love.graphics.printf(keyboard[i+14], x*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		end	
	end

	-- draw prompt if it's not blank
	if prompt ~= "" then
		drawText("["..prompt.."]", x+2, y, string.len(prompt)+2, fgcolor, bgcolor, 1, 1)
	end

	-- draw game.keyboard.input text
	drawText(game.keyboard.input, x+1, y+1, width-2, color.brightyellow, color.brightblue, string.len(game.keyboard.input), 39)

end -- inputKeyboard