local composer = require( "composer" )
--composer.recycleOnSceneChange = true

local screenW, screenH = display.contentWidth, display.contentHeight
local scene = composer.newScene()
local gameFuncoes = {}
local update = {}
local onMovePinguo = {}
local addCenario = {}
local addInicialBlocos = {}
local addPinguo = {}
local addLive = {}
local addInicialBlocos2 = {}
local addBloco = {}
local bloco 
local pinguo 
local scoreTF = 0
local live
local livesTF = 3
local lives
local alertScore 





-- "scene:create()"
function scene:create( event )
   
local physics = require("physics")
---local show = require("show")
    physics.start()
    --physics.setGravity(0,40,5)
     physics.setGravity(0,30)

    local sceneGroup = self.view  
--Runtime:addEventListener("enterFrame",show.make)
---funcao para dar o start tudao
    function startGame()
      addCenario()
    end

    function addCenario()
      local background = display.newImage("img/criff.png")
      background.width=screenW   *2
      background.height=screenH   * 2
      sceneGroup:insert(background)
      scoreTF = display.newText('0',303,22,system.nativeFont,22)
      scoreTF:setTextColor(0,0,0)
      livesTF = display.newText('x3',289,56,system.nativeFont,22)
      livesTF:setTextColor(0,0,0)
      local chao = display.newImage("img/chao.png")
      chao.y = screenW  * 1.8
      chao.x = 370
      chao.width = 1000    
      physics.addBody(chao, "static", {density=3.0, friction=1, bounce=0.5})
      sceneGroup:insert(chao)
     -- addInicialBlocos2('add')

     
      -->criar paredes

    local leftwall = display.newRect(0,0,1,display.contentHeight + 1800)
    sceneGroup:insert(leftwall)
    local rightwall = display.newRect(display.contentWidth,0,1,display.contentHeight + 1800)
    sceneGroup:insert(rightwall)
    local celling = display.newRect(170,0,display.contentWidth,3)
    sceneGroup:insert(celling)
    -->parece corpos fisicos
    physics.addBody(leftwall,"static",{bouce = 0.6})
    physics.addBody(rightwall,"static",{bouce = 0.1})
    physics.addBody(celling,"static",{bouce = 0.1})

    --funcao add inicial blocos que chama o add play
    addInicialBlocos(2)
    local pauseButton = display.newImage("img/pause.png")
      pauseButton.x = screenW * 0.92
      pauseButton.y = screenW /8
      pauseButton.width = 80
      pauseButton.height = 80
      sceneGroup:insert(pauseButton)

    local function goToMenu(event)
        print("back button has been pressed")
         showAlert()
        composer.gotoScene("menu", {effect = "fade"})
         gameFuncoes('rmv')

        return true
    end

    pauseButton:addEventListener("tap", goToMenu)

    end
    
 ---funcao temporaria para blocos nao dinamicos   
function addInicialBlocos2(action)
    if(action == 'add') then
        local bloco = display.newImage("img/bloco.png")
        bloco.height=100
        bloco.width = 150
        bloco.x = 70
        bloco.y = 1200
        physics.addBody(bloco, "static", {density=3.0, friction=5, bounce=2})
        sceneGroup:insert(bloco)

        local bloco2 = display.newImage("img/bloco.png")
        bloco2.height=100
        bloco2.width = 150
        bloco2.x = 250
        bloco2.y = 900
        physics.addBody(bloco2, "static", {density=3.0, friction=5, bounce=2})
        sceneGroup:insert(bloco2)


        local bloco3 = display.newImage("img/bloco.png")
        bloco3.height=100
        bloco3.width = 150
        bloco3.x = 700
        bloco3.y = 1000
        physics.addBody(bloco3, "static", {density=3.0, friction=5, bounce=1})
        sceneGroup:insert(bloco3)

    else 
       -- depois removeremoveEventListener(
    end
end
 


function addInicialBlocos(n)
    blocos = display.newGroup()
    for i = 1, n do
        local bloco = display.newImage('img/bloco.png')
        bloco.x = math.floor(math.random()*(display.contentWidth - bloco.width))
        bloco.y = (display.contentHeight*0.5) + math.floor(math.random()*(display.contentHeight*0.5))
        physics.addBody(bloco,{density = 1,bounce = 1})
        bloco.height=100
        bloco.width = 150
        bloco.bodyType = 'static'
        sceneGroup:insert(bloco)
        blocos:insert(bloco)
    end
    addPinguo()
end    
-- funcao add pinguo 
function addPinguo()
-->pinguo
    pinguo = display.newImage("img/pinguo.png")
    pinguo.width=80
    pinguo.height=80
    pinguo.x = screenW * 0.5
    pinguo.y = screenH /2 
    pinguo.isFixedRotation = true
    physics.addBody( pinguo,"dynamic", {density=3.0, friction=1, bounce=1})
    sceneGroup:insert(pinguo)
    gameFuncoes('add')
end
    
    

    




     
   

--------------------------<fucoesPinguo>------------------------------------




local function onMovePinguo( event )    
    frameUpdate = false 
    pinguo.x = screenW + (screenW * event.xGravity *3)

    if((pinguo.x - pinguo.width * 0.5) < 0) then
    pinguo.x = pinguo.width * 0.5
    elseif((pinguo.x + pinguo.width * 0.5) > display.contentWidth) then
        pinguo.x = display.contentWidth - pinguo.width * 0.5
    end

end
-----------------add blocos ---------------------------
function addBloco()
    local r = math.floor(math.random()*4)
    if(r ~= 0) then
        local bloco = display.newImage('img/bloco.png')
        bloco.x = math.random()*(display.contentWidth - (bloco.width * 1.5))
        bloco.y =math.random()* display.contentHeight - bloco.height
        --pinguo.x = screenW * 0.5
       -- pinguo.y = screenH /2 
       bloco.height=100
        bloco.width = 150
        physics.addBody(bloco ,"static",{density = 1, bounce = 0, friction="1"})
       -- blocos:insert(bloco)
        sceneGroup:insert(bloco)
        blocos:insert(bloco)
        sceneGroup:insert(blocos)
         print("inserindo  bloco")
    else
        local badbloco = display.newImage('img/bloco.png')
        badbloco.name = 'bad'
        physics.addBody(badbloco,{density = 1 ,bounce = 0})
        badbloco.bodyType = 'static'
        badbloco.x = math.random() * (display.contentWidth - (badbloco.width * 0.5))
        badbloco.y = display.contentHeight + badbloco.height

       -- blocos:insert(badbloco)
        
        blocos:insert(badbloco)
        sceneGroup:insert(badbloco)
        sceneGroup:insert(blocos)
        print("inserindo bad bloco")
    end
end
---blocoTimer =  timer.performWithDelay(800,addBloco,0)
system.setAccelerometerInterval(10)

--Runtime:addEventListener ("accelerometer", onMovePinguo);

function addLive()
  --   live = display.newImage('img/live.png')
  --   live.name = 'live'
  --   live.x = blocos[blocos.numChildren - 1].x
  --   live.y = blocos[blocos.numChildren - 1].y - live.height
  --  physics.addBody(live,{density = 1,friction = 0,bounce = 0})
  --  sceneGroup:insert(live)
  -- print("life")
end
-----------------

 function gameFuncoes(action)
    if(action == 'add') then
         Runtime:addEventListener('accelerometer',onMovePinguo)
         Runtime:addEventListener('enterFrame',update)
         blockTimer =  timer.performWithDelay(3000,addBloco,0)
        -- liveTimer = timer.performWithDelay(8000,addLive,0)
         pinguo:addEventListener('collision',collisionHandler)
    else
        print("else")
      Runtime:removeEventListener('accelerometer',onMovePinguo)
      Runtime:removeEventListener('enterFrame',update)
     -- timer.cancel(blockTimer)
     -- timer.cancel(liveTimer)
   -- blockTimer = nil
    --  liveTimer = nil
    --  pinguo:removeEventListener('collision',collisionHandler)

    end
end

function update(e)
    --pinguo Movement
   pinguo.y = pinguo.y - 0.7

    --Score
    
    --Lose lives
    -- if(pinguo.y > display.contentHeight or pinguo.y < -5) then
    --     pinguo.x = bloco[bloco.numChildren - 1].x
    --     pinguo.y = bloco[bloco.numChildren - 1].y - pinguo.height
    --     lives = lives - 1
    --     livesTF.text = 'x' .. lives
    -- end

    --Check for game over
   -- if(lives < 0) then
       -- showAlert()
 --   end

   
end

function collisionHandler(e)
    -- --Grab Lives
    -- if(e.other.name == 'live') then
        
    --     display.remove(e.other)
    --     e.other = nil
    --     lives = lives + 1
    --     print(lives)
    --     livesTF.text = 'x' .. lives
    --     print(lives)
    -- end
    -- --Bad bloco
    -- if(e.other.name == 'bad') then
    --     lives = lives - 1
    --     print(lives)
    --     livesTF.text = 'x' .. lives
    -- end
end

function  showAlert()
    gameFuncoes('rmv')
    local alert = display.newImage('img/alertBg.png',70,190)
    alertScore = display.newText(scoreTF.text .. '!',134,240,native.systemFontBold,30)
    livesTF.text = ''
    sceneGroup:insert(alert)
   
end





--local function onFrame()
 --   frameUpdate = true

--end
--frequencia bateria respostas

--Runtime:addEventListener ("enterFrame", onFrame);

--------------------te

---blocoTimer =  timer.performWithDelay(800,addBloco,0)
 startGame()   
-->fim create
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