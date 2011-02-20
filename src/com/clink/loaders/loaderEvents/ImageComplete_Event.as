package com.clink.loaders.loaderEvents
{
	import flash.display.Bitmap;
	import flash.events.Event;

	public class ImageComplete_Event extends Event
	{
		public var imageLoaded:Bitmap;
		
		public static const IMAGE_LOADED:String = "imageLoaded";
		
		public function ImageComplete_Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ImageComplete_Event(type,bubbles,cancelable);
		}
		
	}
}