-- all the different inputs for each scene, in functions

-- local data here

	local colorList = {
		[1] = "red",
		[2] = "green",
		[3] = "yellow",
		[4] = "blue",
		[5] = "magenta",
		[6] = "cyan",
		[7] = "dark grey",
		[8] = "grey",
		[9] = "bright red",
		[10] = "bright green",
		[11] = "bright yellow",
		[12] = "bright blue",
		[13] = "bright magenta",
		[14] = "bright cyan",
		[15] = "white",
	}

	local selectedColor = 1

	local redvalue = 0
	local greenvalue = 0
	local bluevalue = 0

function settingsLoad()
	-- all the one-time things that need to load for title scene
end -- titleLoad()


function settingsInput()
	-- this scene's input mapping
	function love.keypressed(key, scancode, isrepeat)
		if key == "return" then
			fullscreen = not fullscreen
			love.window.setFullscreen(fullscreen, "exclusive")
		end

		if key == "escape" then
			love.event.quit()
		end

		-- for testing HP bars
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

		-- for switching scenes
		if key == "1" then
			game.scene = "title"
			titleInput()
			titleRun()
		end
		if key == "2" then
			game.scene = "settings"
			settingsInput()
			settingsRun()
		end
		if key == "3" then
			game.scene = "credits"
			creditsInput()
			creditsRun()
		end
		if key == "4" then
			game.scene = "quit"
			quitInput()
			quitRun()
		end

		-- for testing Scroll List
		if key == "up" and (selectedColor-1) ~= 0 then -- don't go below 1
			selectedColor = selectedColor - 1
		end
		if key == "down" and selectedColor < #colorList then -- don't past last item
			selectedColor = selectedColor + 1
		end
	end
end -- titleInput

function settingsRun()
	-- anything to run on scene load
end -- titleRun

function settingsUpdate()
	-- this scene's updates
	
	-- set colorvalues according to selected color	
	if selectedColor == 1 then
		redvalue = color.red[1]
		greenvalue = color.red[2]
		bluevalue = color.red[3]
	elseif selectedColor == 2 then
		redvalue = color.green[1]
		greenvalue = color.green[2]
		bluevalue = color.green[3]
	elseif selectedColor == 3 then
		redvalue = color.yellow[1]
		greenvalue = color.yellow[2]
		bluevalue = color.yellow[3]
	elseif selectedColor == 4 then
		redvalue = color.blue[1]
		greenvalue = color.blue[2]
		bluevalue = color.blue[3]
	elseif selectedColor == 5 then
		redvalue = color.magenta[1]
		greenvalue = color.magenta[2]
		bluevalue = color.magenta[3]
	elseif selectedColor == 6 then
		redvalue = color.cyan[1]
		greenvalue = color.cyan[2]
		bluevalue = color.cyan[3]
	elseif selectedColor == 7 then
		redvalue = color.darkgrey[1]
		greenvalue = color.darkgrey[2]
		bluevalue = color.darkgrey[3]
	elseif selectedColor == 8 then
		redvalue = color.grey[1]
		greenvalue = color.grey[2]
		bluevalue = color.grey[3]
	elseif selectedColor == 9 then
		redvalue = color.brightred[1]
		greenvalue = color.brightred[2]
		bluevalue = color.brightred[3]
	elseif selectedColor == 10 then
		redvalue = color.brightgreen[1]
		greenvalue = color.brightgreen[2]
		bluevalue = color.brightgreen[3]
	elseif selectedColor == 11 then
		redvalue = color.brightyellow[1]
		greenvalue = color.brightyellow[2]
		bluevalue = color.brightyellow[3]
	elseif selectedColor == 12 then
		redvalue = color.brightblue[1]
		greenvalue = color.brightblue[2]
		bluevalue = color.brightblue[3]
	elseif selectedColor == 13 then
		redvalue = color.brightmagenta[1]
		greenvalue = color.brightmagenta[2]
		bluevalue = color.brightmagenta[3]
	elseif selectedColor == 14 then
		redvalue = color.brightcyan[1]
		greenvalue = color.brightcyan[2]
		bluevalue = color.brightcyan[3]
	elseif selectedColor == 15 then
		redvalue = color.white[1]
		greenvalue = color.white[2]
		bluevalue = color.white[3]
	end
	
	
end -- titleUpdate

function settingsDraw()
	-- this scene's draws

	-- fill full window with background color
	love.graphics.setColor( color.darkgrey )
	love.graphics.rectangle("fill", 0, 0, width, height)

	local text = "\nSETTINGS SCENE\n\nThis is the settings scene. Lots of knobs and dials here.\n"
	drawTextBox(text, 0, 0, 40, 6, color.brightmagenta, color.blue, "center")

	-- drawScrollList(title, list, options, selected, x, y, width, framecolor, bgcolor)
	drawScrollList("", colorList, "[UP/DOWN] Select color ", selectedColor, 25, 10, 20, color.brightblue, color.blue)

	drawTextBox("", 25, 17, 34, 3, color.white, color.black, "left")
	drawText("[Q/W] adjust red",   25, 17, 34, color.white, color.red, redvalue, 1)
	drawText("[A/S] adjust green", 25, 18, 34, color.white, color.green, greenvalue, 1)
	drawText("[Z/X] adjust blue",  25, 19, 34, color.white, color.blue, bluevalue, 1)


	-- display all text colors
	-- drawTextColor(text, x, y, width, bgcolor) test
	drawTextColor(" ^Rred ", 			65, 10, 20, color.black)
	drawTextColor(" ^Ggreen ", 			65, 11, 20, color.black)
	drawTextColor(" ^Yyellow ", 		65, 12, 20, color.black)
	drawTextColor(" ^Bblue ", 			65, 13, 20, color.black)
	drawTextColor(" ^Pmagenta ", 		65, 14, 20, color.black)
	drawTextColor(" ^Ccyan ", 			65, 15, 20, color.black)
	drawTextColor(" ^Wdark grey ", 		65, 16, 20, color.black)
	drawTextColor(" ^rbright red ", 	65, 17, 20, color.black)
	drawTextColor(" ^gbright green ", 	65, 18, 20, color.black)
	drawTextColor(" ^ybright yellow ", 	65, 19, 20, color.black)
	drawTextColor(" ^bbright blue ", 	65, 20, 20, color.black)
	drawTextColor(" ^pbright magenta ", 65, 21, 20, color.black)
	drawTextColor(" ^cbright cyan ", 	65, 22, 20, color.black)
	drawTextColor(" ^wwhite ", 			65, 23, 20, color.black)

end -- titleDraw