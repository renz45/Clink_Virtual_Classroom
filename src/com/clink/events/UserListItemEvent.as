package com.clink.events
{
	import flash.events.Event;
	
	public class UserListItemEvent extends Event
	{
		
		public static const TEACHER_CALLED_ON:String = "teacherCalledOn";
		public static const HIDDEN:String = "hidden";
		public static const VISIBLE:String = "visible";
		
		public var userId:Number;
		
		public function UserListItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new UserListItemEvent(type,bubbles,cancelable);
		}
	}
}