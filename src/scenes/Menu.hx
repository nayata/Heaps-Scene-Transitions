package scenes;


class Menu extends h2d.Scene {
	var background:h2d.Bitmap;

    
	public function new() {
		super();

		background = new h2d.Bitmap(h2d.Tile.fromColor(0xc51162, Main.ME.s2d.width, Main.ME.s2d.height), this);

		var font = hxd.res.DefaultFont.get();

		var title = new h2d.Text(font, this);
		title.text = "Menu Scene";
		title.scale(3);
		title.x = title.y = 60;

		var ts = new h2d.Text(font, this);
		ts.text = "SCENE MANAGEMENT\nHeaps game engine scene transitions";
		ts.scale(1);
		ts.x = 60; ts.y = 160;


		var button = new h2d.Interactive(200, 80, this); 
		button.backgroundColor = 0xFFFFFFFF;
		button.x = 60; button.y = 320;

		var bt = new h2d.Text(font, button);
		bt.text = "PLAY";
		bt.textColor =  0xc51162;
		bt.textAlign = h2d.Text.Align.Center;
		bt.scale(2);
		bt.x = 100; bt.y = 24;

		button.onOut = function(e){
			button.alpha = 1;
		};
		button.onOver = function(e){
			button.alpha = 0.9;
		};
		button.onClick  = function(event:hxd.Event) {
			Main.ME.changeScene(new Game());
		};
	}

	override public function checkResize() {
		super.checkResize();

		background.width = Main.ME.s2d.width;
		background.height = Main.ME.s2d.height;
	}
}