package com.fileAsset.events
{
	import flash.events.Event;
	
	public class FileLoaderEvent extends Event
	{
		public static const CLIENT_LOADED:String = "clientLoaded";
		public static const SERVER_LOADED:String = "serverLoaded";
		public static const UPLOAD_ERROR:String = "uploadError";
		
		public var errorMessage:String;
		
		public function FileLoaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new FileLoaderEvent(type, bubbles, cancelable);
		}
	}
}