package;

import Lambda;

class GridLine
{
	var containedPositions:Array<GridPosition> = new Array();

	public function new(from:GridPosition, to:GridPosition) 
	{
		if (from.column == to.column) {
            for (row in range(from.row, to.row)) {
                containedPositions.push(new GridPosition(from.column, row));
            }
		} else if (from.row == to.row) {
            for (column in range(from.column, to.column)) {
                containedPositions.push(new GridPosition(column, from.row));
            }
        } else {
            var startRow = from.column > to.column ? to.row : from.row;
            var slope = null;
            if (from.column - to.column == from.row - to.row) {
                slope = 1;
            } else if (from.column - to.column == to.row - from.row) {
                slope = -1;
            }
            if (slope != null) {
                var distance = 0;
                for (column in range(from.column, to.column)) {
                    containedPositions.push(new GridPosition(
                    column,
                    startRow + slope * distance
                    ));
                    distance++;
                }
            }
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