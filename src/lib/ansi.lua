-- love-ansi.lua by joash chee to emulate ANSI

---------------------------------------------------------------------------------------
-- Functions:
-- drawBox(x, y, width, height, foreground, background)
-- drawText(text, x, y, width, fgcolor, bgcolor, fillvalue, fillmax)
---------------------------------------------------------------------------------------

-- monotype font is JetBrainsMonoNL-Regular.ttf
-- font size is 14pt
-- font width is 8 pixels, font height is 18 pixels
-- screen 1280 x 720 pixels
-- 160 x 40 chars

FONT = "JetBrainsMonoNL-Regular.ttf"
FONT_SIZE = 14
FONT_WIDTH = 8
FONT_HEIGHT = 18

--	eg. 	love.graphics.setColor( color.white )
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

function drawBox(x, y, width, height, foreground, background)

	local i = 0
	love.graphics.setColor( background )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, height*FONT_HEIGHT)
	love.graphics.setColor( foreground )
	love.graphics.printf("┌", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf("╘", x*FONT_WIDTH, (y+height-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf("╖", (x+width-1)*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	love.graphics.printf("╝", (x+width-1)*FONT_WIDTH, (y+height-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	for i = 1,width-2 do
		love.graphics.printf("─", (x+i)*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		love.graphics.printf("═", (x+i)*FONT_WIDTH, (height+y-1)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	end
	for i = 1,height-2 do
		love.graphics.printf("│", x*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
		love.graphics.printf("║", (x+width-1)*FONT_WIDTH, (y+i)*FONT_HEIGHT, width*FONT_WIDTH, 'left')
	end
end -- drawBox


function drawText(text, x, y, width, fgcolor, bgcolor, fillvalue, fillmax)

	-- draw background first using thick line
	love.graphics.setLineWidth( FONT_HEIGHT )
	-- draw background's background first with fillmax, alpha / 2
	love.graphics.setColor( bgcolor[1], bgcolor[2], bgcolor[3], bgcolor[4]/2 )
	love.graphics.rectangle("fill", x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, FONT_HEIGHT)
	-- draw background's fill based on fillvalue/fillmax
	love.graphics.setColor( bgcolor )
	love.graphics.line(x*FONT_WIDTH, (y*FONT_HEIGHT)+(FONT_HEIGHT/2), (x*FONT_WIDTH)+((width*FONT_WIDTH)*(fillvalue/fillmax)), (y*FONT_HEIGHT)+(FONT_HEIGHT/2))

	-- draw foreground text
	love.graphics.setColor( fgcolor )
	love.graphics.printf(string.sub(text, 1, width), x*FONT_WIDTH, y*FONT_HEIGHT, width*FONT_WIDTH, 'left')

end -- drawText