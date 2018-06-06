include "app://core/constants.ms";
include "app://core/delay.ms";
include "app://sprite/snake/switch.ms";
include "app://sprite/snake/head.ms";
include "app://sprite/snake/body.ms";
include "app://sprite/snake/tail.ms";

/**
Snake, combine snake headm body and tail sprites into one.
It defines instance of the switch object what manage snake direction.
*/
class Snake
{
    function this(x, y, count, direction)
    {
        this.body = []; //Array for save snake's parts

        // Create Timer
        this.timer = new Delay();

        // Create Switch
        this._switch = new Switch(this);

        // Create head
        this.head = new Head(); //snake's head
        this.head.x = x;
        this.head.y = y;

        // Create tail
        this.tail = new Tail();
        this.tail.x = x;
        this.tail.y = y;
        this.tail.back(); // move with tail about one position back

        this.direction = direction;

        this.addParts(count);
    }

    /**
     Property direction.
     @get return direction of snake
     @set set direction in head and add change direction to the switch
     */
    property direction(value)
    {
        get return this.head.direction;
        set {
            if (this.direction == #left && value == #up)
                this._switch.addEdge(#left_up);
            if (this.direction == #left && value == #down)
                this._switch.addEdge(#left_down);
            if (this.direction == #right && value == #up)
                this._switch.addEdge(#right_up);
            if (this.direction == #right && value == #down)
                this._switch.addEdge(#right_down);
            if (this.direction == #up && value == #left)
                this._switch.addEdge(#up_left);
            if (this.direction == #up && value == #right)
                this._switch.addEdge(#up_right);
            if (this.direction == #down && value == #left)
                this._switch.addEdge(#down_left);
            if (this.direction == #down && value == #right)
                this._switch.addEdge(#down_right);
            this.head.direction = value;
            this._switch.add(value); // Change directions in the rest of the snake
        }
    }

    /**
     Create new part of snake and add him to body array.
     */
    function addPart()
    {
        var part = new Body();
        part.x = this.tail.x;
        part.y = this.tail.y;

        part.direction = this.tail.direction;

        this.tail.back(); // move tail about one position back

        this.body.push(part); // add part to the container
    }

    /**
    Create more parts in one function.
    @param count Count of parts to create.
    */
    function addParts(count)
    {
        for (var i = 0; i<count; i++)   this.addPart();
    }

    /**
    Change direction of snake by x, y coordinates.
    @param x int
    @param y int
    */
    function turnTouch(x,y)
    {
        if (this.direction == #left || this.direction == #right) {
            if (y<this.head.y)
                this.direction = #up;
            if (y>this.head.y)
                this.direction = #down;
        }

        else if (this.direction == #up || this.direction == #down) {
            if (x<this.head.x)
                this.direction = #left;
            if (x>this.head.x)
                this.direction = #right;
        }
    }

    /**
    Event call within game scene onDraw.
    @param Canvas canvas
    */
    function draw(canvas)
    {
        for (var part in this.body)
            part.draw(canvas);
        this.tail.draw(canvas);
        this.head.draw(canvas);
    }

    /**
    Event call within game scene onProcess
    @param GameScene sender
    */
    function onProcess(sender)
    {
        if (this.timer.onProcess()) {
            this.head.onProcess(sender);
            this._switch.refresh();
            for (var part in this.body)
                part.onProcess();
            this.tail.onProcess();
            return true;
        }
    return false;
    }
}