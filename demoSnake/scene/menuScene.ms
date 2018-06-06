include "app://core/constants.ms";
include "lib://game2d/scene.ms";
include "lib://game2d/sceneTransitions/slideToLeft.ms";

class MenuScene : Scene
{
    // @region Construction

    function init()
    {
        super.init();
    
        this._computeScale();           // compute scale
        this._loadBg();                 // load background
        this._createContinueBttn();     // create continue button
        this._createTouchGameBttn();    // create new touch game button
        // check if application does not run on iOS
        if (System.OS_NAME != #iOS)
            this._createQuitGameBttn();     //create quit button
    }
    // @endregion

    // @region Properties

    property width(v)
    {
        get return this._background.width;
    }

    property height(v)
    {
        get return this._background.height;
    }

    // @endregion

    // @region Public methods

    function showContinueBttn()
    {
        this._bContinue.visible = true;
    }

    function hideContinueBttn()
    {
        this._bContinue.visible = false;
    }
    // @endregion

    // @region Events

    function draw(canvas)
    {
        // draw background scene
        canvas.drawBitmap(this._background, 0, 0);
        // call draw function on other objects in scene
        super.draw(canvas);
    }
    // @endregion

    // @region Private methods

    function _computeScale()
    {
        // variable use to scale buttons
        this._scale = 1.0;
        // computation scale
        if (Bitmap.fromFile(M_NEW_GAME_TOUCH).width > System.width)
            this._scale = System.width*9.0/10 / Bitmap.fromFile(M_NEW_GAME_TOUCH).width;
    }

    function _loadBg()
    {
        // load background from file
        this._background = Bitmap.fromFile(M_MENU);
        // resize background to actual system resolution
        this._background = this._background.resize(System.width, System.height);
    }

    function _createContinueBttn()
    {
        // create new button
        this._bContinue = new GameButton({image:M_CONTINUE, frameWidth:276, frameHeight:66, scale : this._scale});
        this._bContinue.visible = false;
        // set position on scene
        this._bContinue.x = System.width/2;
        this._bContinue.y = System.height / 5 * 3;
        // set function called at click on button
        this._bContinue.onClick = function() {
            if(game.tmpScene instanceof Scene)
                game.push(game.tmpScene);
        };
        // add button to the scene
        this.add(this._bContinue);
    }

    function _createTouchGameBttn()
    {
        this._bNewGameTouch = new GameButton({image:M_NEW_GAME_TOUCH, frameWidth:327, frameHeight:66, scale : this._scale});
        this._bNewGameTouch.x = System.width/2;
        this._bNewGameTouch.y = this._bContinue.y + this._bContinue.scaledHeight + M_VERTICAL_SPACE;
        this._bNewGameTouch.onClick = function()
        {
            game.gameScene = new GameScene();
            game.push(game.gameScene, new SlideToLeft({duration:1000,transition:Animator.Transition.bouncy}));
            this super.showContinueBttn();
        }
        this.add(this._bNewGameTouch);
    }

    function _createQuitGameBttn()
    {
        // create new instance of GameButton
        this._bQuit = new GameButton({image:M_QUIT, frameWidth:146, frameHeight:72, scale : this._scale});
        // set position
        this._bQuit.x = System.width/2;
        this._bQuit.y = this._bNewGameTouch.y + this._bNewGameTouch.scaledHeight + M_VERTICAL_SPACE;
        // assign lambda function to onClick handler
        this._bQuit.onClick = :: game.quit();
        // add button to the scene
        this.add(this._bQuit);
    }
    // @endregion
}