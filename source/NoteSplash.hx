package;

import flixel.FlxSprite;

class NoteSplash extends FlxSprite
{
    public function new(X:Float, Y:Float, direction:Int)
    {
        super(X,Y);
        frames = Paths.getSparrowAtlas('noteSplashes');
        switch(direction)
        {
            case 0: randomAnim('purple');
            case 1: randomAnim('blue');
            case 2: randomAnim('green');
            case 3: randomAnim('red');
        }
    }
    
    public function randomAnim(direction:String)
    {
        animation.addByPrefix('idle', direction, 24, false);
        animation.play('idle');
        antialiasing = true;
        alpha = 0.69;
        updateHitbox();
        scrollFactor.set();
        if(direction == 'purple' || direction == 'red')
            offset.set(0.291 * this.width, 0.315 * this.height);
        else
            offset.set(0.33 * this.width, 0.315 * this.height);

        animation.finishCallback = function(t){
			kill();
		}
    }
}