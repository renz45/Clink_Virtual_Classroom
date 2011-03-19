package com.fileAsset.loaders
{	
	import com.fileAsset.events.FileLoaderEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	[Event(name="clientLoaded", type="com.fileAsset.events.FileLoaderEvent")]
	[Event(name="serverLoaded", type="com.fileAsset.events.FileLoaderEvent")]
	[Event(name="cancel", type="flash.events.Event")]
	/**
	 * Loader class used for uploading files to a webserver through flash
	 * This file has a companion php file called upload.php where the upload target path is set via get variables.
	 *  
	 * @author adamrensel
	 * 
	 */	
	public class FileUploader extends EventDispatcher
	{
		
		private var _fileRef:FileReference;
		private var _progressBar:Sprite;
		private var _uploadLocation:String;
		private var _serverSideFileLocation:String;

		/**
		 * the progress bar is an optional argument. The progressbar has it's scaleX property changed 
		 * according to file load progress, so make sure the bar will scale apropriately.
		 *  
		 * @param progressBar
		 * 
		 */		
		public function FileUploader(progressBar:Sprite = null)
		{
			super();
			
			_progressBar = progressBar;
			
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
		/////////////////////////////callbacks//////////////////////
		
		//file is selected
		private function onFileSelected(event:Event):void
		{
			_fileRef.addEventListener(Event.COMPLETE, onFileLoaded);
			_fileRef.addEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			_fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);
			
			if(_progressBar)
			{
				_progressBar.visible = true;
			}
			
			_fileRef.load();
		}
		
		//changes the progress bar to indicate progress
		private function onProgress(e:ProgressEvent):void
		{
			if(_progressBar)
			{
				var percentLoaded:Number = e.bytesLoaded/e.bytesTotal;

				_progressBar.scaleX = percentLoaded;
			}
		}
		
		//when the client loads the file into flash
		private function onFileLoaded(e:Event):void
		{
			_fileRef.removeEventListener(Event.COMPLETE, onFileLoaded);
			_fileRef.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			_fileRef.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			this.dispatchEvent(new FileLoaderEvent(FileLoaderEvent.CLIENT_LOADED));
		}
		
		//if there is an error uploading to the server or client
		private function onFileLoadError(e:Event):void
		{
			_fileRef.removeEventListener(Event.COMPLETE, onFileLoaded);
			_fileRef.removeEventListener(IOErrorEvent.IO_ERROR, onFileLoadError);
			_fileRef.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			
			if(_progressBar)
			{
				_progressBar.visible = false;
			}
			trace("File load error");
		}   
		
		//after the file is successfully uploaded to the server
		private function onserverUploadComplete(e:Event):void
		{
			_progressBar.visible = false;
			
			_fileRef.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_fileRef.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onserverUploadComplete);
			
			this.dispatchEvent(new FileLoaderEvent(FileLoaderEvent.SERVER_LOADED));
		}

		///////////////////////public methods///////////////////////
		
		/**
		 * Call this function first to pop up a browse window to choose a file.
		 * Than other public methods can be called depending on what you want to to do. 
		 * 
		 * This will cause a CLIENT_LOADED event to be dispatched when the file has finished loading.
		 * This will cause a UPLOAD_ERROR event if there is a problem uploading the file.
		 */		
		public function browseForFile():void
		{	
			_fileRef=new FileReference();
			_fileRef.addEventListener(Event.SELECT, onFileSelected);
			
			var imageTypeFilter:FileFilter = new FileFilter("Images","*.jpeg; *.jpg;*.gif;*.png");
			var allTypeFilter:FileFilter = new FileFilter("Any File (*.*)","*.*");
			_fileRef.browse([imageTypeFilter, allTypeFilter]);
		}
		
		/**
		 * Takes the stored file reference uploaded using the browserForFile method and stores it to a folder on the server
		 * This requires a server side script to copy the file to the correct location, set the path to this file by setting the
		 * serverSideFileLocation property
		 * 
		 * This will cause a SERVER_LOADED event to be fired when the file has been uploaded successfully, and a UPLOAD_ERROR
		 * event if there is an upload problem
		 * 
		 * @param path:String path to where the file is to be uploaded to on the webserver
		 * @param fileReference:FileReference option file Reference for uploading a different reference to the server, if this is null, than the internal filereference from browse is used.
		 * 
		 */		
		public function uploadToServer(path:String,fileReference:FileReference = null):void
		{
			if(_serverSideFileLocation)
			{
				//eliminate any spaces
				var filename:String=_fileRef.name.split(" ").join("_");

				var urlRequest:URLRequest = new URLRequest(_serverSideFileLocation + "?path=" + path);
				urlRequest.method = URLRequestMethod.POST;
				
				var fileRef:FileReference;
				
				if(fileReference)
				{
					_fileRef = fileReference;
				}
				_fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);
				_fileRef.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,onserverUploadComplete);
				_fileRef.upload(urlRequest);
				
				
			}else{
				throw new Error("Unable to find the server side script, please set the location of the serverside script which handles the upload with the property - serverSideFileLocation");
			}
		}
		
		/**
		 * returns the fileReference, this can be used with a loader and displayed if it's an image among other things
		 * @return FileReference
		 * 
		 */		
		public function getFileReference():FileReference
		{
			return _fileRef;
		}
		
		/////////////////////////getters/setters////////////////////
		
		/**
		 * Setter for the server side script which handles saving the file to the web server.
		 * this must be set before calling the uploadToServer Method
		 *  
		 * @param loc
		 * 
		 */		
		public function set serverSideFileLocation(loc:String):void
		{
			_serverSideFileLocation = loc;
		}
		
		public function get serverSideFileLocation():String
		{
			return _serverSideFileLocation;
		}
	}
}