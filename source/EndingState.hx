package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;

class EndingState extends MusicBeatState
{
	var accuracy:Float = 0;
	public function new(acc:Float){ 
	super();
	accuracy = acc;
	}
    override function create()
    {
        FlxG.sound.playMusic(Paths.music('freakyMenu'));

		var img:String = 'yukichi good ending';
		if(accuracy <= 60.00)
		{
			img = 'yukichi bad ending'; // file names
		}
        var pic:FlxSprite = new FlxSprite(0,0).loadGraphic(Paths.image(img, 'shared'));
        pic.antialiasing = true;
        add(pic);
    }

    override function update(elapsed:Float)
    {
        if(controls.ACCEPT)
            FlxG.switchState(new MainMenuState());
    }
}