package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitRight2:FlxSprite;
	var portraitRight3:FlxSprite;
	var portraitRight4:FlxSprite;
	var portraitRight5:FlxSprite;
	var portraitRight6:FlxSprite;
	var portraitRight7:FlxSprite;
	var portraitLeft8:FlxSprite;
	var portraitLeft9:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitRight10:FlxSprite;
	var portraitRight11:FlxSprite;
	var portraitRight12:FlxSprite;
	var portraitRight13:FlxSprite;
	var portraitRight14:FlxSprite;
	var portraitRight15:FlxSprite;
	var portraitLeft16:FlxSprite;
	var portraitLeft17:FlxSprite;
	var portraitLeft18:FlxSprite;
	var portraitLeft19:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 20);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'bad-gateway' | 'not-found' | 'service-unavailable':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 14, true);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		if (PlayState.SONG.song.toLowerCase()=='senpai' || PlayState.SONG.song.toLowerCase()=='roses' || PlayState.SONG.song.toLowerCase()=='thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}	
		else if (PlayState.SONG.song.toLowerCase()=='bad-gateway' || PlayState.SONG.song.toLowerCase()=='not-found' || PlayState.SONG.song.toLowerCase()=='service-unavailable')
		{
			portraitLeft = new FlxSprite(0, 100);
			portraitLeft.frames = Paths.getSparrowAtlas('yukichi_portraits');
			portraitLeft.animation.addByPrefix('enter', 'yukichi_talking enter', 24, false);
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;		
		}
		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		portraitRight2 = new FlxSprite(960, 130);
		portraitRight2.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight2.animation.addByPrefix('enter', 'boyfriend_neutral enter', 24, false);
		portraitRight2.updateHitbox();
		portraitRight2.scrollFactor.set();
		add(portraitRight2);
		portraitRight2.visible = false;
		
		portraitRight4 = new FlxSprite(960, 130);
		portraitRight4.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight4.animation.addByPrefix('enter', 'boyfriend_hype enter', 24, false);
		portraitRight4.updateHitbox();
		portraitRight4.scrollFactor.set();
		add(portraitRight4);
		portraitRight4.visible = false;
		
		portraitRight7 = new FlxSprite(960, 130);
		portraitRight7.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight7.animation.addByPrefix('enter', 'boyfriend_question enter', 24, false);
		portraitRight7.updateHitbox();
		portraitRight7.scrollFactor.set();
		add(portraitRight7);
		portraitRight7.visible = false;
		
		portraitRight10 = new FlxSprite(960, 130);
		portraitRight10.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight10.animation.addByPrefix('enter', 'boyfriend_guilt enter', 24, false);
		portraitRight10.updateHitbox();
		portraitRight10.scrollFactor.set();
		add(portraitRight10);
		portraitRight10.visible = false;
		
		portraitRight11 = new FlxSprite(960, 130);
		portraitRight11.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight11.animation.addByPrefix('enter', 'boyfriend_pensive enter', 24, false);
		portraitRight11.updateHitbox();
		portraitRight11.scrollFactor.set();
		add(portraitRight11);
		portraitRight11.visible = false;
		
		portraitRight12 = new FlxSprite(960, 130);
		portraitRight12.frames = Paths.getSparrowAtlas('boyfriend_portraits');
		portraitRight12.animation.addByPrefix('enter', 'boyfriend_determined enter', 24, false);
		portraitRight12.updateHitbox();
		portraitRight12.scrollFactor.set();
		add(portraitRight12);
		portraitRight12.visible = false;
		
		portraitRight3 = new FlxSprite(960, 130);
		portraitRight3.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight3.animation.addByPrefix('enter', 'girlfriend_talking enter', 24, false);
		portraitRight3.updateHitbox();
		portraitRight3.scrollFactor.set();
		add(portraitRight3);
		portraitRight3.visible = false;
		
		portraitRight5 = new FlxSprite(960, 130);
		portraitRight5.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight5.animation.addByPrefix('enter', 'girlfriend_nervous_smile enter', 24, false);
		portraitRight5.updateHitbox();
		portraitRight5.scrollFactor.set();
		add(portraitRight5);
		portraitRight5.visible = false;
		
		portraitRight6 = new FlxSprite(960, 130);
		portraitRight6.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight6.animation.addByPrefix('enter', 'girlfriend_confused enter', 24, false);
		portraitRight6.updateHitbox();
		portraitRight6.scrollFactor.set();
		add(portraitRight6);
		portraitRight6.visible = false;
		
		portraitRight13 = new FlxSprite(960, 130);
		portraitRight13.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight13.animation.addByPrefix('enter', 'girlfriend_neutral enter', 24, false);
		portraitRight13.updateHitbox();
		portraitRight13.scrollFactor.set();
		add(portraitRight13);
		portraitRight13.visible = false;
		
		portraitRight14 = new FlxSprite(960, 130);
		portraitRight14.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight14.animation.addByPrefix('enter', 'girlfriend_guilt enter', 24, false);
		portraitRight14.updateHitbox();
		portraitRight14.scrollFactor.set();
		add(portraitRight14);
		portraitRight14.visible = false;
		
		portraitRight15 = new FlxSprite(960, 130);
		portraitRight15.frames = Paths.getSparrowAtlas('girlfriend_portraits');
		portraitRight15.animation.addByPrefix('enter', 'girlfriend_pensive enter', 24, false);
		portraitRight15.updateHitbox();
		portraitRight15.scrollFactor.set();
		add(portraitRight15);
		portraitRight15.visible = false;
		
		portraitLeft8 = new FlxSprite(10, 100);
		portraitLeft8.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft8.animation.addByPrefix('enter', 'yukichi_happy enter', 24, false);
		portraitLeft8.updateHitbox();
		portraitLeft8.scrollFactor.set();
		add(portraitLeft8);
		portraitLeft8.visible = false;	
		
		portraitLeft9 = new FlxSprite(10, 100);
		portraitLeft9.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft9.animation.addByPrefix('enter', 'yukichi_talking2 enter', 24, false);
		portraitLeft9.updateHitbox();
		portraitLeft9.scrollFactor.set();
		add(portraitLeft9);
		portraitLeft9.visible = false;	
		
		portraitLeft2 = new FlxSprite(10, 100);
		portraitLeft2.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft2.animation.addByPrefix('enter', 'yukichi_talking enter', 24, false);
		portraitLeft2.updateHitbox();
		portraitLeft2.scrollFactor.set();
		add(portraitLeft2);
		portraitLeft2.visible = false;	
		
		portraitLeft16 = new FlxSprite(10, 100);
		portraitLeft16.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft16.animation.addByPrefix('enter', 'yukichi_peeved enter', 24, false);
		portraitLeft16.updateHitbox();
		portraitLeft16.scrollFactor.set();
		add(portraitLeft16);
		portraitLeft16.visible = false;	
		
		portraitLeft17 = new FlxSprite(10, 100);
		portraitLeft17.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft17.animation.addByPrefix('enter', 'yukichi_very_peeved enter', 24, false);
		portraitLeft17.updateHitbox();
		portraitLeft17.scrollFactor.set();
		add(portraitLeft17);
		portraitLeft17.visible = false;	
		
		portraitLeft18 = new FlxSprite(10, 100);
		portraitLeft18.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft18.animation.addByPrefix('enter', 'yukichi_enraged enter', 24, false);
		portraitLeft18.updateHitbox();
		portraitLeft18.scrollFactor.set();
		add(portraitLeft18);
		portraitLeft18.visible = false;
		
		portraitLeft19 = new FlxSprite(10, 100);
		portraitLeft19.frames = Paths.getSparrowAtlas('yukichi_portraits');
		portraitLeft19.animation.addByPrefix('enter', 'yukichi_very_enraged enter', 24, false);
		portraitLeft19.updateHitbox();
		portraitLeft19.scrollFactor.set();
		add(portraitLeft19);
		portraitLeft19.visible = false;	
		
		if(PlayState.curStage != 'planetyo' && PlayState.curStage != 'gr'){
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		}
		box.updateHitbox();
		box.screenCenter(X);
		add(box);
		box.animation.play('normalOpen');

		portraitLeft.screenCenter(X);
		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(102, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Arial Bold Italic';
		dropText.color = 0xEC85E8;
		add(dropText);

		swagDialogue = new FlxTypeText(100, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Arial Bold Italic';
		swagDialogue.color = 0xFFFFFF;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);
		

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		else if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		else if (PlayState.SONG.song.toLowerCase() == 'bad-gateway')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.MAGENTA;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfunpixel':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight7.visible = false;
				portraitRight3.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitLeft9.visible = false;
				portraitLeft8.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight2.visible)
				{
					portraitRight2.visible = true;
					portraitRight2.animation.play('enter');
				}
			case 'bfhype':
				portraitLeft.visible = false;
				portraitLeft9.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight4.visible)
				{
					portraitRight4.visible = true;
					portraitRight4.animation.play('enter');
				}
			case 'bfquestion':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitLeft9.visible = false;
				portraitLeft8.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight7.visible)
				{
					portraitRight7.visible = true;
					portraitRight7.animation.play('enter');
				}
			case 'bfguilt':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitLeft9.visible = false;
				portraitLeft8.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight10.visible)
				{
					portraitRight10.visible = true;
					portraitRight10.animation.play('enter');
				}
			case 'bfpensive':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitLeft9.visible = false;
				portraitLeft8.visible = false;
				portraitLeft2.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight11.visible)
				{
					portraitRight11.visible = true;
					portraitRight11.animation.play('enter');
				}
			case 'bfdetermined':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitLeft9.visible = false;
				portraitLeft8.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight12.visible)
				{
					portraitRight12.visible = true;
					portraitRight12.animation.play('enter');
				}
			case 'gf':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitLeft9.visible = false;
				portraitRight2.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight3.visible)
				{
					portraitRight3.visible = true;
					portraitRight3.animation.play('enter');
				}
			case 'gfnervoussmile':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitLeft9.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight5.visible)
				{
					portraitRight5.visible = true;
					portraitRight5.animation.play('enter');
				}
			case 'gfconfused':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitLeft9.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight6.visible)
				{
					portraitRight6.visible = true;
					portraitRight6.animation.play('enter');
				}
			case 'gfneutral':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitLeft9.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight13.visible)
				{
					portraitRight13.visible = true;
					portraitRight13.animation.play('enter');
				}
			case 'gfguilt':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitLeft9.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight14.visible)
				{
					portraitRight14.visible = true;
					portraitRight14.animation.play('enter');
				}
			case 'gfpensive':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitLeft9.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitRight15.visible)
				{
					portraitRight15.visible = true;
					portraitRight15.animation.play('enter');
				}
			case 'yukichihappy':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft9.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft8.visible)
				{
					portraitLeft8.visible = true;
					portraitLeft8.animation.play('enter');
				}
			case 'yukichitalk2':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitLeft2.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft9.visible)
				{
					portraitLeft9.visible = true;
					portraitLeft9.animation.play('enter');
				}
			case 'yukichitalk':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft2.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
				}
			case 'yukichipeeved':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft16.visible)
				{
					portraitLeft16.visible = true;
					portraitLeft16.animation.play('enter');
				}
			case 'yukichiverypeeved':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft18.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft17.visible)
				{
					portraitLeft17.visible = true;
					portraitLeft17.animation.play('enter');
				}
			case 'yukichienraged':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft19.visible = false;
				if (!portraitLeft18.visible)
				{
					portraitLeft18.visible = true;
					portraitLeft18.animation.play('enter');
				}
			case 'yukichiveryenraged':
				portraitLeft.visible = false;
				portraitRight4.visible = false;
				portraitRight5.visible = false;
				portraitRight6.visible = false;
				portraitRight7.visible = false;
				portraitLeft8.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight11.visible = false;
				portraitRight10.visible = false;
				portraitRight12.visible = false;
				portraitRight13.visible = false;
				portraitRight14.visible = false;
				portraitRight15.visible = false;
				portraitLeft16.visible = false;
				portraitLeft17.visible = false;
				portraitLeft18.visible = false;
				if (!portraitLeft19.visible)
				{
					portraitLeft19.visible = true;
					portraitLeft19.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
