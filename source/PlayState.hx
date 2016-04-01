package;

import flixel.FlxState;

class PlayState extends FlxState
{
	var grid:Grid;
	override public function create():Void
	{
		super.create();
		grid = new Grid(8, 8, this);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		grid.update(elapsed);
	}
}
