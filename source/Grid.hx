package;
import Random;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.geom.Point;

class Grid
{
	private var letterRows:Array<Array<Letter>> = [];
	private static var letterSize:Float = 48;
	private var mouseEventManager:FlxMouseEventManager = new FlxMouseEventManager();
	private var selectedLetters:Array<Letter> = [];
	private var selectionStart:Letter = null;
	private var lastSelectedLetter:Letter;
	
	public function new(columnCount:Int, rowCount:Int, state:FlxState) 
	{
		var fontSize:Int = Std.int(letterSize * 0.5);
		for (rowIndex in 0...rowCount) {
			var row:Array<Letter> = [];
			for (columnIndex in 0...columnCount) {
				var position = positionForCell(columnIndex, rowIndex);
				var letter:Letter = new Letter(Random.string(1, "abcdefghijklmnopqrstuvwxyz"), this, position.x, position.y, letterSize, fontSize, state);
				letter.gridPosition = new GridPosition(columnIndex, rowIndex);
				row.push(letter);
			}
			letterRows.push(row);
		}
	}
	
	public function update(elapsed:Float) {
		for (row in letterRows) {
			for (letter in row) {
				letter.update(elapsed);
			}
		}
	}
	
	public function selectLetters(from:Letter, to:Letter) {
		var gridLine = new GridLine(from.gridPosition, to.gridPosition);
		
		for (row in letterRows) {
			for (letter in row) {
				letter.selected = gridLine.contains(letter.gridPosition);
			}
		}
	}
	
	public function onMouseDown(letter:Letter) {
		selectionStart = letter;
		trace("onMouseDown");
	}
	
	public function onMouseUp(letter:Letter) {
		selectionStart = null;
		trace("onMouseUp");
	}
	
	public function onMouseOver(letter:Letter) {
		if(selectionStart != null) {
			selectLetters(selectionStart, letter);
			trace("selectLetters");
		}
	}
	
	private function positionForCell(columnIndex:Int, rowIndex:Int) {
		return new Point(columnIndex * letterSize, rowIndex * letterSize);
	}
}