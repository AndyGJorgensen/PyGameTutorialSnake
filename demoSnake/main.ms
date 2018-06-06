include "lib://core/log.ms";
include "lib://game2d/game.ms"

include "app://core/constants.ms";
include "app://scene/gameScene.ms"
include "app://scene/menuScene.ms";

// create new game instance
var game = new Game();

// prepare game instance before it runs
game.onStart = function(sender)
{
    // create menu scene
    this.menu = new MenuScene();
    this.push(this.menu);
}

// reaction to hardware keyboard press
game.onKeyPressed = function(sender, keyCode)
{
    if (keyCode == #back) {
        game.tmpScene = game.gameScene;
        game.gameScene._pause = true;
        game.pop(new SlideToRight({duration:1000,transition:Animator.Transition.bouncy}));
    }
}

// run game
game.run();