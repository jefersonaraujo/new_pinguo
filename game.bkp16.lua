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
local blocos 
local sheet1
local pinguo 
local scoreTF 
local score = 0 
local live
local livesTF = 3
local lives
local alertScore 
local blocoDOWN = 0 
local bola
local worldGroup = display.newGroup()
local bloco
local Ax = 0
local Ay = 0
local blocos = display.newGroup()

somDeImpacto = audio.loadSound("music/jump.wav")
--somDeGameOver = audio.loadSound("sounds/destructe.mp3")
---som = audio.loadSound("sounds/3HAPPYSTAGE1.mp3")
physics.setGravity( 0,9.8 )

 physics.setDrawMode("normal")
-- "scene:create()"
function scene:create( event )
   
local physics = require("physics")
---local show = require("show")
    physics.start()
    --physics.setGravity(0,40,5)
    --- physics.setGravity(0,30)

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
local largura = display.contentWidth;
local altura = display.contentHeight;
local bgHeight = screenH
local bgWidth = -600

local background = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
background.anchorX = 0
background.anchorY = 0
background.y = display.contentCenterY + bgHeight
--background.x = display.contentCenterX
background.width=screenW   *2
background.height=screenH   * 2
sceneGroup:insert(background)
local background1 = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
background1.anchorX = 0
background1.anchorY = 0
background1.y = background.y + bgHeight
--background1.x = display.contentCenterX 
background1.width=screenW   *2
background1.height=screenH   * 2
sceneGroup:insert(background1)

local background2 = display.newImageRect('Imagens/bgplay4.png', largura, bgHeight)
background2.anchorX = 0
background2.anchorY = 0
background2.y = background1.y + bgHeight
--background2.x = display.contentCenterX
background2.width=screenW   *2
background2.height=screenH   * 2
sceneGroup:insert(background2)

local velocidadeBg = 0.8

 function scrollSky(event)
  Ax = Ax -1
  background.y = background.y + velocidadeBg
  background1.y = background1.y + velocidadeBg
  background2.y = background2.y + velocidadeBg

 
  blocos[blocos.numChildren - 1].y = blocos[blocos.numChildren - 1].y + 0.5
  blocos[blocos.numChildren - 2].y = blocos[blocos.numChildren - 2].y + 0.5
  blocos[blocos.numChildren - 3].y = blocos[blocos.numChildren - 3].y + 0.5
  blocos[blocos.numChildren - 4].y = blocos[blocos.numChildren - 4].y + 0.5
  --blocos[blocos.numChildren - 5].y = blocos[blocos.numChildren - 5].y + 0.5

 -- print(bloco[bloco.numChildren - 1].y)
  if (background.y - bgHeight) > altura then
    background:translate(0, -bgHeight*3)

  end

  if (background1.y - bgHeight) > altura then
    background1:translate(0, -bgHeight*3)
  end

  if (background2.y - bgHeight) > altura then
    background2:translate(0, -bgHeight*3)
  end
 end
  

function toque(evt)
  -- if evt.phase == "began" then
  --   velocidadeBg = 12
  -- end

  -- if evt.phase == "ended" then
  --   velocidadeBg = 1
  -- end
end


scrollSky() --teste
--Runtime:addEventListener("enterFrame", scrollSky)
Runtime:addEventListener("touch", toque)




      scoreTF = display.newText('0',303,22,system.nativeFont,30)
      scoreTF:setTextColor(0,0,0)
      livesTF = display.newText('x3',289,56,system.nativeFont,30)
      livesTF:setTextColor(0,0,0)
      local chao = display.newImage("img/chao.png")
      chao.y = screenW  * 1.8
      chao.x = 370
      chao.width = 1000    
      physics.addBody(chao, "static", {density=1, friction=0.3, bounce=0.3})
      sceneGroup:insert(chao)
     -- addInicialBlocos2('add')

     
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
        bloco.y = 1200 - blocoDOWN
        physics.addBody(bloco, "static", {density=1, friction=0.3, bounce=0.3})
        sceneGroup:insert(bloco)

        local bloco2 = display.newImage("img/bloco.png")
        bloco2.height=100
        bloco2.width = 150
        bloco2.x = 250
        bloco2.y = 900 - blocoDOWN
        physics.addBody(bloco2, "static", {density=1, friction=0.3, bounce=0.3})
        sceneGroup:insert(bloco2)


        local bloco3 = display.newImage("img/bloco.png")
        bloco3.height=100
        bloco3.width = 150
        bloco3.x = 700
        bloco3.y = 1000 - blocoDOWN
        physics.addBody(bloco3, "static", {density=1, friction=0.3, bounce=0.3})
        sceneGroup:insert(bloco3)

    else 
       -- depois removeremoveEventListener(
    end
end
 


function addInicialBlocos(n)
   -- blocos = display.newGroup()
    for i = 1, n do
        local bloco = display.newImage('img/bloco.png')
        bloco.x = math.floor(math.random()*(display.contentWidth - bloco.width))
        bloco.y = (display.contentHeight*0.5) + math.floor(math.random()*(display.contentHeight*0.5))
        physics.addBody(bloco,{density = 1,bounce = 0.3})
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
    -- pinguo = display.newImage("img/pinguo.png")
    -- pinguo.width=80
    -- pinguo.height=80
    -- pinguo.x = screenW * 0.5
    -- pinguo.y = screenH /2 
    -- pinguo.isFixedRotation = true
    -- physics.addBody( pinguo,"dynamic", {density=1, friction=0.3, bounce=0.3})

    -- Create ball (pinguoacter)
--pinguo = display.newImageRect( worldGroup, "img/pp.png", 100, 90 )
---sheet1 = graphics.newImageSheet( "img/pp1.png", { width=180, height=85, numFrames=3})
 pinguo = display.newImage( "img/pp1.png" )
 pinguo.height = 90
 pinguo.width = 90


physics.addBody( pinguo,  {  bounce=0.3, friction=0.3} )
 pinguo.x = 600 ; pinguo.y = 200
--pinguo.rotation = 360

--pinguo.rotation = 180
pinguo.isFixedRotation = true
pinguo.alpha = 0.7
pinguo:setLinearVelocity( 120,0 )
---pinguo.angularVelocity = 160
    sceneGroup:insert(pinguo)
    gameFuncoes('add')
end
    
    
_W = display.contentWidth; -- Get the width of the screen
_H = display.contentHeight; -- Get the height of the screen
motionx = 0; -- Variable used to move character along x axis
speed = 4; -- Set Walking Speed
playerInAir = false; -- Set a boolean of whether our guy is in the air or not
----------------------------------------------------------------------------------------
-- Add left joystick button
local left = display.newImage ("imagens/btn_arrow.png")
  left.x = 45; left.y = 280;
  left.rotation = 180;

-- Add right joystick button
local right = display.newImage ("imagens/btn_arrow.png")
  right.x = 120; right.y = 282;

-- Add Jump button
local up = display.newImage ("imagens/btn_arrow.png")
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
  if(event.object1.myName == "grass" and event.object2.myName == "pinguo") then
    playerInAir = false;
  end
end
Runtime:addEventListener( "collision", onCollision )
 

     
   

--------------------------<fucoesPinguo>------------------------------------
-- Create blocos
local function createbloco( x, y )

  bloco = display.newImageRect( worldGroup, "img/bloco.png", 150, 90 )
  physics.addBody( bloco, "static", { bounce=0.3, friction=0.3 } )
  bloco.collType = "passthrough"
  bloco.x, bloco.y = x, y

  blocos:insert(bloco)
  ---sceneGroup:insert(background)
  bloco:toBack()
end



createbloco( 40, 820)
createbloco( 260, 920)
createbloco( 480, 900 )
createbloco( 150, 1100)
createbloco( 370, 1200)

 function DESCER(event)
--  Ax = Ax + 20
--  Ay = Ay + 100
--  print (Ay)
-- createbloco( 40  , 820 + Ay)
-- createbloco( 260, 920 + Ay)
-- createbloco( 480, 900 + Ay)
-- createbloco( 150, 1100 + Ay)
-- createbloco( 370, 1200 + Ay )



 if ( "passthrough" == event.other.collType ) then
    
      print( "COLISAO BLOCO" )
  -- blocos[blocos.numChildren - 1].y = blocos[blocos.numChildren - 1].y + 0.9
  -- blocos[blocos.numChildren - 2].y = blocos[blocos.numChildren - 2].y + 0.9
  -- blocos[blocos.numChildren - 3].y = blocos[blocos.numChildren - 3].y + 0.9
  -- blocos[blocos.numChildren - 4].y = blocos[blocos.numChildren - 4].y + 0.9
end

 
end


local function localPreCollision( self, event )

  if ( "passthrough" == event.other.collType ) then
  
      print( "COLISAO BLOCO" )
      audio.play(somDeImpacto)
      local teste2=blocos[blocos.numChildren - 1].y 
      teste2= teste2 + 0.9
  print(teste2)
  blocos[blocos.numChildren - 2].y = blocos[blocos.numChildren - 2].y + 0.9
  blocos[blocos.numChildren - 3].y = blocos[blocos.numChildren - 3].y + 0.9
  blocos[blocos.numChildren - 4].y = blocos[blocos.numChildren - 4].y + 0.9
    -- Compare Y position of pinguoacter "base" to bloco top
    -- A slight increase (0.2) is added to account for collision location inconsistency
    -- If collision position is greater than bloco top, void/disable the specific collision
    if ( self.y+(self.height*0.5) > event.other.y-(event.other.height*0.5)+0.2 ) then

      if event.contact then
         
        event.contact.isEnabled = false
      end
    end
  end
  return true
end




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

system.setAccelerometerInterval(10)



function addLive()
    live = display.newImage('img/live.png')
    live.name = 'live'
    live.x = blocos[blocos.numChildren - 1].x
    live.y = blocos[blocos.numChildren - 1].y - live.height
  physics.addBody(live,{density = 1,friction = 0,bounce = 0})
   sceneGroup:insert(live)
 print("time")
end
-----------------
 function gameFuncoes(action)
    if(action == 'add') then
         Runtime:addEventListener('accelerometer',onMovePinguo)
         pinguo.preCollision = localPreCollision
         pinguo:addEventListener( "preCollision", pinguo )
         Runtime:addEventListener('enterFrame',pulo)
        -- blockTimer =  timer.performWithDelay(200, DESCER,0)
         liveTimer = timer.performWithDelay(8000,addLive,0)
         pinguo:addEventListener('collision',collisionHandler)
    else
        print("else")
      Runtime:removeEventListener('accelerometer',onMovePinguo)
      Runtime:removeEventListener('enterFrame',pulo)
     -- timer.cancel(blockTimer)
     -- timer.cancel(liveTimer)
   -- blockTimer = nil
    --  liveTimer = nil
    --  pinguo:removeEventListener('collision',collisionHandler)

    end
end

function pulo(e)
    --pinguo Movement

    

   pinguo.y = pinguo.y - 4
--blocoDOWN = blocoDOWN -2 
   ---addInicialBlocos2('add')
 --  print( blocoDOWN )
   ---print("COLISAO")
 
  --- print( blocos[blocos.numChildren) 
   
    score = score  + 1
  scoreTF.text = score
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