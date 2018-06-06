include "app://sprite/snake/part.ms";

/**
Body, is instance of the sprite and it habdle snake body direction
*/
class Body : Part
{
    // Load images
    var _bodyImage = Bitmap.fromFile(SNAKE_BODY_IMAGE);

    /**
    Init body instance
    */
    function init()
    {
        super.init();
        this._topLeft = 0;
        this._topRight = 0;
        this._bottomLeft = 0;
        this._bottomRight = 0;

        // Init body
        this.shiftShadowX = -10;
        this.shiftShadowY = -10;

        // set images
        this.image = _bodyImage;
        this.frameWidth = 20;
        this.frameHeight = 20;

    }

    property direction(v)
    {
        get return this._direction;
        set {
            this._direction = v;
            switch(this._direction) {
            case #left:
            case #right:        this.frame = 2; break;
            case #up:
            case #down:         this.frame = 3; break;
            case #down_right:
            case #left_up:      this.frame = 1; break;
            case #up_left:
            case #right_down:   this.frame = 5; break;
            case #right_up:
            case #down_left:    this.frame = 0; break;
            case #up_right:
            case #left_down:    this.frame = 4; break;
        }
        }
    }

    /**
    Event executed within gameScene onProcess
    */
    function onProcess()
    {
        if (this.direction == #left || this.direction == #left_up || this.direction == #left_down)
            this.x -= this.width;
        if (this.direction == #right || this.direction == #right_up || this.direction == #right_down)
            this.x += this.width;
        if (this.direction == #up || this.direction == #up_left || this.direction == #up_right)
            this.y -= this.height;
        if (this.direction == #down || this.direction == #down_left || this.direction == #down_right)
            this.y += this.height;
    }

}