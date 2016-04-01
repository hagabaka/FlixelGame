package;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.util.FlxFSM.StatePool;
import flixel.text.FlxText;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.geom.Point;

class Letter extends FlxObject
{
	private var letter:String;
	private var grid:Grid;
	private var sprite:FlxText;
	public var gridPosition(default, default):GridPosition;
	public var screenPosition(get, never):Point;
	public var selected(default, default):Bool = false;
	private var letterSize:Float;
	
	public function new(letter:String, grid:Grid, x:Float, y:Float, letterSize:Float, fontSize:Int, state:FlxState) 
	{
		this.letter = letter;
		this.grid = grid;
		this.letterSize = letterSize;
		sprite = new FlxText(x, y, letterSize, letter, fontSize);
		state.add(this.sprite);
		FlxMouseEventManager.add(sprite, onMouseDown, onMouseUp, onMouseOver, null);
	}
	
	override public function update(elapsed:Float) {
		this.sprite.setPosition(screenPosition.x, screenPosition.y);
		if (selected) {
			this.sprite.color = 0x00ff00;
		} else {
			this.sprite.color = 0xffffff;
		}
		
		this.sprite.update(elapsed);
	}
	
		
	public function onMouseDown(sprite:FlxSprite) {
		grid.onMouseDown(this);
	}
	
	public function onMouseUp(sprite:FlxSprite) {
		grid.onMouseUp(this);
	}
	
	public function onMouseOver(sprite:FlxSprite) {
		grid.onMouseOver(this);
	}
	
	public function get_screenPosition() {
		return new Point(gridPosition.column * letterSize, gridPosition.row * letterSize);
	}
}