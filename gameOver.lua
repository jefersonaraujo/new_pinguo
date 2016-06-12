----local   background_menu   =  display.newImageRect ("img/criff.png" , screenW * 2 , screenH * 2) 

local screenW, screenH = display.contentWidth, display.contentHeight
local composer = require( "composer" )
--local show = require("show")
--Runtime:addEventListener("enterFrame",show.make)
local scene = composer.newScene()

local scoreTF 


local alertScore 

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


print("this is the menu file")
-- "scene:create()"
function scene:create(event)

    local sceneGroup = self.view

    local background_menu = display.newImageRect("img/criff.png", screenW *2 , screenH * 2)    
    sceneGroup:insert(background_menu)

    local asphaltstitcherlogo = display.newText("Pinguo", screenW /2 , screenH / 3 , native.systemFont, 60)
    asphaltstitcherlogo:setFillColor(0,0,0)
    sceneGroup:insert(asphaltstitcherlogo)

    local placa_menu = display.newImage("img/placa.png")
    placa_menu.width=700
    placa_menu.height=900
    placa_menu.x = 370
    placa_menu.y = screenH * 0.7

   
    sceneGroup:insert(placa_menu)


    local startButton = display.newImage("img/go.png")
    startButton.width=150
    startButton.height=100
    startButton.x = 450
    startButton.y = 900
    sceneGroup:insert(startButton)


    local backButton = display.newImage("img/back.png", 250, 900)
    backButton.height = 100
    backButton.width =150
    sceneGroup:insert(backButton)

    ---local alert = display.newImage('img/alertBg.png',600,490)
     local scoreTF = display.newText('0',303,22,system.nativeFont,30)
      scoreTF.text = score
    alertScore = display.newText("Sua Pontuação Foi \n ".. scoreTF.text .. '!',350,780,"Snow For Santa",40)
    --timesTF = display.newText('x3',289,56,system.nativeFont,30)
    alertScore:setTextColor(0,0,0)  
    --sceneGroup:insert(alert)
   sceneGroup:insert(alertScore)
  



    local function goToStartGame(event)
        print("start button has been tapped")
        composer.gotoScene( "game", {effect = "fade"} )
        return true
    end
    startButton:addEventListener("tap", goToStartGame)

    local function goToOptions(event)
        print("options button has been tapped")
        composer.gotoScene("menu", {effect = "fade"})
        return true
    end
    backButton:addEventListener("tap", goToOptions)

     

    
    

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene