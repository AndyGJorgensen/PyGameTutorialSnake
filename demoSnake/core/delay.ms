/**
Simple delay manager.
*/
class Delay
{
    function this(sleep = 0)
    {
        this._sleep = sleep;
        this._tick = System.tick;
    }

    // sleep time
    property sleep(v)
    {
        get return this._sleep;
        set this._sleep = v;
    }

    // check if last call of this function was minimally before the sleep time
    function onProcess()
    {
        if (System.tick - this._tick < this.sleep)
            return false;
        this._tick = System.tick;
        return true;
    }
}