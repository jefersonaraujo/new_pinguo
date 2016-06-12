--display.setStatusBar( display.HiddenStatusBar )

-- require the composer library
local composer = require "composer"
local banco = require("banco")
score = 0
somFundo = audio.loadSound("music/hasppy.mp3")
banco.criarBd()
local pontos = banco.lista()
if (pontos == nil )then
  banco.insere(0)
end
composer.gotoScene( "menu", {effect = "fade"} )