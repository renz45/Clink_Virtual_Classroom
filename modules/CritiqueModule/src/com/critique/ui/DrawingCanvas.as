package com.critique.ui
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.ScrollBox;
	import com.clink.utils.ArrayUtils;
	import com.clink.utils.MathUtil;
	import com.clink.utils.VarUtils;
	import com.clink.valueObjects.VO_ModuleApi;
	import com.critique.drawingObjects.BaseDrawingObject;
	import com.critique.drawingObjects.BoxTool;
	import com.critique.drawingObjects.Factory_DrawingObject;
	import com.critique.drawingObjects.IDrawingObject;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class DrawingCanvas extends ScrollBox
	{
		private var _userValuesSO:Manager_remoteUserSharedObject;
		private var _layerListSO:Manager_remoteCommonSharedObject;
		private var _genericInfoSO:Manager_remoteCommonSharedObject;
		private var _objectListSO:Manager_remoteCommonSharedObject;
		private var _objectNameListSO:Manager_remoteCommonSharedObject;
		
		private var _boxWidth:Number;
		private var _boxHeight:Number;
		
		private var _container:Sprite;
		private var _imageContainer:Sprite;
		private var _moduleApi:VO_ModuleApi;
		
		private var _localObjectCount:int;
		private var _objectList:Object;
		private var _currentClientTarget:BoxTool;
		private var _mouseStartPos:Point;
		
		
		public function DrawingCanvas(width:Number,height:Number,userValuesSO:Manager_remoteUserSharedObject,layerListSO:Manager_remoteCommonSharedObject,genericInfoSO:Manager_remoteCommonSharedObject, moduleApi:VO_ModuleApi,bgColor:String)
		{
			super(width,height,bgColor);
			
			_userValuesSO = userValuesSO;
			_layerListSO = layerListSO;
			_genericInfoSO = genericInfoSO;
			
			_moduleApi = moduleApi;
			
			_boxWidth = width;
			_boxHeight = height;
			
			init();
		}
		
		private function init():void
		{
			
			_imageContainer = new Sprite();
			_container = new Sprite();
			_container.addChild(_imageContainer);
			
			_imageContainer.graphics.beginFill(0xffffff,0);
			_imageContainer.graphics.drawRect(0,0,_boxWidth,_boxHeight);
			_imageContainer.graphics.endFill();
			
			this.addItem(_container);
			
			_mouseStartPos = new Point();
			_localObjectCount = 0;
			_objectList = {};
			
			var template:Object = {};
			_objectListSO = new Manager_remoteCommonSharedObject("critiqueObjectListSO", template, _moduleApi.netConnection,false,25);
			_objectListSO.addEventListener(SharedObjectEvent.CONNECTED,onObjectListSOConnect);
			
			_imageContainer = new Sprite();
			_container = new Sprite();
			_container.addChild(_imageContainer);
			
			_imageContainer.graphics.beginFill(0xffffff,0);
			_imageContainer.graphics.drawRect(0,0,_boxWidth,_boxHeight);
			_imageContainer.graphics.endFill();
			
			this.addItem(_container);
			
			_container.addEventListener(MouseEvent.MOUSE_DOWN, canvasMouseDown);
			_container.addEventListener(MouseEvent.MOUSE_UP,canvasMouseUp);
			
			BaseDrawingObject.init(_container);
			//testing
		/*	var testObj:BoxTool = new BoxTool();
			_container.addChild(testObj); 
			
			testObj.x = 100;
			testObj.y = 200;
			
			testObj.drawBox(300,200);*/
			
			_userValuesSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onUserSOChange);
		}
		
		private function deleteDrawingObject(dObject:IDrawingObject):void
		{
			if(dObject)
			{
				var objName:String = dObject.objName;
				
				dObject.deleteThis();
				
				_objectList[objName] = null;
				
				_objectNameListSO.deleteProperty(objName);
				
				var tempObj:Object = {};
				
				for (var name:String in _objectList)
				{
					if(name != objName)
					{
						tempObj[name] = _objectList[name];
					}
				}
				
				_objectList = tempObj;
			}
		}
		
		
		///////////////////////////callbacks////////////////////////
		
		private function onObjectListSOConnect(e:SharedObjectEvent):void
		{
			var template:Object = {};
			_objectNameListSO = new Manager_remoteCommonSharedObject("critiqueObjectNameListSO", template, _moduleApi.netConnection,false,25);
			
			
			_objectListSO.removeEventListener(SharedObjectEvent.CONNECTED,onObjectListSOConnect);
			_objectNameListSO.addEventListener(SharedObjectEvent.CHANGED,onObjectNameListSOChange);
			_objectNameListSO.addEventListener(SharedObjectEvent.DELETED,onObjectNameListSODelete);
		}
		
		private function drawingRobot(e:Event):void
		{
			_currentClientTarget.drawBox(_container.mouseX - _currentClientTarget.xPos,_container.mouseY - _currentClientTarget.yPos,false,true);
		} 
		
		private function canvasMouseDown(e:MouseEvent):void
		{
			
			if(true)//e.target == _imageContainer)
			{
				switch(_userValuesSO.getProperty("tool",_moduleApi.userID).toString())
				{
					case "arrow":
						
						break;
					
					case "pencil":
						
						break;
					
					case "square":
						
						var box:BoxTool = new BoxTool(_objectListSO, _moduleApi.username + "_box_" + ( Math.round(_localObjectCount + Math.random()*10000)).toString(), _moduleApi.userID);
						
						box.fillColor = uint(_userValuesSO.getProperty("fillColor",_moduleApi.userID));
						box.strokeColor = uint(_userValuesSO.getProperty("strokeColor",_moduleApi.userID));
						box.strokeSize = Number(_userValuesSO.getProperty("strokeSize",_moduleApi.userID));
						
						box.xPos = _imageContainer.mouseX;
						box.yPos = _imageContainer.mouseY;
						
						_container.addChild(box);
						
						_localObjectCount ++;
						
						_objectList[box.objName] = box;
						
						_currentClientTarget = box;
						
						
						_objectNameListSO.addProperty(box.objName,box.objName);
						
						_container.addEventListener(Event.ENTER_FRAME, drawingRobot);
						break;
					
					case "circle":
						
						break;
					
					case "eraser":
						
						deleteDrawingObject(e.target as IDrawingObject);
						
						break;
					
					case "mask":
						
						break;
					
					case "text":
						
						break;
				}
			}
		}
		
		private function canvasMouseUp(e:MouseEvent):void
		{
			_container.removeEventListener(Event.ENTER_FRAME, drawingRobot);
			if(_userValuesSO.getProperty("tool",_moduleApi.userID) != "arrow" && _userValuesSO.getProperty("tool",_moduleApi.userID) != "eraser")
			{
				_currentClientTarget.isEnabled = false;
			}
		}
		
		private function onObjectNameListSOChange(e:SharedObjectEvent):void
		{
			//if an object doesnt exists than create a new object and add it to the object list, add it to the canvas as well
			if(_objectListSO.sharedObject.data[e.sharedObjectSlot] && _objectListSO.sharedObject.data[e.sharedObjectSlot]['changerClientId'] != _moduleApi.userID && !_objectList[e.propertyName])
			{
				_objectList[e.propertyName] = Factory_DrawingObject.getObject(_objectListSO.sharedObject.data[e.sharedObjectSlot]['objectType'],_objectListSO, e.sharedObjectSlot, _moduleApi.userID);
				_container.addChild(_objectList[e.sharedObjectSlot]);
			}
		}
		
		private function onObjectNameListSODelete(e:SharedObjectEvent):void
		{
			deleteDrawingObject(_objectList[e.sharedObjectSlot]);
		}
		
		private function onUserSOChange(e:SharedObjectEvent):void
		{
			
			switch(e.propertyName)
			{
				case "tool":
					if(e.propertyValue == "arrow" || e.propertyValue == "eraser")
					{
						for each(var ob1:IDrawingObject in _objectList)
						{
							ob1.isEnabled = true;
						}
					}else{
						for each(var ob2:IDrawingObject in _objectList)
						{
							ob2.isEnabled = false;
						}
					}
					break;
				
				case "fontSize":
					
					break;
				
				case "strokeSize":
					
					break;
				
				case "strokeColor":
					
					break;
				
				case "fillColor":
					
					break;
				
				case "isMouseDown":
					
					break;
				
				case "mouseX":
				case "mouseY":
					
					break;
				
				case "layer":
					
					break;
				
				case "isMaskOn":
					
					break;
				
				case "zoomPercent":
					
					break;
				
				case "zoomX":
				case "zoomY":
					
					break;
				
			}
		}

		//////////////setters/getters///////////////
		public function set imageToEdit(img:DisplayObject):void
		{
			while(_imageContainer.numChildren > 0)
			{
				_imageContainer.removeChildAt(0);
			}
			
			_imageContainer.addChild(img);
			this.update();
		}
	}
}