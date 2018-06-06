include "lib://game2d/sprite.ms";

/**
Part class defines Snake common attributes and behaviour.
*/
class Part : Sprite
{
    /**
    Init part instance
    */
    function init()
    {
        super.init();
        //position in canvas
        this._x = 0;
        this._y = 0;

        this._direction = #down;
    }

    /**
    Direction of the snake
    @param Symbol v
    @return Symbol
    */
    property direction(v)
    {
        get return this._direction;
        set this._direction = v;
    }

    /**
    Width of the snake part
    @param Integer v
    @return Integer
    */
    property width(v)
    {
        get return CELL_WIDTH;
    }

    /**
    Height of the snake part
    @param Integer v
    @return Integer
    */
    property height(v)
    {
        get return CELL_HEIGHT;
    }

}