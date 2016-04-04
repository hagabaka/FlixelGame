package;

using GridLine.CriteriaExtension;

class Range {
	private var min:Int;
	private var max:Int;
	public function new(min, max) {
		this.min = min;
		this.max = max;
	}
	public function contains(value) {
		return value >= min && value <= max;
	}
}
enum Criteria {
	Equal(position:Int);
	Between(range:Range);
}
class CriteriaExtension {
	public static function fromRange(_:Enum<Criteria>, from, to) {
		var min = Std.int(Math.min(from, to));
		var max = Std.int(Math.max(from, to));
		if (min == max) {
			return Criteria.Equal(min);
		} else {
			return Criteria.Between(new Range(min, max));
		}
	}
}

class GridLine
{
	private var rowCriteria:Criteria;
	private var columnCriteria:Criteria;
	private var from:GridPosition;
	private var to:GridPosition;

	public function new(from:GridPosition, to:GridPosition) 
	{
		rowCriteria = Criteria.fromRange(from.row, to.row);
		columnCriteria = Criteria.fromRange(from.column, to.column);
		this.from = from;
		this.to = to;
	}
	
	public function contains(position:GridPosition):Bool {
		switch([rowCriteria, columnCriteria]) {
			case [Equal(row), Between(columnRange)]:
				return row == position.row && columnRange.contains(position.column);
			case [Between(rowRange), Equal(column)]:
				return rowRange.contains(position.row) && column == position.column;
			default:
				return false;
		}
	}
	
	public function isValid():Bool {
		return from.row == to.row || from.column == to.column;
	}
}