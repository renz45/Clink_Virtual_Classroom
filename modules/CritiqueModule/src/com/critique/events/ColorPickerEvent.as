package com.critique.events
{
	import flash.events.Event;
	
	public class ColorPickerEvent extends Event
	{
		public static var COLOR_CHOSEN:String = "colorChosen";
		
		public var color:uint;
		
		public function ColorPickerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ColorPickerEvent(type,bubbles,cancelable);
		}
	}
}