package com.clink.events
{
	import flash.events.Event;
	
	public class BasicButtonEvent extends Event
	{
		public static const BUTTON_UP:String = "buttonUp";
		public static const BUTTON_DOWN:String = "buttonDown";
		
		public function BasicButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new BasicButtonEvent(type,bubbles,cancelable);
		}
	}
}