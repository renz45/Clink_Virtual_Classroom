package com.clink.loaders
{
	import com.clink.loaders.loaderEvents.ImageComplete_Event;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	[Event(type="com.fs.loaders.loaderEvents.ImageComplete_Event",name="imageLoaded")]
	/**
	 * Class which loads an external image. The path to the file needs to be passed in as a string. A custom event is dispatched upon load completion.
	 * The ImageComplete_Event.IMAGE_LOADED event is dispatched with the image data stored as a bitmap in "event.imageLoaded"
	 *  
	 * @author adamrensel
	 * 
	 */	
	public class EasyImageLoader extends EventDispatcher
	{
		public function EasyImageLoader(path:String)
		{
			super();
			
			var ld:Loader = new Loader();
			ld.load(new URLRequest(path));
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,loading_completeHandler);
			
			
		}
		
		private function loading_completeHandler(evt:Event):void
		{
			var e:ImageComplete_Event = new ImageComplete_Event(ImageComplete_Event.IMAGE_LOADED);
			e.imageLoaded = LoaderInfo(evt.currentTarget).content as Bitmap;
			this.dispatchEvent(e);
		}
		
	}
}