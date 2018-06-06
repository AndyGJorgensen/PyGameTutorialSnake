include "app://core/constants.ms";
include "app://core/delay.ms";
include "app://core/stage.ms";
include "app://sprite/score.ms";
include "app://sprite/snake/snake.ms";
include "app://sprite/foods/drop.ms";
include "app://sprite/foods/bigDrop.ms";
include "lib://game2d/sceneTransitions/slideToRight.ms";

class GameScene : Scene
{
    // @region Construction
    function init()
    {
        super.init();

        this._initVariables();  // init helper variables
        this._loadBg();         // load background image
        this._createMenuBttn(); // create and add to the scene menu button
        this._createScore();    // create and andd to the scene score
        this._loadStage();      // load stage from xml
        this._createBigDrops(); // create and distribute big drops
        this._createDrops();    // create and distribute drops
        this._createSnake();    // create snake object
    }
    // @endregion

    // @region Properties

    property x(v)
    {
        get return 0;
    }

    property y(v)
    {
        get return 0;
    }

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

    /**
    End game and hide continue button.
    */
    function endGame()
    {
        game.pop();
        game.game = null;
        game.menu.hideContinueBttn();
    }

    // @endregion

    // @region Events

    /**
     Function call at redrawing.
     @param canvas Canvas object.
     */
    function draw(canvas)
    {
        // draw background
        canvas.drawBitmap(this._background, 0, 0);
        // draw snake
        this.snake.draw(canvas);
        // call parents draw function
        super.draw(canvas);
    }

    /**
     * Function called each 20 millisecond.
     * @return nothing
     */ 
    function process()
    {
        super.process();

        if (this._pause)
            return;

        if (this.snake.onProcess(this))
            this._pushed = false;
    }

    function pointerPressed(x,y)
    {
        // call parents pointerPressed event
        super.pointerPressed(x,y);

        // if game is paused so play her
        if (this._pause) {
            this._pause = false;
            return;
        }

        if (this.bMenu._clicked)
            return;
        // while it is not processed previous pointerPressed event so it skip this
        if (this._pushed == false) {
            this._pushed = true;
            this.snake.turnTouch(x,y);
        }
    }
    // @endregion

    // @region Private methods
    function _initVariables()
    {
        this._pause = false;
        this._pushed = false;

        this.food = new Array();
    }

    function _loadBg()
    {
        // Background
        this._background = Bitmap.fromFile(G_BACKGROUND);
        this._background = this._background.resize(System.width, System.height);
    }

    function _createMenuBttn()
    {
        this.bMenu = new GameButton({image:G_MENU_BUTTON, frameWidth:96, frameHeight:41, x:45, y:20});
        this.bMenu.onClick = function() {
            game.tmpScene = this super;
            game.pop(new SlideToRight({duration:1000,transition:Animator.Transition.bouncy}));
            this super._pause = true;
        };
        this.add(this.bMenu);
    }

    function _createScore()
    {
        this.score = new Score();
        this.score.right = this.width - 10;
        this.add(this.score);
    }
    function _loadStage()
    {
        // Create and load stage
        this.stage = new Stage();
        this.stage.load("stage1.xml");
    }

    function _createBigDrops()
    {
        for (var i = 0; i < this.stage.big_drop_count; i++) {
            var b = new BigDrop();
            // Random position
            var stop = false;
            while (!stop) {
                stop = true;
                b.x = (1+rand(this.width/CELL_WIDTH-2))*CELL_WIDTH -10;
                b.y = (1+rand(this.height/CELL_HEIGHT-2))*CELL_HEIGHT -10;

               for (var i in this.food)
                    if (b.intersectsBounds(i))
                        stop = false;
                for (var i in this.walls)
                    if (b.intersectsBounds(i))
                        stop = false;
            }

            // Add object to the container
            this.food.push(b);
            this.add(b);
        }
    }

    function _createDrops()
    {
        for (var i = 0; i < this.stage.drop_count; i++) {
            var b = new Drop();
            // Random position
            var stop = false;
            while (!stop) {
                stop = true;
                b.x = (1+rand(this.width/b.width-2))*b.width-10;
                b.y = (1+rand(this.height/b.height-2))*b.height-10;

                for (var i in this.food)
                    if (b.intersectsBounds(i))
                        stop = false;
            }

            // Add object to the container
            this.food.push(b);
            this.add(b);
        }
    }

    function _createSnake()
    {
        this.snake = new Snake(this.stage.start_x, this.stage.start_y, this.stage.start_body_count, this.stage.start_direction);
        this.snake.timer.sleep = this.stage.start_refresh;
    }
    // @endregion
    
}