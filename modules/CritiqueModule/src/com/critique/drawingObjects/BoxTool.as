package com.critique.drawingObjects
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.SharedObject;

	public class BoxTool extends BaseDrawingObject implements IDrawingObject
	{
		private var _isInit:Boolean = false;
		
		private var _xPos:Number;
		private var _yPos:Number;
		
		private var _drawingObjectSO:Manager_remoteCommonSharedObject;
		
		private var _height:Number;
		private var _width:Number;
		private var _fillColor:uint;
		private var _strokeColor:uint;
		private var _strokeSize:uint;
		private var _zIndex:Number;
		private var _layerName:String;
		private var _isMouseDown:Boolean;
		private var _isEnabled:Boolean;
		private var _isDrawing:Boolean;
		
		private var _isEnabledByClient:Boolean;
		
		private var _name:String;
		private var _userID:Number
		
		private var hasBeenDeleted:Boolean;
		
		
		public function BoxTool(drawingObjectSO:Manager_remoteCommonSharedObject,name:String, userID:Number)
		{
			super();
			
			_drawingObjectSO = drawingObjectSO; 
			
			_name = name;
			_userID = userID;
			
			init();
		}
		
		private function init():void
		{
			
			hasBeenDeleted = false;
			
			_isEnabledByClient = true;
			_isEnabled = true;
			
			this.graphics.beginFill(0x4444ff);
			this.graphics.drawRect(0,0, 50,50);
			this.graphics.endFill();
			
			
			_xPos = this.x;
			_yPos = this.y;
			
			//set defaults
			_height = 1
			_width = 1
			_fillColor = 0xaaaaaa;
			_strokeColor = 0x555555
			_strokeSize = 1;
			_zIndex = 0;
			_layerName = "default";
			_isMouseDown = true;
			
			if(!_drawingObjectSO.sharedObject.data[_name])
			{
				
				var data:Object = {x:_xPos,
					y:_yPos,
					height:_height,
					width:_width,
					fillColor:_fillColor,
					strokeColor:_strokeColor,
					strokeSize:_strokeSize,
					zIndex:_zIndex,
					layerName:_layerName,
					isMouseDown:_isMouseDown,
					objectType:"square",
					changerClientId:_userID,
					rotation:this.getRotation(),
					isEnabled:_isEnabled
				};
				
				_drawingObjectSO.addProperty(_name,data);
				
				drawBox(1,1);
			}else{
				
				var data2:Object = _drawingObjectSO.sharedObject.data[_name];
				
				_height = data2['height'];
				_width = data2['width'];
				_fillColor = data2['fillColor'];
				_strokeColor = data2['strokeColor'];
				_strokeSize = data2['strokeSize'];
				_zIndex = data2['zIndex'];
				_layerName = data2['layerName'];
				_isMouseDown = data2['isMouseDown'];
				_xPos = data2['x'];
				_yPos = data2['y'];
				this.setRotation(data2['rotation']);
				_isEnabled = data2['isEnabled'];
				
				this.x = _xPos - _width/2;
				this.y = _yPos - _height/2;
				
				drawBox(_width,_height,false,false);
				_isInit = true;
			}
			
			_drawingObjectSO.addEventListener(SharedObjectEvent.CHANGED, onSOChange);

			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function updateXY():void
		{
			if(!hasBeenDeleted)
			{
				var pt:Point = this.positionContainer.localToGlobal(new Point(this.drawingObjectContainer.x + this.drawingObjectContainer.width/2,this.drawingObjectContainer.y + this.drawingObjectContainer.height/2));
				var pt2:Point = this.positionContainer.parent.globalToLocal(pt);
				
				_xPos = pt2.x;
				_yPos = pt2.y;
			}
			
		}
		
		private function toggleEnableObject():void
		{
			if(_isEnabled && _isEnabledByClient)
			{
				this.mouseEnabled = true;
			}else{
				this.mouseEnabled = false;
			}
		}
		
		///////////////////////callbacks///////////////////
		override protected function onFocusIn(e:FocusEvent):void
		{
			super.onFocusIn(e);
			
			_isEnabled = false;
			updateSO();
		}
		
		override protected function onFocusOut(e:FocusEvent):void
		{
			super.onFocusOut(e);
			this.removeEventListener(Event.ENTER_FRAME, checkForPos);

			_isEnabled = true;
			updateSO();
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			
			
			this.addEventListener(Event.ENTER_FRAME, checkForPos);
			
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME, checkForPos);
		}
		
		private function checkForPos(e:Event):void
		{
			updateXY();
			updateSO();
		}
		
		private function onSOChange(e:SharedObjectEvent):void
		{
			if(e.sharedObjectSlot == _name && _drawingObjectSO.sharedObject.data[e.sharedObjectSlot])
			{
				_isInit = true;
				if(_drawingObjectSO.sharedObject.data[e.sharedObjectSlot]['changerClientId'] != _userID)
				{
					updateLocalVars(e.sharedObjectSlot)
				}
			}
		}
		
		private function updateLocalVars(slot:String):void
		{
			
				var data:Object = _drawingObjectSO.sharedObject.data[slot];
				
				_height = data['height'];
				_width = data['width'];
				_fillColor = data['fillColor'];
				_strokeColor = data['strokeColor'];
				_strokeSize = data['strokeSize'];
				_zIndex = data['zIndex'];
				_layerName = data['layerName'];
				_isMouseDown = data['isMouseDown'];
				_xPos = data['x'];
				_yPos = data['y'];
				this.setRotation(data['rotation']);
				_isEnabled = data['isEnabled'];
				_isDrawing = data['isDrawing'];
				
				if(_drawingObjectSO.sharedObject.data[_name]['changerClientId'] != _userID)
				{
					toggleEnableObject();
				}
				
				drawBox(_width,_height,true, data['isDrawing']);
				
				if(!data['isDrawing'])
				{
					this.drawingObjectContainer.width = _width;
					this.drawingObjectContainer.height = _height;
					
					this.positionContainer.x = _xPos;
					this.positionContainer.y = _yPos;
					
					this.drawingObjectContainer.x = -_width/2;
					this.drawingObjectContainer.y = -_height/2;
					
					if(_isMouseDown == false && this.parent)
					{
						this.updateEditFrame(_width,_height);
						super.alignContainers();
					}
				}
		}
		
		private function updateSO(isDrawing:Boolean = false):void
		{
			if(_isInit && _drawingObjectSO.sharedObject.data[_name])
			{
				var data:Object = {x:_xPos,
									y:_yPos,
									height:this.drawingObjectContainer.height,
									width:this.drawingObjectContainer.width,
									fillColor:_fillColor,
									strokeColor:_strokeColor,
									strokeSize:_strokeSize,
									zIndex:_zIndex,
									layerName:_layerName,
									isMouseDown:_isMouseDown,
									objectType:"square",
									changerClientId:_userID,
									rotation:this.getRotation(),
									isDrawing:isDrawing,
									isEnabled:_isEnabled
								};
				
				_drawingObjectSO.setProperty(_name,data);
			}
		}
		
		/////////////public methods///////////
		public function drawBox(width:Number,height:Number, disableSOUpdate:Boolean = false, isDrawing:Boolean = false):void
		{
			if(width < 0)
			{
				_width = 0;
			}else{
				_width = width;
			}
			
			if(height < 0)
			{
				_height = 0;
			}else{
				_height = height;
			}
			
			this.graphics.clear();
			this.graphics.lineStyle(_strokeSize,_strokeColor);
			this.graphics.beginFill(_fillColor);
			this.graphics.drawRect(_strokeSize/2,_strokeSize/2,_width,_height);
			this.graphics.endFill();
			
			if(!disableSOUpdate)
			{
				updateSO(true);
			}
			
			if(isDrawing)
			{
				draw();
			}
		}
		
		public function deleteThis():void
		{
			hasBeenDeleted = true
			_drawingObjectSO.deleteProperty(_name);
			this.positionContainer.parent.removeChild(this.positionContainer);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function resize():void
		{
			_isMouseDown = false;
			updateXY();
			updateSO();
		}
		
		override public function changing(width:Number,height:Number,x:Number,y:Number):void
		{
			this.drawingObjectContainer.x = x;
			this.drawingObjectContainer.y = y;
			
			drawBox(width - _strokeSize,height - _strokeSize,true,false);
			_isMouseDown = true;
			updateXY();
			updateSO();
			
		}
		
		override public function rotating():void
		{
			updateSO();
		}
		
		public function draw():void
		{
			if(_isInit)
			{
			
				this.registerNewObject(_xPos,_yPos);
			
			}
		}
		
		public function set xPos(value:Number):void
		{
			_xPos = value;
			
			updateSO();
		}
		
		public function get xPos():Number
		{
			return _xPos;
		}
		
		public function set yPos(value:Number):void
		{
			_yPos = value;
			
			updateSO();
		}
		
		public function get yPos():Number
		{
			return _yPos;
		}
		
		override public function set name(value:String):void
		{
			super.name;
		}
		
		public function set isMouseDown(value:Boolean):void
		{
			_isMouseDown = value;
			updateSO();
		}
		
		public function get isMouseDown():Boolean
		{
			return _isMouseDown;
		}
		
		public function set objName(value:String):void
		{
			_name = value;
		}
		
		public function get objName():String
		{
			return _name;
		}
		
		///////////////////getters/setters//////////////////
		
		public function set fillColor(value:uint):void
		{
			_fillColor = value;
			drawBox(_width,_height,false,true);
		}
		
		public function get fillColor():uint
		{
			return fillColor;
		}
		
		public function set strokeColor(value:uint):void
		{
			_strokeColor = value;
			drawBox(_width,_height,false,true);
		}
		
		public function get strokeColor():uint
		{
			return _strokeColor;
		}
		
		public function set strokeSize(value:Number):void
		{
			_strokeSize = value;
			drawBox(_width,_height,false,true);
		}
		
		public function get strokeSize():Number
		{
			return strokeSize;
		}
		
		public function set isEnabled(value:Boolean):void
		{
			_isEnabledByClient = value;
			toggleEnableObject();
		}
		
		public function get isEnabled():Boolean
		{
			return _isEnabledByClient;
		}
	}
}