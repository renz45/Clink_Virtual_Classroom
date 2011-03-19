package com.critique.ui
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.loaders.EasyImageLoader;
	import com.clink.loaders.loaderEvents.ImageComplete_Event;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.ui.SortingScrollList;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_ModuleApi;
	import com.critique.controllers.MultiButton;
	import com.critique.events.BottomBarEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import lib.bottomNav;
	
	[Event(name="imageLoaded", type="com.critique.events.BottomBarEvent")]
	
	public class BottomBar extends bottomNav
	{
		private var _moduleAPI:VO_ModuleApi;
		
		private var _genericInfoSO:Manager_remoteCommonSharedObject;
		
		private var _chooseFileList:SortingScrollList;
		
		override public function BottomBar(genericInfo:Manager_remoteCommonSharedObject, moduleAPI:VO_ModuleApi)
		{
			super();
			
			_genericInfoSO = genericInfo;
			_moduleAPI = moduleAPI;
			init();
		}
		
		private function init():void
		{
			var btnPublicEditController:MultiButton = new MultiButton(this.btn_disable, true, true);
			this.btn_disable.addEventListener(MouseEvent.CLICK,onDisableClick);
			
			var btnSaveController:MultiButton = new MultiButton(this.btn_save,true);
			var btnCheckBoxController:MultiButton = new MultiButton(this.btn_checkBox,true,true);
			
			var btnChooseController:MultiButton = new MultiButton(this.btn_choose,true);
			this.btn_choose.addEventListener(MouseEvent.CLICK,onChooseClick);
			
			_genericInfoSO.addEventListener(SharedObjectEvent.CHANGED,onGenericChange);
			_genericInfoSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onGenericChange);
		
			
		}
		
		
		/////////////////////////callbacks////////////////////////
		private function onGenericChange(e:SharedObjectEvent):void
		{
			switch(e.propertyName)
			{
				case "fileToEdit":
					if((e.propertyValue as String).length > 0)
					{
						var eil:EasyImageLoader = new EasyImageLoader(_moduleAPI.moduleList['FileAssets']['module'].storagePath +  e.propertyValue);
						eil.addEventListener(ImageComplete_Event.IMAGE_LOADED, imageLoaded);
					}
					break;
			}
			
		}
		
		private function onChooseClick(e:MouseEvent):void
		{
			var fileList:Array = _moduleAPI.moduleList['FileAssets']['module'].getFileList();
			
			var listHeight:Number = fileList.length * 18;
			if(listHeight > 200)
			{
				listHeight = 200;
			}
			
			_chooseFileList = null;
			_chooseFileList = new SortingScrollList(300,listHeight,"#ffffff");
			_chooseFileList.x = this.btn_choose.x + this.btn_choose.width - _chooseFileList.width;
			_chooseFileList.y = this.btn_choose.y - _chooseFileList.height;
			_chooseFileList.addEventListener(MouseEvent.ROLL_OUT, onFileListOut);
			
			for each(var s:String in fileList)
			{
				switch((s.split(".")[s.split(".").length - 1] as String).toLowerCase())
				{
					case "jpg":
					case "jpeg":
					case "png":
					case "gif":
						var itemBar:Sprite = Factory_prettyBox.drawPrettyBox(_chooseFileList.width,18,0xeeeeee);
						itemBar.mouseChildren = false;
						itemBar.buttonMode = true;
						itemBar.addEventListener(MouseEvent.CLICK,onFilenameClick);
						itemBar.addEventListener(MouseEvent.ROLL_OVER,onFilenameOver);
						itemBar.addEventListener(MouseEvent.ROLL_OUT,onFilenameOut);
						var tf:TextField = new TextField();
						tf.width = 200;
						tf.height = 15;
						tf.y = 2;
						var f:Font = new HelveticaRegular();
						tf.defaultTextFormat = new TextFormat(f.fontName,10,0x555555,null,null,null,null,TextFormatAlign.LEFT);
						tf.text = s;
						itemBar.addChild(tf);
						_chooseFileList.addListItem(itemBar,s);
						break;
				}
			}
			
			this.addChild(_chooseFileList);
			
		}
		
		private function onFileListOut(e:MouseEvent):void
		{
			if(_chooseFileList.parent == this)
			{
				_chooseFileList.removeEventListener(MouseEvent.ROLL_OUT,onFileListOut);
				this.removeChild(_chooseFileList);
			}
		}
		
		private function onFilenameOut(e:MouseEvent):void
		{
			e.target.alpha = 1;
		}
		
		private function onFilenameOver(e:MouseEvent):void
		{
			e.target.alpha = .8;
		}
		
		private function onFilenameClick(e:MouseEvent):void
		{	
			_genericInfoSO.setProperty("fileToEdit", e.target.getChildAt(0).text);
			
			if(_chooseFileList.parent == this)
			{
				_chooseFileList.removeEventListener(MouseEvent.ROLL_OUT,onFileListOut);
				this.removeChild(_chooseFileList);
			}
		}
		
		private function imageLoaded(e:ImageComplete_Event):void
		{
			var evt:BottomBarEvent = new BottomBarEvent(BottomBarEvent.IMAGE_LOADED);
			evt.image = e.imageLoaded;
			this.dispatchEvent(evt);
		}
		
		private function onDisableClick(e:MouseEvent):void
		{
			if(this.btn_disable.currentFrameLabel == "over" || this.btn_disable.currentFrameLabel == "up")
			{
				_genericInfoSO.setProperty("publicEditEnabled",false);
			}else{
				_genericInfoSO.setProperty("publicEditEnabled",true);
			}
			
		}
	}
}