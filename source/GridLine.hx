package;

import Lambda;
enum GridLineParameters {
	Horizontal(row:Int, columns:IntIterator);
	Vertical(column:Int, rows:IntIterator);
    Diagonal(slope:Int, startRow:Int, columns:IntIterator);
	Invalid;
}
class GridLine
{
	var containedPositions:Array<GridPosition> = new Array();

	public function new(from:GridPosition, to:GridPosition) 
	{
		var parameters:GridLineParameters = GridLineParameters.Invalid;
		if (from.column == to.column) {
			parameters = GridLineParameters.Vertical(from.column, range(from.row, to.row));
		} else if (from.row == to.row) {
			parameters = GridLineParameters.Horizontal(from.row, range(from.column, to.column));
        } else if (from.column - to.column == from.row - to.row) {
            parameters = GridLineParameters.Diagonal(
                1,
                from.column > to.column ? to.row : from.row,
                range(from.column, to .column)
            );
        } else if (from.column - to.column == to.row - from.row) {
            parameters = GridLineParameters.Diagonal(
                -1,
                from.column > to.column ? to.row : from.row,
                range(from.column, to .column)
            );
        }

		switch(parameters) {
			case GridLineParameters.Vertical(column, rows):
				for (row in rows) {
					containedPositions.push(new GridPosition(column, row));
				}
			case GridLineParameters.Horizontal(row, columns):
				for (column in columns) {
					containedPositions.push(new GridPosition(column, row));
				}
            case GridLineParameters.Diagonal(slope, startRow, columns):
                var distance = 0;
				for (column in columns) {
                    containedPositions.push(new GridPosition(
                    column,
                    startRow + slope * distance
                    ));
                    distance++;
				}
			case GridLineParameters.Invalid:
		}
	}

    public function contains(position:GridPosition):Bool {
        return Lambda.find(containedPositions, function(gridPosition:GridPosition) {
            return gridPosition.equals(position);
        }) != null;
	}

	static function range(from, to):IntIterator {
		if (to < from) {
			return to ... from + 1;
		} else {
			return from ... to + 1;
		}
	}
}