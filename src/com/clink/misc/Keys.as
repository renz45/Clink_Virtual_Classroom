package com.clink.misc
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	/**
	 * This class is used for detecting key presses. The public function init must be executed first with a stage reference.
	 * Than the public static var keys can be accessed where keys is an array and keys[keyCode] will return a true or false boolean value
	 * which can be used in a conditional.  Example usage: if(Keys.keys[Keyboard.UP]){do this} 
	 * @author adamrensel
	 * 
	 */	
	public class Keys
	{
		public static var keys:Array;
		
		public function Keys()
		{
			
		}
		/**
		 * gives the keys class a stage reference and adds the keyboard event listeners. 
		 * @param st
		 * 
		 */		
		public static function init(st:Stage):void
		{
			keys = [];
			
			for(var i:int = 0; i < 100; i++)
			{
				keys[i] = 0;
			}
			
			st.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			st.addEventListener(KeyboardEvent.KEY_UP,keyUp);
		}
		
		private static function keyDown(evt:KeyboardEvent):void
		{
			keys[evt.keyCode] = 1;
		}
		private static function keyUp(evt:KeyboardEvent):void
		{
			keys[evt.keyCode] = 0;
			
		}
	}
}