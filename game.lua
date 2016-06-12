local composer = require( "composer" )
--composer.recycleOnSceneChange = true
local widget = require( "widget" )
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
local collisionHandler  = {}
local collisionHandler2  = {}
local addBloco = {}
local bloco 
local pinguo 
local scoreTF = 0
local live
local colisaobloco
local colisao3 = {}
local livesTF = 3
local lives
local alertScore
local timeUP
local timesTF = 3
local times = 50 
score=0
local sheet1
local motionx = 0; -- Variable used to move character along x axis
local speed = 4; -- Set Walking Speed
local blocos =  display.newGroup()
local bloco
local numObstaculos = 0
local numObstaculosBad = 0 
local ponto
local wx = display.contentWidth
local h = display.contentHeight
local obstaculos =  {}
local obstaculosBad =  {}
local blocks =  {}
local numBonus = 0
local bonus = {}
local blocksBad =  {}
somDeImpacto = audio.loadSound("music/jump.wav")
local fundo,textScore,memTimer,bola,obstaculos2,numObstaculos2,pontos,
       obstaculo,w,tempo,setaEsq,setaDir,nuvem,nuvem2,nuvem3,sheet1,spriteSet1,cont,cont2,cont3,font,
 tick = 1200 -- medida de tempo para cada obstaculo aparece
  w = 0 -- guarda a posição x
  tempo = 7000 -- guarda o tempo utilizado no transation
local Ay = 0

 local newProgressView


-- "scene:create()"
function scene:create( event )
   
local physics = require("physics")

  newProgressView = widget.newProgressView {
    left = 30,
    top = 1000,
    width = 200,
    isAnimated = true,
    inicial= 3
  }

  newProgressView.x= 200
  newProgressView.y= 22


function onScore()
  score = score  + 100
  scoreTF.text = score
end 


  local currentProgress = 2.0
 
  local function increaseProgressView()
    currentProgress = currentProgress - 0.02 
  ---  print(currentProgress)
    newProgressView:setProgress( currentProgress )
  end

  timer.performWithDelay( 250,increaseProgressView,100)





---local show = require("show")
    physics.start()
    --physics.setGravity(0,40,5)
     physics.setGravity(0,15)

      local sceneGroup = self.view  

    
    
      local background = display.newImage("img/bgplay4.png")
      background.width=screenW   *2
      background.height=screenH   * 2
      sceneGroup:insert(background)


      scoreTF = display.newText("Score : "..'0',500,22,system.nativeFont,40)
      scoreTF:setTextColor(0,0,255)
      sceneGroup:insert(scoreTF)

     local tempoI = display.newImage("imagens/tempo.png")
      tempoI.x = 20
      tempoI.y = 22 
      tempoI.height = 50
      tempoI.width=30
      sceneGroup:insert(tempoI)



     

 ----------------------------------------------------------------------------------------------------------
-----------------------------PINGUO----------------------------------------------------------------------



function addPinguo()
  local sheet1 = graphics.newImageSheet( "imagens/sprite.png", { width=90, height=90, numFrames=4})
    pinguo = display.newSprite(sheet1,{name="man", start=1, count=4, time=600,loopCount=1} ) 
    physics.addBody( pinguo,  {  bounce=0.1, friction=0.3} )
    pinguo.x = screenW / 2  ; pinguo.y = 1200
    pinguo.isFixedRotation = true
    pinguo.myName='pinguo'
    pinguo.name="pinguo"
    sceneGroup:insert(pinguo)

return pinguo
end
addPinguo()
--------------------botoes----------------------------------------------------------------------------------
--BOTOES
-- Add left joystick button
local left = display.newImage ("imagens/seta.png")
sceneGroup:insert(left)
  left.x = 45; left.y = 280;
  left.rotation = 180;

---Add right joystick button
local right = display.newImage ("imagens/seta.png")
sceneGroup:insert(right)
  right.x = 120; right.y = 282;

-- Add Jump button
local up = display.newImage ("imagens/btn_arrow.png")
sceneGroup:insert(up)
  up.x = 440; up.y = 280;
  up.rotation = 270;

------------------------------------------------------------------------------------------
 
function addtime()
    timeUP = display.newImage('imagens/up.png')

    timeUP.name = 'timeUP'
    timeUP.myName = 'timeUP'
    
    timeUP.width = 50
    timeUP.height = 50
    local blocotime =0

    -- for i=1,#blocks do    
    --      blocotime = blocotime + i    
    -- end

    local blocoRandom=math.random(#blocks)  
   
   
    timeUP.x = blocks[blocoRandom].x 
    timeUP.y = blocks[blocoRandom].y - timeUP.height
  physics.addBody(timeUP,{density = 1,friction = 0,bounce = 0})
   sceneGroup:insert(timeUP)
 

end
---timeAddTime =  timer.performWithDelay(5000, addtime,0)

function addUp()
    ponto = display.newImage('imagens/ponto.png')
    ponto.name = 'bonus'
     ponto.width = 50
    ponto.height = 50
    ponto.collType = "passar"
    ponto.myName='bonus'
    

    local blocoRandom=math.random(#blocks) 
    

    ponto.x =  blocks[blocoRandom].x 
   ponto.y = blocks[blocoRandom].y - ponto.height
  physics.addBody(ponto,{density = 1,friction = 0,bounce = 0})
  transition.to(ponto,{y, time=200}) 
   sceneGroup:insert(ponto)
 

end
---timeAddTime =  timer.performWithDelay(1500, addUp,0)

-------- chao colicao 
colisaobloco = display.newRect(300,1400,display.contentWidth,3)

 physics.addBody(colisaobloco,"static", {bounce=0.1})
 colisaobloco:setFillColor( 0.5,0.254 )
 colisaobloco.name="removebloco"
 colisaobloco.myName="removebloco"
 colisaobloco.alpha=90
     



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
      pinguo:play()
      pinguo:setLinearVelocity( 0, -200 )
  
  end
end
up:addEventListener("touch",up)

---------------------------------------------------------------


------------------------------<block>--------------------------------


function createbloco( x, y )

  numObstaculos = numObstaculos + 1

  blocks[numObstaculos] = display.newImageRect("img/bloco.png", 150, 90 )
  physics.addBody( blocks[numObstaculos], "static", { bounce=0.0, friction=0.3 } )
  blocks[numObstaculos].collType = "passar"
  blocks[numObstaculos].myName = "obstaculos"
  blocks[numObstaculos].x, blocks[numObstaculos].y = x, y
  blocks[numObstaculos].name = "blocos"
 
  sceneGroup:insert(blocks[numObstaculos])
  
 

 --return bloco
end


function Badcreatebloco( x, y )

  
  

       
        numObstaculosBad = numObstaculosBad + 1

       -- blocksBad[numObstaculos] = display.newImageRect("img/gelo.png", 123, 30 )
         local sheet2 = graphics.newImageSheet( "img/spritebad.png", { width=123, height=30, numFrames=3})
        blocksBad[numObstaculosBad] = display.newSprite(sheet2,{name="man1", start=1, count=3, time=600,loopCount=1} ) 
          
        physics.addBody(blocksBad[numObstaculosBad], "static", { bounce=0.0, friction=0.3 } )
        blocksBad[numObstaculosBad].collType = "passar"
        blocksBad[numObstaculosBad].myName = "obstaculosBad"
        blocksBad[numObstaculosBad].x, blocksBad[numObstaculosBad].y = x, y
        blocksBad[numObstaculosBad].name = "Badblocos"
       
        sceneGroup:insert(blocksBad[numObstaculosBad])
        
end



--------------------------------------------          
             createbloco(  screenW / 2, 1300)





 






function down()
  for i=1,#blocks do
     if(blocks[i].myName~= nil) then
    
        local Ly = blocks[i].y + 150
        --blocksBad[i]:play()
       transition.to(blocks[i],{y=Ly, time = tempo,onComplete = some2})
       
     end
   end
 

 end

 function downBad()
  for i=1,#blocksBad do
     if(blocksBad[i].myName~= nil) then
      
        local Ly = blocksBad[i].y + 150
        --blocksBad[i]:play()
       transition.to(blocksBad[i],{y=Ly, time = tempo,onComplete = some2})
       
     end
   end
 

 end





-- fazer os obdtaculos sumirem
local function some2(self)
    self.alpha = 0
end


--------------------------------------masi teste ob----------------------




function addBloco()
    local r = math.floor(math.random()*4)
    if(r ~= 0) then
        numObstaculos = numObstaculos + 1
        blocks[numObstaculos] =  display.newImageRect("img/bloco.png", 150, 90 )
         blocks[numObstaculos].x = math.random()*(display.contentWidth - ( blocks[numObstaculos].width * 1.5))
        blocks[numObstaculos].y =math.random()* display.contentHeight -  blocks[numObstaculos].height
         blocks[numObstaculos].collType = "passar"
        -- blocks[numObstaculos].name="obstaculos"
       --  blocks[numObstaculos].myName="obstaculos"
        --pinguo.x = screenW * 0.5
       -- pinguo.y = screenH /2 
       
        physics.addBody(blocks[numObstaculos] ,"static",{bounce = 0.1, friction="0.3"})
        transition.to(blocks[numObstaculos] ,{y=1460, time = tempo,onComplete = some2})
        --blocos:insert(bloco)
        sceneGroup:insert(blocks[numObstaculos])
       
        
    else
          numObstaculosBad = numObstaculosBad + 1

           blocksBad[numObstaculosBad] = display.newImageRect("img/bloco.png", 150, 90 )
           --local sheet2 = graphics.newImageSheet( "img/spritebad.png", { width=123, height=30, numFrames=3})
         --  blocksBad[numObstaculosBad] = display.newSprite(sheet2,{name="man1", start=1, count=3, time=600,loopCount=1} ) 
           blocksBad[numObstaculosBad].x = math.random() * (display.contentWidth - ( blocksBad[numObstaculosBad].width * 0.5))
           blocksBad[numObstaculosBad].y = math.random()* display.contentHeight +  blocksBad[numObstaculosBad].height
          blocksBad[numObstaculosBad].collType = "passar"
          -- blocksBad[numObstaculosBad].name= "obstaculosBad"
          -- blocksBad[numObstaculosBad].myName= "obstaculosBad"
           physics.addBody(blocksBad[numObstaculosBad] ,"static",{bounce = 0.3, friction="0.3"})
           transition.to(blocksBad[numObstaculosBad] ,{y=1460, time = tempo,onComplete = some2})
       -- blocos:insert(badbloco)
        
       
       sceneGroup:insert(blocksBad[numObstaculosBad])
      
     
    end
end

blockTimer =  timer.performWithDelay(800, addBloco,0)

local function loadBonus()
    -- trocar newImage por newImageRect, possiblita redenrizar o tamanho de imagen de acordo com dispositivo(alteração)
    numBonus = numBonus + 1
    bonus[numBonus] = display.newImageRect("imagens/up.png",50,50)
    physics.addBody(bonus[numBonus], "kinematic",{bounce = 0.1,friction=0.1})
    local whereFrom = math.random(3)  --determinar a direção do asteróide irá aparecer
  
    bonus[numBonus].name = "timeUP"
     -- condições para os obstaculos carregarem  no jogo
     if (whereFrom == 1) then
     w = math.random(45,120)
     bonus[numBonus].x = w
       bonus[numBonus].y = h - 40
     transition.to(bonus[numBonus],{x= w,y=-60, time = 7000,onComplete = some2})--onComplete = some--cosumindo memoria
     elseif (whereFrom == 2) then
     w = math.random(157,300)
     bonus[numBonus].x = w
       bonus[numBonus].y = h - 40
       transition.to(bonus[numBonus],{x= w,y=-60, time = 7000,onComplete = some2})
     elseif (whereFrom == 3) then
      w = math.random(200, 700)
      bonus[numBonus].x = w
        bonus[numBonus].y = h - 40
        transition.to(bonus[numBonus],{x= w,y=-60, time = 7000,onComplete = some2})
     end
end

timeLoad =  timer.performWithDelay(8000, loadBonus,0)

---------------------------------




-- -- ---teste
--    -- loop do jogo
--   local function loop()
--    if(cont == cont2)then
--     -- loadObstaculos2()
--    else
--    --  loadObstaculos()
--    end
--    cont3 =math.random(3)
--    if cont3 == 2 then
--    -- loadObstaculos()
--       --loadBonus()
--   end

-- end
--  memTimer = timer.performWithDelay(800,loop ,0)
 
-------------------------------------------------------------------------
function onCollision( event )
 
  if(event.name == "timeUP" ) then ---and event.object2.myName == "pinguo") then
  
         print( "se" )

  --   event.object1:removeSelf()
  --   event.object1.myName=nil
  --   print("onCollision")
  --   pinguo:play()
  --  ---DESCER()
   end
end
Runtime:addEventListener( "collision", onCollision )
-- função pontuação
local function colisao(event)
     if(event.phase == "began")then
     --  audio.play(somDeImpacto) -- chamar o som pre carregado
     --bola:prepare("walk")
      -- pinguo:play()
      -- onScore()
       --- score=score+50
       
   end
end
-- função para game over
local function  colisao2(event)
   if((event.object1.myName=="parede" and event.object2.myName=="bola")
    or(event.object1.myName=="bola" and event.object2.myName=="parede"))then
      --audio.play(somDeGameOver)
       audio.play(somDeImpacto)
          event.object1.myName=nil
          print( "game over" )
      -- if(score > pontos)then
      --     banco.atualiza(score)
      --   end
      -- banco.setScore(score)
        -- gameOver()
  elseif((event.object1.myName=="obstaculos2" and event.object2.myName=="bola")
    or(event.object1.myName=="bola" and event.object2.myName=="obstaculos2"))then
         print( "game over" )
      -- audio.play(somDeGameOver)
      -- if(score > pontos)then
      --     banco.atualiza(score)
      --   end
      -- banco.setScore(score)
      --   gameOver()

  end

end

 function  colisao3(event)

  print( "teste" )
  if(event.object1.myName == "removebloco" ) then
    print( "morre" )
       showAlert()

   -- if((event.object1.myName=="bonus" and event.object2.myName=="pinguo"))then
   --    event.object1:removeSelf()
   --    event.object1.myName=nil
   --    onScore()
   --    print( "bonuuuus" )
      --score=score+50
      --updateTexto()
    end
end


local function onPreCollision2( self, event )

    print( event.target )  -- the first object in the collision
    print( event.other )
    print("pinguo")   -- the second object in the collision
 
end
 
pinguo.preCollision = onPreCollision2
pinguo:addEventListener( "preCollision", pinguo )



  -- chama em tempo de execução o metodo colisao, especificando que é uma colisão entre dois objetos
  ---pinguo:addEventListener('collision',colisao3)

  -- pinguo.collision = colisao3
 Runtime:addEventListener( "Collision", colisao3 )

  --Runtime:addEventListener("collision", colisao3)
  -- Runtime:addEventListener("collision", colisao2)
  -- Runtime:addEventListener("collision", colisao3)


---------------------------------------------PRE COLISAO-----------------------------------
 function onTime()
 -- times = times  - 00.1
 -- timeTF.text = times
 currentProgress = currentProgress + 0.2

end  

-->pre colisao pinguo
local function localPreCollision( self, event )

  if ("passar" == event.other.collType) then
        --audio.play(somDeImpacto) -- chamar o som pre carregado
        --onScore()
        pinguo:play()
           
    if ( self.y+(self.height*0.5) > event.other.y-(event.other.height*0.5)+0.2 ) then

     --- transition.to(obstaculos, {} )
      if event.contact then
         pinguo:play()
        event.contact.isEnabled = false
          down()
          downBad()

      end
    end
  end
 
  return true
end
 pinguo.preCollision = localPreCollision

 pinguo:addEventListener( "preCollision", pinguo )




---------------------------------------------------------------------------------------------------




     
   

--------------------------<fucoesPinguo>------------------------------------
function onJump(e)
    

     pinguo.y = pinguo.y - 6 

      -- onTime()
      if(currentProgress <= 0.0) then
         showAlert()
      end
       downBad()
       down()
    
   --- print(Ay)
    -- transition.to(obstaculos,{y=Ay, time=200}) 
end
Runtime:addEventListener('enterFrame',onJump)

--------------------------<gravidade>-----------------------------------

local function onMovePinguo( event )    
   
    pinguo.x = screenW + (screenW * event.xGravity * 2)

    if((pinguo.x - pinguo.width * 0.5) < 0) then
    pinguo.x = pinguo.x + 0.8 
    pinguo.xScale =1
    pinguo:play()

    elseif((pinguo.x + pinguo.width * 0.5) > display.contentWidth) then

        pinguo.x = display.contentWidth - pinguo.width * 0.5
        pinguo.xScale = -1 
         pinguo:play()
    end

end

---blocoTimer =  timer.performWithDelay(800,addBloco,0)
system.setAccelerometerInterval(100)

Runtime:addEventListener ("accelerometer", onMovePinguo);


-- function collisionHandler(e)
--     -- --Grab Lives
--     if(e.other.name == "bonus") then
--         print( "PONTO" )
--         onScore()
--         --currentProgress = currentProgress + 0.5
--          display.remove(e.other)
--          e.other = nil
--     --     lives = lives + 1
--     --     print(lives)
--     --     livesTF.text = 'x' .. lives
--     --     print(lives)

--   elseif(e.other.name == 'timeUP') 
--          print( "TIME" )
--           currentProgress = currentProgress + 0.5
--           display.remove(e.other)
--           e.other = nil
--     --      lives = lives - 1
--     --      print(lives)
--     --     livesTF.text = 'x' .. lives
--      end

--      --end
--     -- --Bad bloco

-- end

-- function collisionHandler(e)
--   --Grab Lives
--   if(e.other.name == 'bonus') then
--     display.remove(e.other)
--     e.other = nil
--     onScore()
--   end
 
--   -- if(e.other.name == 'bad') then
--   --   lives = lives - 1
--   --   livesTF.text = 'x' .. lives
--   -- end
-- end


function collisionHandler(e)
  --Grab Lives
  if(e.other.name == 'timeUP') then
    print( "TIME" )
    display.remove(e.other)
    onTime()
    e.other = nil
    onScore()
  end
 
  -- if(e.other.name == 'bad') then
  --   lives = lives - 1
  --   livesTF.text = 'x' .. lives
  -- end
end





 pinguo:addEventListener('collision',collisionHandler)


--------------------------<gravidade>-----------------------------------

function  showAlert()
    composer.gotoScene( "gameOver", {effect = "fade"} )
     Runtime:removeEventListener ("accelerometer", onMovePinguo);
  --  Runtime:removeEventListener('accelerometer',onMovePinguo)
      pinguo:removeEventListener( "preCollision", pinguo )
      Runtime:removeEventListener('enterFrame',onJump)
   -- Runtime:removeEventListener('collision',onCollision)
    --timer.cancel(memTimer)
   -- timer.cancel(addtime)
    --memTimer = nil
    --timeTimer = nil
    --upTimer= nil
  --  pinguo:removeEventListener('collision',collisionHandler)
    


   
end


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
    audio.stop( somFundo )

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