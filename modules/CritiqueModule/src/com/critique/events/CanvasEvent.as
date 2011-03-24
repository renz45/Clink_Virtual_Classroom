package com.critique.events
{
	import flash.events.Event;
	
	public class CanvasEvent extends Event
	{
		
		public function CanvasEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new CanvasEvent(type,bubbles,cancelable);
		}
	}
}