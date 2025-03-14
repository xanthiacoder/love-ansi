-- all the different inputs for each scene, in functions

-- local data here


function quitLoad()
	-- all the one-time things that need to load for title scene
end -- titleLoad()


function quitInput()
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
		if key == "up" and (game.list.selected-1) ~= 0 then -- don't go below 1
			game.list.selected = game.list.selected - 1
		end
		if key == "down" and game.list.selected < game.list.lastItem then -- don't past last item
			game.list.selected = game.list.selected + 1
		end
	end
end -- titleInput

function quitRun()
	-- anything to run on scene load
end -- titleRun

function quitUpdate()
	-- this scene's updates
	
end -- titleUpdate

function quitDraw()
	-- this scene's draws

	-- fill full window with background color
	love.graphics.setColor( color.darkgrey )
	love.graphics.rectangle("fill", 0, 0, width, height)

	local text = "\nQUIT SCENE\n\nThis is the quit scene. Hope you come back soon!\n"
	drawTextBox(text, 20, 10, 40, 6, color.brightred, color.blue, "center")

end -- titleDraw