package com.critique.events
{
	import flash.events.Event;
	
	public class DrawingObjectEvent extends Event
	{
		public static const UPDATE:String = "update";
		
		public function DrawingObjectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new DrawingObjectEvent(type, bubbles, cancelable);
		}
	}
}