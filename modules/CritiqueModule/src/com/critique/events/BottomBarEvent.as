package com.critique.events
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class BottomBarEvent extends Event
	{
		public static var IMAGE_LOADED:String = "imageLoaded";
		
		public var image:Bitmap;
		
		public function BottomBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new BottomBarEvent(type, bubbles, cancelable);
		}
	}
}