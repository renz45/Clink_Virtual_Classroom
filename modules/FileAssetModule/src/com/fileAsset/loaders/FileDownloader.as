package com.fileAsset.loaders
{
	import com.clink.valueObjects.VO_ModuleApi;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	
	[Event(name="complete", type="flash.events.Event")]
	
	public class FileDownloader extends EventDispatcher
	{
		private var _progressBar:Sprite;
		
		public function FileDownloader(progressBar:Sprite = null)
		{
			if(_progressBar)
			{
				_progressBar = progressBar;
			}
			
			init();
		}
		
		private function init():void
		{
			if(_progressBar)
			{
				_progressBar.visible = true;
				_progressBar.scaleX = 0;
			}
		}
		
		///////////////////////Callbacks///////////////////
		private function onIOError(e:IOErrorEvent):void
		{
			trace(e.target.data);
		}
		
		private function downloadComplete(e:Event):void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function downloadProgress(e:ProgressEvent):void
		{
			if(_progressBar)
			{
				var percentLoaded:Number = e.bytesLoaded/e.bytesTotal;
				
				_progressBar.scaleX = percentLoaded;
			}
		}
		
		//////////////////public methods////////////////
		public function downLoadFileToDesktop(path:String):void
		{
			var  ur:URLRequest = new URLRequest("../../"+path);
			
			var fr:FileReference = new FileReference();

			fr.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			fr.addEventListener(Event.COMPLETE,downloadComplete);
			fr.addEventListener(ProgressEvent.PROGRESS,downloadProgress);
			fr.download(ur);
		}
	}
}