package com.fileAsset.loaders
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	[Event(name="complete",type="flash.events.Event")]
	public class DeleteServerFile extends EventDispatcher
	{
		private var _scriptPath:String
		
		public function DeleteServerFile(serverSideScriptPath:String)
		{
			_scriptPath = serverSideScriptPath;
			
			init();
		}
		
		private function init():void
		{
			
		}
		
		//////////////////callbacks//////////////////
		private function deleteComplete(e:Event):void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		////////////////////public methods/////////////
		
		public function deleteFile(filePath:String):void
		{
			var urlRequest:URLRequest = new URLRequest(_scriptPath + "?filePath=" + filePath);
			
			var ul:URLLoader = new URLLoader();
			ul.load(urlRequest);
			ul.addEventListener(Event.COMPLETE,deleteComplete);
		}
	
	}
}