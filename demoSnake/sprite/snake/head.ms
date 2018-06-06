include "app://sprite/snake/part.ms";

/**
Head part of snake. Head is instance of Sprite.
Defines head movement, and handle collistions with other game objects
*/
class Head : Part
{
    // Load images
    var _headImage = Bitmap.fromFile(SNAKE_HEAD_IMAGE);

    /**
    Init snake Head
    */
    function init()
    {
        super.init();

        this.image = _headImage;
        this.frameWidth = 40;
        this.frameHeight = 40;
        this._changeDirection = null;

    }

    /**
    Property direction
    @get Return actual direction
    @set Symbol v Set direction and relative position, because head is bigger than other snake parts.
    */
    property direction(v)
    {
        get return this._direction;
        set {
            this._direction = v;
            this._changeDirection = v;
        }
    }

    /**
    Check intersects by object
    @param Gameobject obj
    @return Boolean
    */
    function intersectsBounds(obj)
    {
        assert obj instanceof GameObject;
        var tx = this._x;
        var ty = this._y;
        var ox = obj._x;
        var oy = obj._y;
        return (
            tx + this.width > ox && tx < ox + obj.width &&
            ty + this.height > oy && ty < oy + obj.height
        );
    }

    /**
    Event called within Scene onProcess
    @param GameScene sender
    */
    function onProcess(sender)
    {
        if (this._changeDirection !== null)
        {
            switch(this._changeDirection) {
                case #left: this._anchorX = 30; this._anchorY = 0; this.frame = 3; break;
                case #right: this._anchorX = 10; this._anchorY = 0; this.frame = 1; break;
                case #up: this._anchorX = 0; this._anchorY = 30; this.frame = 0; break;
                case #down: this._anchorX = 0; this._anchorY = 10; this.frame = 2; break;
            }
            this._changeDirection = null;
        }
        // Move head by direction
        switch(this.direction)
        {
            case #left:     this.x -= this.width; break;
            case #right:    this.x += this.width; break;
            case #up:       this.y -= this.height; break;
            case #down:     this.y += this.height; break;
        }
        // Check collisions with other parts of snake
        for (var b in sender.snake.body)
            if (this.intersectsBounds(b))
                sender.endGame();
        
        // Check collisions with food
        for (var f in sender.food)
            if (this.intersectsBounds(f)) {
                // Set new random positions
                var stop = false;
                while (!stop) {
                    stop = true;
                    f.x = (1+rand(sender.width/CELL_WIDTH-2))*CELL_WIDTH -10;
                    f.y = (1+rand(sender.height/CELL_HEIGHT-2))*CELL_HEIGHT -10;
                    for (var i in sender.food)
                        if (f != i && f.intersectsBounds(i))
                            stop = false;
                    for (var i in sender.walls)
                        if (f.intersectsBounds(i))
                            stop = false;
                }
                sender.snake.addPart(); // Add new part to the body.
                if (sender.score.value < 300)
                    sender.snake.timer.sleep -= f.speedValue; // It will be more often call method onProcess and snake will be faster.
                sender.score.value += f.score;
                break;
         }

        // Check collisions with boundaries
        if (this.x < 0 || this.x > sender.width || this.y < 0 || this.y > sender.height)
            sender.endGame();
    }
}