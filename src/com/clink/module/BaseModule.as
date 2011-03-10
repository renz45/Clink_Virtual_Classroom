package com.clink.module
{
	import com.clink.factories.Factory_prettyBox;
	import com.clink.valueObjects.VO_ModuleApi;
	
	import flash.display.Sprite;
	
	public class BaseModule extends Sprite
	{
		private var _moduleApi:VO_ModuleApi;
		private var _name:String;
		private var _assetsPath:String;
		private var _storagePath:String;
		
		public function BaseModule()
		{
			super();	
		}
		
		/**
		 * override this function and place your beginning initial code here, don't call this function from the constructor
		 * 
		 */
		public function init():void
		{
			
		}
		
		///////////////getters/setters////////////////
		public function set moduleApiSettings(moduleVO:VO_ModuleApi):void
		{
			_moduleApi = moduleVO;
			init();
			
		}
		
		public function get moduleApiSettings():VO_ModuleApi
		{
			return _moduleApi;
		}
		
		public function set moduleName(name:String):void
		{
			_name = name;
		}
		
		public function get moduleName():String
		{
			return _name;
		}
		
		public function set assetsPath(path:String):void
		{
			_assetsPath = path;
		}
		
		public function get assetsPath():String
		{
			return _assetsPath;
		}
		
		public function set storagePath(path:String):void
		{
			_storagePath = path;
		}
		
		public function get storagePath():String
		{
			return _storagePath;
		}
	}
}