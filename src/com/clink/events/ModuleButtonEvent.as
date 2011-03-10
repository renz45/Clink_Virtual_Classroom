package com.clink.events
{
	import flash.events.Event;
	
	public class ModuleButtonEvent extends Event
	{
		public static const FOCUS_THIS:String = "focusThis";
		
		public function ModuleButtonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new ModuleButtonEvent(type,bubbles,cancelable);
		}
	}
}