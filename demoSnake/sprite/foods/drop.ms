include "app://core/constants.ms";
include "lib://game2d/sprite.ms";

/**
BigDrop is instance of Sprite with predefined parameters.
*/
class Drop : Sprite
{
    // @region Static variables
    var _foodImage = Bitmap.fromFile(G_DROP_I);
    // @endregion

    // @region Construction
    function init()
    {
        super.init();

        this._score = 10;
        this._speedValue = 5;

        this.image = this._foodImage;
    }
    // @endregion

    // @region Properties
    property score(v)
    {
        get return this._score;
    }

    property speedValue(v)
    {
        get return this._speedValue;
    }
    // @endregion
}