package com.clink.events
{
	import flash.events.Event;
	
	import flashx.textLayout.elements.OverflowPolicy;
	
	public class UserSharedObjectEvent extends Event
	{
		public static const CONNECTED:String = "connected";
		public static const CHANGED:String = "changed";
		public static const CLIENT_CHANGED:String = "clientChanged";
		public static const DELETED:String = "deleted";
		
		public var sharedObjectSlot:String;
		public var attributeName:String;
		public var attributeValue:String;
		
		public function UserSharedObjectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new UserSharedObjectEvent(type,bubbles,cancelable);
		}
	}
}