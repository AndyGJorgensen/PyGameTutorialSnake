include "app://core/constants.ms";
include "lib://game2d/sprite.ms";

/**
Score class manage snake scores.
*/
class Score : Sprite
{
    // @region Static variables
    // declar static image instance;
    var _numbersImage = Bitmap.fromFile(S_NUMBERS);
    // @endregion

    // @region Construction
    function init()
    {
        super.init();

        this._initVariables();
        this._initOnProcessFunction();
    }
    // @endregion

    // @region Properties
    property value(v)
    {
        get return this._value;
        set {
            var s = v - this._value;
            if (s > 0) {
                this._effect = new Paint();
                this._effect.color = 0x80ffffff;
                this._effect.value = s;
                this._effect.top = this.top + 20;
            }
            this._value = v;
        }
    }

    property width(v)
    {
        get return this.frameWidth;
    }

    property height(v)
    {
        get return this.frameHeight;
    }

    property right(v)
    {
        get return this._right;
        set this._right = v;
    }

    property top(v)
    {
        get return this._top;
        set this._top = v;
    }
    // @endregion

    // @region Events
    function draw(canvas)
    {
        this.x = this.right - 100;// this.width;
        this.y = this.top + 20;

        var str = this.value.toString();
        for (var i = 0; i < str.length; i++) {
            this.frame = str[i] - 48;
            super.draw(canvas);
            this.x += this.frameWidth;
        }

        if (this._effect) {
            this.x = this.right - (5*this.frameWidth);
            str = this._effect.value.toString();
            for (var i = -1; i < str.length; i++) {

                if (i < 0) {
                    this.frame = 10;
                    this.y = this._effect.top + (this.height - this.frameHeight)/2;
                }else {
                    this.frame = str[i] - 48;
                    this.y = this._effect.top;

                }
                this._draw(canvas,this._effect);
                this.x += this.frameWidth;
            }
        }
    }
    // @endregion

    // @region Private methods
    function _draw(canvas,paint)
    {
         if (!this.visible)
            return;

        assert canvas instanceof Canvas;
        assert this._image instanceof Bitmap;

        this._setObject();

        canvas.save(#matrix);
        canvas.translate(this._x, this._y);
        canvas.scale(this._scale, this._scale);
        canvas.translate(-this._anchorX, -this._anchorY)

        var sequenceFrame = this._frame;
        sequenceFrame = this._sequence[this._frame];
        var slices = this._image.width / this._frameWidth;
        var sl = (sequenceFrame % slices) * this._frameWidth;
        var st = (sequenceFrame / slices) * this._frameHeight;

        canvas.drawBitmapRect(this._image,
            sl, st, sl + this._frameWidth, st + this._frameHeight,
            0, 0, this._frameWidth, this._frameHeight, paint);

        canvas.restore();

    }

    function _initVariables()
    {
        // set image
        this.image = _numbersImage;
        // set size of one subimage
        this.frameWidth = 25;
        this.frameHeight = 34;
        // init score value
        this._value = 0;
        // init helper variables to define position
        this._right = 0;
        this._top = 0;
        // init variable by which we do effect at adding new value
        this._effect = null;
    }

    function _initOnProcessFunction()
    {
        this.onProcess = function(sender)
        {
            var self = this super;
            if (self._effect) {
                if (self._effect.color & 0xff000000) {
                    self._effect.color -= 0x02000000;
                    self._effect.top += 1;
                }
                else
                    self._effect = null;
            }
        }
    }
    
}