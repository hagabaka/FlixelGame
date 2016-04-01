package;
import Random;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.input.mouse.FlxMouseEventManager;

class Grid extends FlxObject
{
	private var letterRows:Array<Array<Letter>> = [];
	public static var letterSize:Float = 48;
	private var mouseEventManager:FlxMouseEventManager = new FlxMouseEventManager();
	private var selectedLetters:Array<Letter> = [];
	private var selectionStart:Letter = null;
	private var lastSelectedLetter:Letter;
	
	public function new(columnCount:Int, rowCount:Int, state:FlxState) 
	{
		super(0, 0, letterSize * columnCount, letterSize * rowCount);
		FlxMouseEventManager.init();
		FlxMouseEventManager.add(this, null, onMouseUp, null, onMouseOut, true, true);
		var fontSize:Int = Std.int(letterSize * 0.5);
		for (rowIndex in 0...rowCount) {
			var row:Array<Letter> = [];
			for (columnIndex in 0...columnCount) {
				var letter:Letter = new Letter(Random.string(1, "abcdefghijklmnopqrstuvwxyz"), this, new GridPosition(columnIndex, rowIndex), letterSize, fontSize, state);
				row.push(letter);
			}
			letterRows.push(row);
		}
	}
	
	override public function update(elapsed:Float) {
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
	
	public function onMouseDownLetter(letter:Letter) {
		selectionStart = letter;
	}
	
	public function onMouseOverLetter(letter:Letter) {
		if(selectionStart != null) {
			selectLetters(selectionStart, letter);
		}
	}

	public function onMouseUp(_) {
		selectionStart = null;
	}
	
	public function onMouseOut(_) {
	}
}