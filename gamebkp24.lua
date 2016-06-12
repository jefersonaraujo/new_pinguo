local composer = require( "composer" )
local widget = require( "widget" )
--composer.recycleOnSceneChange = true

local screenW, screenH = display.contentWidth, display.contentHeight
local scene = composer.newScene()
local gameFuncoes = {}
local update = {}
local onMovePinguo = {}
local addCenario = {}
local addInicialBlocos = {}
local addPinguo = {}
local addtime = {}
local addInicialBlocos2 = {}
local addBloco = {}
local blocos 
local sheet1
local pinguo 
local timeTF
local scoreTF 
score = 0
local time --imagem obj
local timesTF = 3
local times = 120 --- temo
local alertScore 
local blocoDOWN = 0 
local bola
local worldGroup = display.newGroup()
local bloco
local Ax = 0
local Ay = 0
local blocos = display.newGroup()
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen
motionx = 0; -- Variable used to move character along x axis
speed = 4; -- Set Walking Speed
playerInAir = false; -- Set a boolean of whether our guy is in the air or not
somDeImpacto = audio.loadSound("music/jump.wav")
local largura = display.contentWidth;
local altura = display.contentHeight;
local bgHeight = screenH
local bgWidth = -600
local up

--somDeGameOver = audio.loadSound("sounds/destructe.mp3")
---som = audio.loadSound("sounds/3HAPPYSTAGE1.mp3")

---physics.setGravity( 0,9.8 )
---physics.setDrawMode("hybrid")
-- "scene:create()"

function scene:create( event )
   
local physics = require("physics")
    physics.start()
    ---------------------------------------------------------------------------------------------
  -- widget.newProgressView()
  ---------------------------------------------------------------------------------------------
  
  local newProgressView = widget.newProgressView {
    left = 30,
    top = 400,
    width = 300,
    isAnimated = true,
    inicial= 40
  }

  newProgressView.x= 150
  newProgressView.y= 140


  local currentProgress = 0.0
  local currentProgress2 = 0.0
  local function increaseProgressView()
    currentProgress = currentProgress + 0.02 
    
    newProgressView:setProgress( currentProgress )
  end
  timer.performWithDelay( 100, increaseProgressView, 50 )

---------------------------------------------------------------
    

    local sceneGroup = self.view  
--Runtime:addEventListener("enterFrame",show.make)
---funcao para dar o start tudao
    function startGame()
      addCenario()
    end

    function addCenario()
     -- local background = display.newImage("img/criff.png")
    --  background.width=screenW   *2
    --  background.height=screenH   * 2
     -- sceneGroup:insert(background)
       -- >> Criação do  Background<< --


local background = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
---background.anchorX = 0
---background.anchorY = 0
-- background.y = display.contentCenterY + bgHeight
-- --background.x = display.contentCenterX
 background.width=screenW   *2
 background.height=screenH   * 2
-- sceneGroup:insert(background)
-- local background1 = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
-- background1.anchorX = 0
-- background1.anchorY = 0
-- background1.y = background.y + bgHeight
-- --background1.x = display.contentCenterX 
-- background1.width=screenW   *2
-- background1.height=screenH   * 2
-- sceneGroup:insert(background1)

-- local background2 = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
-- background2.anchorX = 0
-- background2.anchorY = 0
-- background2.y = background1.y + bgHeight
-- --background2.x = display.contentCenterX
-- background2.width=screenW   *2
-- background2.height=screenH   * 2
sceneGroup:insert(background)

local velocidadeBg = 0.8

 function scrollSky(event)
 --  ---Ax = Ax -1
 --  background.y = background.y + velocidadeBg
 --  background1.y = background1.y + velocidadeBg
 --  background2.y = background2.y + velocidadeBg

 
 --  -- blocos[blocos.numChildren - 1].y = blocos[blocos.numChildren - 1].y + 0.5
 --  -- blocos[blocos.numChildren - 2].y = blocos[blocos.numChildren - 2].y + 0.5
 --  -- blocos[blocos.numChildren - 3].y = blocos[blocos.numChildren - 3].y + 0.5
 --  -- blocos[blocos.numChildren - 4].y = blocos[blocos.numChildren - 4].y + 0.5
 --  -- --blocos[blocos.numChildren - 5].y = blocos[blocos.numChildren - 5].y + 0.5

 -- -- print(bloco[bloco.numChildren - 1].y)
 --  if (background.y - bgHeight) > altura then
 --    background:translate(0, -bgHeight*3)

 --  end

 --  if (background1.y - bgHeight) > altura then
 --    background1:translate(0, -bgHeight*3)
 --  end

 --  if (background2.y - bgHeight) > altura then
 --    background2:translate(0, -bgHeight*3)
 --  end
 end
  

function toque(evt)
  -- if evt.phase == "began" then
  --   velocidadeBg = 12
  -- end

  -- if evt.phase == "ended" then
  --   velocidadeBg = 1
  -- end
end


--scrollSky() --teste
--Runtime:addEventListener("enterFrame", scrollSky)
Runtime:addEventListener("touch", toque)




      scoreTF = display.newText('0',303,22,system.nativeFont,30)
      scoreTF:setTextColor(0,0,0)
        

      timeTF = display.newText('0',150,22,system.nativeFont,30)
      timeTF:setTextColor(0,0,0) 


      local chao = display.newImage("img/chao.png")
      chao.y = screenW  * 1.8
      chao.x = 370
      chao.width = 1000    
      physics.addBody(chao, "static", {density=1, friction=0.3, bounce=0.3})
      sceneGroup:insert(chao)
     -- addInicialBlocos2('add')


-------- chao colicao 
 local colisaobloco = display.newRect(300,1400,display.contentWidth,3)
 colisaobloco:setFillColor( 0.5 )
 colisaobloco.name="removebloco"
     
      -->criar paredes

    local leftwall = display.newRect(0,0,1,display.contentHeight + 1800)
    sceneGroup:insert(leftwall)
    local rightwall = display.newRect(display.contentWidth,0,1,display.contentHeight + 1800)
    sceneGroup:insert(rightwall)
   --- local celling = display.newRect(170,0,display.contentWidth,3)
    --sceneGroup:insert(celling)
    -->parece corpos fisicos
    physics.addBody(leftwall,"static",{bouce = 0.6})
    physics.addBody(rightwall,"static",{bouce = 0.1})
   -- physics.addBody(celling,"static",{bouce = 0.1})

    --funcao add inicial blocos que chama o add play
    addInicialBlocos(0)
   -- addInicialBlocos2('add')
    -- local pauseButton = display.newImage("img/pause.png")
    --   pauseButton.x = screenW * 0.92
    --   pauseButton.y = screenW /8
    --   pauseButton.width = 80
    --   pauseButton.height = 80
    --   sceneGroup:insert(pauseButton)

    local function goToMenu(event)
        print("back button has been pressed")
         showAlert()
        composer.gotoScene("menu", {effect = "fade"})
         gameFuncoes('rmv')

        return true
    end

  ---  pauseButton:addEventListener("tap", goToMenu)

    end
    
 ---funcao temporaria para blocos nao dinamicos   



function addInicialBlocos(n)
   -- blocos = display.newGroup()
    for i = 1, n do
        local bloco = display.newImage('img/bloco.png')
        bloco.x = math.floor(math.random()*(display.contentWidth - bloco.width))
        bloco.y = (display.contentHeight*0.5) + math.floor(math.random()*(display.contentHeight*0.5))
        physics.addBody(bloco,{density = 1,bounce = 0.3})
         bloco.collType = "passar"
        bloco.name = "blocos"

        bloco.height=90
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

--pinguo = display.newImageRect( worldGroup, "img/pp.png", 100, 90 )
---sheet1 = graphics.newImageSheet( "img/pp1.png", { width=180, height=85, numFrames=3})
   -- pinguo = display.newImage( "imagens/p5.png" )
   -- pinguo.height = 90
   -- pinguo.width = 90

  sheet1 = graphics.newImageSheet( "imagens/sprite.png", { width=90, height=90, numFrames=4})
    pinguo = display.newSprite(sheet1,{name="man", start=1, count=4, time=600,loopCount=1} )
  pinguo.x = largura /2
  pinguo.y = 0
  
   physics.addBody( pinguo,  {  bounce=0.2, friction=0.3} )
   pinguo.x = 600 ; pinguo.y = 200
   pinguo.isFixedRotation = true
   pinguo.alpha = 0.7
   pinguo:setLinearVelocity( 120,0 )
   sceneGroup:insert(pinguo)
   gameFuncoes('add')

  pinguo.myName="pinguo"
  return pinguo




end
    
    
--bfxr
----------------------------------------------------------------------------------------
--BOTOES
-- Add left joystick button
local left = display.newImage ("imagens/seta.png")
---sceneGroup:insert(left)
  left.x = 45; left.y = 280;
  left.rotation = 180;

-- Add right joystick button
local right = display.newImage ("imagens/seta.png")
--sceneGroup:insert(right)
  right.x = 120; right.y = 282;

-- Add Jump button
local up = display.newImage ("imagens/btn_arrow.png")
--sceneGroup:insert(up)
  up.x = 440; up.y = 280;
  up.rotation = 270;

-- End Graphic Elements
--*****************
  
  
--******************
-- Add Game Functionality
  
-- Stop character movement when no arrow is pushed
local function stop (event)
  if event.phase =="ended" then
    motionx = 0;
  end   
end
Runtime:addEventListener("touch", stop )

-- Move character
local function movepinguo (event)
  pinguo.x = pinguo.x + motionx;  
end
Runtime:addEventListener("enterFrame", movepinguo)

-- When left arrow is touched, move character left
function left:touch()
  pinguo.xScale = -1 
  motionx = -speed;
end
left:addEventListener("touch",left)

-- When right arrow is touched, move character right
function right:touch()
  pinguo.xScale = 1 
  motionx = speed;
end
right:addEventListener("touch",right)

-- Make character jump
function up:touch(event)
  if(event.phase == "began") then
    print("UPPPPPPPPPP")
    playerInAir = true
    pinguo:setLinearVelocity( 0, -200 )
    print(playerInAir)
  end
end
up:addEventListener("touch",up)

-- Detect whether the player is in the air or not
function onCollision( event )
  if(event.object1.myName == "blocos" ) then ---and event.object2.myName == "pinguo") then
    event.object1:removeSelf()
    event.object1.myName=nil
    print("onCollision")
    pinguo:play()
   ---DESCER()
  end
end
Runtime:addEventListener( "collision", onCollision )
 

     
 function onTime()
  times = times  - 00.1
  timeTF.text = times
end  

function onScore()
  score = score  + 10
  scoreTF.text = score
end  


--------------------------<fucoesPinguo>------------------------------------
-- Create blocos
local function createbloco( x, y )

  bloco = display.newImageRect( worldGroup, "img/bloco.png", 150, 90 )
  physics.addBody( bloco, "static", { bounce=0.3, friction=0.3 } )
  bloco.collType = "passar"
  bloco.x, bloco.y = x, y
  bloco.name = "blocos"
  bloco.myName="block"
  blocos:insert(bloco)
  sceneGroup:insert(bloco)
  --bloco:toBack()
end

-- function addBloco()
--     local r = math.floor(math.random()*4)
--     if(r ~= 0) then
--         local bloco = display.newImage('img/bloco.png')
--         bloco.x = math.random()*(display.contentWidth - (bloco.width * 1.5))
--         bloco.y =math.random()* display.contentHeight - bloco.height
--         bloco.collType = "passar"
--         --pinguo.x = screenW * 0.5
--        -- pinguo.y = screenH /2 
--        bloco.height=90
--         bloco.width = 150
--         physics.addBody(bloco ,"static",{bounce = 0.3, friction="0.3"})
--         --blocos:insert(bloco)
--         sceneGroup:insert(bloco)
--         blocos:insert(bloco)
--         sceneGroup:insert(blocos)
--          print("inserindo  bloco")
--     else
--         local badbloco = display.newImage('img/bloco.png')
--         badbloco.name = 'bad'
--         physics.addBody(badbloco,{density = 1 ,bounce = 0})
--         badbloco.bodyType = 'static'
--         badbloco.x = math.random() * (display.contentWidth - (badbloco.width * 0.5))
--         badbloco.y = display.contentHeight + badbloco.height

--        -- blocos:insert(badbloco)
        
--         blocos:insert(badbloco)
--         sceneGroup:insert(badbloco)
--         sceneGroup:insert(blocos)
--         print("inserindo bad bloco")
--     end
-- end


 createbloco( 60, 840)
createbloco( 260, 940)
 createbloco( 500, 920 )
 createbloco( 170, 1000)
 createbloco( 400, 300)
 createbloco( 120, 680)
createbloco( 360, 700)
 createbloco( 760, 500 )
-- createbloco( 60, 840)
-- createbloco( 260, 940)
-- createbloco( 500, 920 )
-- createbloco( 170, 1120)
-- createbloco( 390, 120)

local function movimentaBolaD(self,event)
    if self.x < 0 then
      self.x = 630
  end
  if self.x > 630 then
      self.x = 0
  end
end



-->pre colisao pinguo
local function localPreCollision( self, event )

  if ("passar" == event.other.collType) then
          --event.object1:removeSelf()
        --  event.object1.myName=nil
     --- Runtime:addEventListener('enterFrame',DESCER)
    
    --  Ax = Ax + 5
    -- print(Ax)
   -- transition.to(blocos, {y=Ax, time=200})

 
      

    --- DESCER()
    --  audio.play(somDeImpacto)

   
    if ( self.y+(self.height*0.5) > event.other.y-(event.other.height*0.5)+0.2 ) then

      if event.contact then
         pinguo:play()
        event.contact.isEnabled = false
      end
    end
  end
 --- Runtime:removeEventListener('enterFrame',DESCER)
  return true
end

-- -- função remove
-- local function colisao(event)
--      if(event.phase == "began")then
--       event.object1:removeSelf()
--           event.object1.myName=nil
--         Ax = Ax + 5
--        print(Ax)
--        transition.to(blocos, {y=Ax, time=200})
--        audio.play(somDeImpacto)-- chamar o som pre carregado
--      --bola:prepare("walk")
--      bola:play()
--          score=score+50
--      updateTexto()
--    end
-- end


local function onMovePinguo( event )    
    frameUpdate = false 
    pinguo.x = screenW + (screenW * event.xGravity *3)

    if((pinguo.x - pinguo.width * 0.5) < 0) then
    pinguo.x = pinguo.width * 0.5
    elseif((pinguo.x + pinguo.width * 0.5) > display.contentWidth) then
        pinguo.x = display.contentWidth - pinguo.width * 0.5
    end

end



system.setAccelerometerInterval(10)



function addtime()
    time = display.newImage('img/live.png')

   time.name = 'time'
    local blocoRandom=math.random(4) 
    time.x = blocos[blocos.numChildren - blocoRandom].x 
    time.y = blocos[blocos.numChildren - blocoRandom].y - time.height
  physics.addBody(time,{density = 1,friction = 0,bounce = 0})
   sceneGroup:insert(time)
 print("time")

end

function addUp()
    up = display.newImage('img/lo.png')
    up.name = 'up'
    local blocoRandom=math.random(4) 
    up.x = blocos[blocos.numChildren - blocoRandom].x 
    up.y = blocos[blocos.numChildren - blocoRandom].y - up.height
  physics.addBody(up,{density = 1,friction = 0,bounce = 0})
   sceneGroup:insert(up)
 print("up")

end

-----------------
 function gameFuncoes(action)
    if(action == 'add') then
         Runtime:addEventListener('accelerometer',onMovePinguo)
         pinguo.preCollision = localPreCollision
         pinguo:addEventListener( "preCollision", pinguo )
         Runtime:addEventListener('enterFrame',onJump)
         
         blockTimer =  timer.performWithDelay(800, addBloco,0)
         timeTimer = timer.performWithDelay(8000,addtime,0)
         upTimer = timer.performWithDelay(8000,addUp,0)
         pinguo:addEventListener('collision',collisionHandler)
         pinguo.enterFrame = movimentaBolaD
         Runtime:addEventListener("enterFrame", pinguo)
    else
        print("else")
        Runtime:removeEventListener('accelerometer',onMovePinguo)
        pinguo:removeEventListener( "preCollision", pinguo )
        Runtime:removeEventListener('enterFrame',onJump)
        Runtime:removeEventListener('collision',onCollision)
       -- timer.cancel(addUp)
       -- timer.cancel(addtime)
       -- blockTimer = nil
        timeTimer = nil
        upTimer= nil
        pinguo:removeEventListener('collision',collisionHandler)

    end
end

function onJump(e)
    --pinguo Movement

    onTime()

   pinguo.y = pinguo.y - 4

   

   if(times < 0.1) then
        showAlert()
   end

   
end

function collisionHandler(e)
    -- --Grab times
    if(e.other.name == 'time') then
        
        display.remove(e.other)
        e.other = nil
        times = times + 100
        --score = score + 10
        
    
    elseif(e.other.name == 'up') then
        
        display.remove(e.other)
        e.other = nil
        onScore()  

    


        
    end


local function colisao(event)
  --   if(event.phase == "began")then
        if((event.object1.myName=="block" and event.object2.myName=="pinguo")
         or(event.object1.myName=="pinguo" and event.object2.myName=="block"))then
          --- event.object1:removeSelf()
          ---  event.object1.myName=nil
            Ax = Ax + 5
            print(Ax)
           --- worldHeight = loader:getWorldBoundariesRect().size.height
            --print( ... )
            --blocos.y = -worldHeight + Ax
           transition.to(blocos, {y=Ax, time=200}) 

           ---moveTo
         end
      --end
end

 Runtime:addEventListener("collision", colisao)
----usar o progress view

    -- if(e.other.name == 'blocos') then
        
    --    -- blocos[blocos.numChildren - 1].y = blocos[blocos.numChildren - 1].y + 0.9
    --    -- blocos[blocos.numChildren - 2].y = blocos[blocos.numChildren - 2].y + 0.9
    --    -- blocos[blocos.numChildren - 3].y = blocos[blocos.numChildren - 3].y + 0.9
    --    -- blocos[blocos.numChildren - 4].y = blocos[blocos.numChildren - 4].y + 0.9
       
        
    -- end

    --Score
    
    --Lose times
    -- if(pinguo.y > display.contentHeight or pinguo.y < -5) then
    --     pinguo.x = bloco[bloco.numChildren - 1].x
    --     pinguo.y = bloco[bloco.numChildren - 1].y - pinguo.height
    --     times = times - 1
    --     timesTF.text = 'x' .. times
    -- end

    --Check for game over


    --Bad bloco
    -- if(e.other.name == 'bad') then
    --     -- times = times - 1
    --     -- print(times)
    --     -- timesTF.text = 'x' .. times

    --     print("BAD BLOCO")
    -- end
end

function  showAlert()
    composer.gotoScene( "gameOver", {effect = "fade"} )
    gameFuncoes('rmv')
    --local alert = display.newImage('img/alertBg.png',600,490)
   -- alertScore = display.newText(scoreTF.text .. '!',600,490,native.systemFontBold,30)
    --timesTF = display.newText('x3',289,56,system.nativeFont,30)
   -- alertScore:setTextColor(0,0,0)  
    --sceneGroup:insert(alert)
   -- sceneGroup:insert(alertScore)
    


   
end






 startGame()   

end



-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come atime.
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