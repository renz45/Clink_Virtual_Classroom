package com.clink.module
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.events.ModuleButtonEvent;
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.loaders.EasyXmlLoader;
	import com.clink.loaders.loaderEvents.XmlComplete_Event;
	import com.clink.main.ClinkMain;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.ui.LayoutBox;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_ModuleApi;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.MouseCursor;
	
	public class Module_Controller extends Sprite
	{
		private var _moduleApiInfo:VO_ModuleApi;
		private var _moduleInfoList:Object;
		private var _moduleList:Array;
		
		private var _tabList:LayoutBox;
		private var _moduleCanvas:Sprite;
		
		private var _moduleSO:Manager_remoteCommonSharedObject;
		
		public function Module_Controller(moduleApiInfo:VO_ModuleApi)
		{
			super();
			
			_moduleApiInfo = moduleApiInfo;
			
			init();
		}
		
		private function init():void
		{
			//init arrays and statics
			_moduleList = [];
			_moduleInfoList = {};
			ModuleButton.init();
			
			//load the moduleConfig.xml
			var exl:EasyXmlLoader = new EasyXmlLoader(_moduleApiInfo.modulePath + "moduleConfig.xml");
			exl.addEventListener(XmlComplete_Event.XML_LOADED,onXmlLoaded);
			
			//new tablist
			_tabList = new LayoutBox(false,1);
			this.addChild(_tabList);
			
			//module bg
			_moduleCanvas = Factory_prettyBox.drawPrettyBox(729,570,uint(DrawingUtils.fixColorCode(_moduleApiInfo.basicButton_downStateColor)));
			this.addChild(_moduleCanvas);
			
			//enable dragging
			var dragger:Controller_Dragable = new Controller_Dragable(this,_tabList);
			
			//create sharedObject which will add tab focus functionality
			var template:Object = {isFocusOn:false,focusTarget:"null"};
			
			_moduleSO = new Manager_remoteCommonSharedObject("moduleSO",template,_moduleApiInfo.netConnection);
			_moduleSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onModuleSOChange);
			_moduleSO.addEventListener(SharedObjectEvent.CHANGED,onModuleSOChange);
		}
		
		private function updateModuleList():void
		{
			//loop through the list of modules and look for a button with the same module name
			for each(var bm:BaseModule in _moduleList)
			{
				var exists:Boolean = false;
				for each(var mb:ModuleButton in _tabList.items)
				{
					if(mb.moduleName == bm.moduleName)
					{
						exists = true;
						break;
					}
				}
				
				//if the name doesn't exist than create a new module button and store the module in the button
				if(!exists)
				{
					var modBtn:ModuleButton = new ModuleButton(bm.moduleName,uint(DrawingUtils.fixColorCode(_moduleApiInfo.basicButton_labelColor)),uint(DrawingUtils.fixColorCode(_moduleApiInfo.basicButton_upStateColor)),uint(DrawingUtils.fixColorCode(_moduleApiInfo.basicButton_downStateColor)), _moduleApiInfo.userPermission);
					modBtn.addEventListener(MouseEvent.CLICK,onClick);
					modBtn.module = bm;
					modBtn.moduleName = bm.moduleName;
					
					if(_moduleApiInfo.userPermission == ClinkMain.TEACHER_PERMISSION)
					{
						modBtn.addEventListener(ModuleButtonEvent.FOCUS_THIS,onModuleFocus);
					}
					
					_tabList.addChild(modBtn);
					exists = false;
				}
			}
			(_tabList.items[0] as ModuleButton).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			_moduleCanvas.y = _tabList.height - 2;
		}
		
		
		///////////////////////////////callbacks/////////////////////////////////
		
		private function onModuleSOChange(e:SharedObjectEvent):void
		{
			if(e.propertyName == "focusTarget")
			{
				if(e.propertyValue != "false" && e.propertyValue != "null")
				{	
					for each(var mb:ModuleButton in _tabList.items)
					{
						if(mb.moduleName == e.propertyValue)
						{
							mb.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
							_moduleSO.setProperty("focusTarget", "false");
						}
					}
				}
			}
			
		}
		
		//focus a module on all screens if a teacher clicks the focus button
		private function onModuleFocus(e:ModuleButtonEvent):void
		{
			_moduleApiInfo.textChat.addToChat((e.currentTarget as ModuleButton).moduleName + " has been focused",_moduleApiInfo.username);
			_moduleSO.setProperty("focusTarget", (e.currentTarget as ModuleButton).moduleName);
		}
		
		//when a button is clicked, set all the other buttons to up, remove all the children from the module canvas and add the module
		//stored within the button to the module canvas
		private function onClick(e:MouseEvent):void
		{
			if((e.currentTarget as ModuleButton).module.parent != _moduleCanvas)
			{
				while(_moduleCanvas.numChildren > 0)
				{
					(_moduleCanvas.getChildAt(0) as IModule).disconnect();
					_moduleCanvas.removeChildAt(0);
				}
				
				var mod:BaseModule = (e.currentTarget as ModuleButton).module;
				(mod as IModule).connect();
				_moduleCanvas.addChild(mod);
			}
		}
		
		private function onXmlLoaded(e:XmlComplete_Event):void
		{
			//load the xml and loop through all the modules specified, load each external swf file.
			for each(var xml:XML in e.loadedXML.module)
			{
				_moduleInfoList[xml.name] = {moduleAssets:_moduleApiInfo.modulePath + (xml.moduleAssets).toString(), moduleStorage:_moduleApiInfo.modulePath + (xml.moduleStorage).toString(), name:(xml.name).toString()};
				
				var l:Loader = new Loader();
				
				l.load(new URLRequest(_moduleApiInfo.modulePath + (xml.swfPath).toString()));
				l.contentLoaderInfo.addEventListener(Event.COMPLETE,onModuleLoadComplete);
			}
		}
		
		//after the module is loaded set all the stored variables, paths to module assets and module storage
		private function onModuleLoadComplete(e:Event):void
		{
			var mod:BaseModule = LoaderInfo(e.currentTarget).content as BaseModule;
			mod.assetsPath = _moduleInfoList[mod.moduleName]["moduleAssets"];
			mod.storagePath = _moduleInfoList[mod.moduleName]["moduleStorage"];
			_moduleInfoList[mod.moduleName]["module"] = mod;
			_moduleApiInfo.moduleList = _moduleInfoList;
			mod.moduleApiSettings = _moduleApiInfo;
			_moduleList.push(mod);
			
			
			updateModuleList();
		}
	}
}