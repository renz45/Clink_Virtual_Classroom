package com.fileAsset.loaders
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	[Event(name="complete",type="flash.events.Event")]
	
	public class LoadFileNames extends EventDispatcher 
	{
		private var _fileNameList:Array;
		private var _pathToServerScript:String;
		private var _pathToReadDir:String;
		private var _callback:Function;
		
		public function LoadFileNames()
		{
			init();
		}
		
		private function init():void
		{
			_fileNameList = [];
		}
		
		private function readDirectory(pathToScript:String,pathToReadDir:String):void
		{
			var ul:URLLoader = new URLLoader();
			var req:URLRequest = new URLRequest(pathToScript + "?path=" + pathToReadDir);
			
			ul.addEventListener(Event.COMPLETE, onDirListComplete);
			ul.load(req);
		}
		
		/////////////////////////////Callbacks/////////////////////////
		private function onDirListComplete(e:Event):void
		{
			_fileNameList = (e.target.data as String).split("##");
			
			//try catch is used to suppress the null object error if the function is null
			//flash doesn't have a boolean representation for functions apperently
			//split off the _callback execution because I didn't want any errors to get caught here, instead i want them caught in the callback.
			var isNull:Boolean = true;
			try{
				if(_callback != null)
				{
					isNull = false;
				}
			}catch(e:Error){trace("complete: "+e);}
				
			if(!isNull)
			{
				_callback(_fileNameList);
			}
			
			
			
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		///////////////////////////public methods//////////////////////
		public function readDir(pathToServerScript:String, pathToReadDir:String,callBackFunction:Function = null):void
		{
			//try catch is used to suppress the null object error if the function is null
			//flash doesn't have a boolean representation for functions apperently
			try{
				if(callBackFunction != null)
				{
					_callback = callBackFunction;
				}
			}catch(e:Error){trace("readDir: "+e);}
			
			_pathToServerScript = pathToServerScript;
			_pathToReadDir = pathToReadDir;
			
			readDirectory(_pathToServerScript,_pathToReadDir);
		}
		
		public function updateFileNameList(callBackFunction:Function = null):void
		{
			
			_callback = callBackFunction;
			
			
			readDirectory(_pathToServerScript,_pathToReadDir);
		}
		
		public function get fileNames():Array
		{
			return _fileNameList;
		}
	}
}