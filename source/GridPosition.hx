package;

/**
 * ...
 * @author ...
 */
class GridPosition
{
	public var row(default, null):Int;
	public var column(default, null):Int;
	
	public function new(column, row) 
	{
		this.row = row;
		this.column = column;
	}

    public function equals(gridPosition:GridPosition):Bool {
        return row == gridPosition.row && column == gridPosition.column;
    }
}
