include "app://sprite/snake/part.ms";

/**
Tail, instance if sprite object and it handle direction of the snake tail.
*/
class Tail : Part
{
    var _tailImage = Bitmap.fromFile(SNAKE_TAIL_IMAGE);

    function init()
    {
        super.init();

        // Init tail
        this.shiftShadowX = -10;
        this.shiftShadowY = -10;

        this.image = _tailImage;
        this.frameWidth = 20;
        this.frameHeight = 20;

    }

    /**
    Move tail about one position back.
    @return nothing
    */
    function back()
    {
        switch (this._directMove()) {
            case #left:    this.x += this.width; break;
            case #right:   this.x -= this.width; break;
            case #up:      this.y += this.height; break;
            case #down:    this.y -= this.height; break;
        }
    }

    /**
    Private function.
    @return Return direction, where snake should move.
    */
    function _directMove()
    {
        switch(this.direction) {
            case #left:
            case #left_up:
            case #left_down:    return #left;
            case #right:
            case #right_up:
            case #right_down:   return #right;
            case #up:
            case #up_left:
            case #up_right:     return #up;
            case #down:
            case #down_left:
            case #down_right:   return #down;
        }
    }

    /**
    Event executed within GameScene
    */
    function onProcess()
    {
        switch (this._directMove()) {
            case #left:    this.x -= this.width; break;
            case #right:   this.x += this.width; break;
            case #up:      this.y -= this.height; break;
            case #down:    this.y += this.height; break;
        }

        switch (this.direction) {
            case #left:
            case #down_left:
            case #up_left:       this.frame = 3; break;
            case #right:
            case #down_right:
            case #up_right:      this.frame = 1; break;
            case #down:
            case #left_down:
            case #right_down:    this.frame = 2; break;
            case #up:
            case #left_up:
            case #right_up:      this.frame = 0; break;

        }

    }

}