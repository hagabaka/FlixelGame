package;

enum GridLineParameters {
	Horizontal(row:Int, columns:IntIterator);
	Vertical(column:Int, rows:IntIterator);
	Diagonal(intercept:Int, columns:IntIterator);
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
		} else if (Math.abs(from.column - to.column) == Math.abs(from.row - to.row)) {
			parameters = GridLineParameters.Diagonal(from.row - from.column, range(from.column, to.column));
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
			case GridLineParameters.Diagonal(intercept, columns):
				for (column in columns) {
					containedPositions.push(new GridPosition(column, column + intercept));
				}
			case GridLineParameters.Invalid:
		}
		trace(containedPositions);
	}

	public function contains(position):Bool {
		trace(containedPositions);
		return containedPositions.indexOf(position, 0) >= 0;
	}

	static function range(from, to):IntIterator {
		if (to < from) {
			return to ... from + 1;
		} else {
			return from ... to + 1;
		}
	}
}