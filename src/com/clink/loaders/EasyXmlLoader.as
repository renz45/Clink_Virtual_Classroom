package com.clink.loaders
{
	import com.clink.loaders.loaderEvents.XmlComplete_Event;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(type="com.clink.loaders.loaderEvents.XmlComplete_Event",name="xmlLoaded")]
	/**
	 * class used for loading external XML files. The file path must be passed in as a string. The custom event XmlComplete_Event.XML_LOADED
	 * is dispatched upon file loading completion. The XML file is stored in the event as XML in "event.loadedXML". 
	 * @author adamrensel
	 * 
	 */	
	public class EasyXmlLoader extends EventDispatcher
	{
		public function EasyXmlLoader(path:String)
		{
			var xl:URLLoader = new URLLoader();
			
			xl.load(new URLRequest(path));
			xl.addEventListener(Event.COMPLETE,xmlLoad_CompleteHandler);
		}
		
		private function xmlLoad_CompleteHandler(evt:Event):void
		{
			var e:XmlComplete_Event = new XmlComplete_Event(XmlComplete_Event.XML_LOADED);
			e.loadedXML = XML(URLLoader(evt.currentTarget).data); 
			
			this.dispatchEvent(e);
		}

	}
}