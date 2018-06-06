include "lib://core/parseXML.ms";
include "lib://core/exception.ms";
include "app://core/constants.ms";

/**
Load new stage from xml file.
*/
class Stage
{
    // @region Constructor
    function this()
    {
        this._drop_count = 0;
        this._big_drop_count = 0;
        this._start_refresh = 0;
        this._start_x = 0;
        this._start_y = 0;
        this._start_body_count = 0;
        this._start_direction = #down;
    }
    // @endregion

    // @region Properties
    property drop_count(v)
    {
        get return this._drop_count;
        set {
            if (v instanceof Integer)
                this._drop_count = v;
            else
                throw new InvalidArgument("[Stage.drop_count]");
        }
    }

    property big_drop_count(v)
    {
        get return this._big_drop_count;
        set {
            if (v instanceof Integer)
                this._big_drop_count = v;
            else
                throw new InvalidArgument("[Stage.big_drop_count]");
        }
    }

    property start_refresh(v)
    {
        get return this._start_refresh;
        set {
            if (v instanceof Integer)
                this._start_refresh = v;
            else
                throw new InvalidArgument("[Stage.start_refresh]");
        }
    }

    property start_x(v)
    {
        get return this._start_x;
        set {
            if (v instanceof Integer)
                this._start_x = v;
            else
                throw new InvalidArgument("[Stage.start_x]");
        }
    }

    property start_y(v)
    {
        get return this._start_y;
        set {
            if (v instanceof Integer)
                this._start_y = v;
            else
                throw new InvalidArgument("[Stage.start_y]");
        }
    }

    property start_body_count(v)
    {
        get return this._start_body_count;
        set {
            if (v instanceof Integer)
                this._start_body_count = v;
            else
                throw new InvalidArgument("[Stage.start_body_count]");
        }
    }

    property start_direction(v)
    {
        get return this._start_direction;
        set {
            if (typeof v == #symbol)
                this._start_direction = v;
            else
                throw new InvalidArgument("[Stage.start_direction]");
        }
    }
    // @endregion

    // @region Methods

    /**
    Load stage from xml file.
    @param file string Path to the file.
    */
    function load(file)
    {
        // open stream
        var content = Stream.openFile(STAGE_PATH + file, "r8");
        // create callbacks
        const callbacks = {
        "/stage/drop_count"             :{text: function(text) {this super.drop_count = text.toInteger();}},
        "/stage/big_drop_count"         :{text: function(text) {this super.big_drop_count = text.toInteger();}},
        "/stage/start_refresh"          :{text: function(text) {this super.start_refresh = text.toInteger();}},
        "/stage/start_x"                :{text: function(text) {this super.start_x = text.toInteger();}},
        "/stage/start_y"                :{text: function(text) {this super.start_y = text.toInteger();}},
        "/stage/start_body_count"       :{text: function(text) {this super.start_body_count = text.toInteger();}},
        "/stage/start_direction"        :{text: function(text) {this super.start_direction = text.toSymbol();}}
        };
        // parse xml
        parseXML(content, callbacks);
    }
    // @endregion
}