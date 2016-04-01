package;

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
class CriteriaMaker {
	public static function fromRange(from:Int, to:Int):Criteria {
		var min = Std.int(Math.min(from, to));
		var max = Std.int(Math.max(from, to));
		if (min == max) {
			return Equal(min);
		} else {
			return Between(new Range(min, max));
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
		rowCriteria = CriteriaMaker.fromRange(from.row, to.row);
		columnCriteria = CriteriaMaker.fromRange(from.column, to.column);
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