package;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.util.FlxFSM.StatePool;
import flixel.text.FlxText;
import flixel.input.mouse.FlxMouseEventManager;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Letter
{
	private var letter:String;
	private var grid:Grid;
	private var sprite:FlxText;
	public var gridPosition(default, default):GridPosition;
	public var screenPosition(get, never):Point;
	public var screenRectangle(get, never):Rectangle;
	public var selected(default, default):Bool = false;
	private var letterSize:Float;
	
	public function new(letter:String, grid:Grid, gridPosition:GridPosition, letterSize:Float, fontSize:Int, state:FlxState) 
	{
		this.letter = letter;
		this.grid = grid;
		this.gridPosition = gridPosition;
		this.letterSize = letterSize;
		sprite = new FlxText(screenPosition.x, screenPosition.y, letterSize, letter, fontSize);
		state.add(this.sprite);
		FlxMouseEventManager.add(sprite, onMouseDown, null, onMouseOver, null);
	}
	
	public function update(elapsed:Float) {
		this.sprite.setPosition(screenPosition.x, screenPosition.y);
		if (selected) {
			this.sprite.color = 0x00ff00;
		} else {
			this.sprite.color = 0xffffff;
		}
		
		this.sprite.update(elapsed);
	}
	
		
	public function onMouseDown(sprite:FlxSprite) {
		grid.onMouseDownLetter(this);
	}
	
	public function onMouseOver(sprite:FlxSprite) {
		grid.onMouseOverLetter(this);
	}
	
	public function get_screenPosition() {
		return new Point(gridPosition.column * letterSize, gridPosition.row * letterSize);
	}
	
	public function get_screenRectangle() {
		return new Rectangle(screenPosition.x, screenPosition.y, letterSize, letterSize);
	}
}