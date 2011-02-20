package com.clink.loaders.loaderEvents
{
	import flash.events.Event;

	public class XmlComplete_Event extends Event
	{
		public var loadedXML:XML;
		
		public static const XML_LOADED:String = "xmlLoaded";
		
		public function XmlComplete_Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new XmlComplete_Event(type,bubbles,cancelable);
		}
		
	}
}