import h2d.Scene;

import scenes.*;


class Main extends hxd.App {
	public static var ME:Main;

	// ScreenTransition
	public var transition:ScreenTransition;

	// Return true if transition currently working
	public var locked(get, never):Bool;
	inline function get_locked() return transition.working;


	static function main() {
		ME = new Main();
	}


	/** 
		Create ScreenTransition with link to current hxd.App
		First scene goes without transition, but you can change it to: changeScene(yourFirstScene);
	**/

	override function init() {
		transition = new ScreenTransition(this);
		
		setScene(new Menu());
	}


	/**
		ScreenTransition have protection from multiply clicks/scene creation if transition alredy working
		By default current scene mouse events will be removed. New scene events will be locked during transition and unlocked at transition end
		Transition start with given params: fadeIn/fadeOut time, interval time between them, new h2d.Scene instance.
	**/

	public function changeScene(scene:h2d.Scene) {
		transition.change(0.34, 0.17, scene);
	}


	// If transition working - render transition on top s2d scene
	override public function render(e:h3d.Engine) {
		super.render(e);

		if (transition.working) transition.render(e);
	}
	

	// Update transition
	override function update(delta:Float) {
		super.update(delta);
		
		transition.update(delta);
	}


	// Transition resize
	override function onResize() {
		super.onResize();

		if (s2d != null) s2d.checkResize();

		transition.checkResize();
		transition.onResize();
	}
 }