enum State {
	FADEIN;
	WAITING;
	FADEOUT;
	LOCKED;
}


class ScreenTransition extends h2d.Scene {
	public var working:Bool = false;

	var app:hxd.App;
	var background:h2d.Bitmap;

	var fade:Int = 10;
	var wait:Int = 10;

	var onReady: Void->Void;
	var onEnd: Void->Void;
	
	var state:State = LOCKED;
	var frame:Int = 0;

	var ease:Float = 0;


	public function new(a:hxd.App) {
		super();

		app = a;

		background = new h2d.Bitmap(h2d.Tile.fromColor(0, app.s2d.width, app.s2d.height), this);
		background.alpha = 0;
	}


	public function change(?fadetime:Float = 0.5, ?waittime:Float = 0.25, scene:h2d.Scene) {
		if (working) return;

		working = true;
        
		fade = Std.int(fadetime * hxd.Timer.wantedFPS);
		wait = Std.int(waittime * hxd.Timer.wantedFPS);

		if (app.s2d != null) app.sevents.removeScene(app.s2d);

		onReady = function() {
			app.setScene(scene);
			app.sevents.removeScene(scene);
		};

		onEnd = function() {
			app.sevents.addScene(scene);
		};

		state = FADEIN;
		frame = 0;
	}


	public function update(dt:Float) {
		if (!working) return;

		if (state == FADEOUT) {
			ease = frame / fade;
			frame++;
				
			background.alpha = 1 - 1 * ease; 

			if (frame > fade) {
				if (onEnd != null) onEnd();
				onEnd = null;

				working = false;
				state = LOCKED;
			}
		}
		else if (state == WAITING) {
			if (wait-- <= 0) state = FADEOUT;
		}
		else if (state == FADEIN) {
			ease = frame / fade;
			frame++;

			background.alpha = 1 * ease; 

			if (frame > fade) {
				if (onReady != null) onReady();
				onReady = null;

				state = wait > 0 ? WAITING : FADEOUT;
				frame = 0;
			}
		}
	}


	public function onResize() {
		if (app.s2d == null) return;

		background.width = app.s2d.width;
		background.height = app.s2d.height;
	}
}