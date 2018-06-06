/**
Helper class.
@private
*/
class SwitchItem
{

        function this(direction, number)
        {
            this.direction = direction;
            this.it = number;
        }

        /**
        Return counter and increment his.
        @return int
        */
        function next()
        {
            return this.it++;
        }
}

/**
Class to change direction of the snake
*/
class Switch
{
    function this(snake)
    {
        this.array = [];
        this.snake = snake;
    }

    /**
    Add normal switcher.
    @param direction symbol
    */
    function add(direction)
    {
        this.array.push(new SwitchItem(direction, -1));
    }

    /**
    Add switcher, which change image of part to edge image.
    @param direction symbol
    */
    function addEdge(direction)
    {
        this.array.push(new SwitchItem(direction, 0))
    }

    /**
    It is loop which should call in onProccess function.
    */
    function refresh()
    {
        var del = 0;
        var j = 0;
        // go throw all edges (SwitchItems) in the array
        for (var i in this.array) {
            var it = i.next();

            if (it==this.snake.body.length)
                del++;
            else if (it >= 0) {
                // apply directory to the body
                this.snake.body[it].direction = i.direction;
                }

            j++;
        }
        if (del > 0) // delete switchs which are on the end
            for (var i = 0; i < del; i++) {
                this.snake.tail.direction = this.array[0].direction;
                this.array.remove(0);
            }
    }
}