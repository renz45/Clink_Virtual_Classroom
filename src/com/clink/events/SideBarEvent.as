package com.clink.events
{
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	
	import flash.events.Event;
	
	public class SideBarEvent extends Event
	{
		public static const USER_SO_LOADED:String = "userSoLoaded";
		public static const CHAT_SO_LOADED:String = "chatSoLoaded";
		
		public var userSO:Manager_remoteUserSharedObject;
		public var chatSO:Manager_remoteCommonSharedObject;
		
		public function SideBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new SideBarEvent(type, bubbles, cancelable);
		}
	}
}