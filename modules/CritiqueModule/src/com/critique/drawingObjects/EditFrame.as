package com.critique.drawingObjects
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.controllers.Controller_button;
	import com.clink.utils.MathUtil;
	import com.clink.valueObjects.VO_ModuleApi;
	
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import mx.events.ResizeEvent;
	
	[Event(name="resize", type="mx.events.ResizeEvent")]
	[Event(name="change", type="flash.events.Event")]
	/**
	 * this creates the resize box around drawing objects
	 * @author adamrensel
	 * 
	 */	
	public class EditFrame extends Sprite
	{
		private var _boxWidth:Number;
		private var _boxHeight:Number;
		private var _handleList:Object;
		private var _dragTarget:String;
		
		private var _dashWidth:Number = 4;
		private var _handleSize:Number = 8;
		
		private var _tcd:Controller_Dragable;
		private var _lcd:Controller_Dragable;
		private var _bcd:Controller_Dragable;
		private var _rcd:Controller_Dragable;
		private var _tld:Controller_Dragable;
		private var _trd:Controller_Dragable;
		private var _bld:Controller_Dragable;
		private var _brd:Controller_Dragable;
		
		public function EditFrame()
		{
			super();
			
			_boxWidth = 0;
			_boxHeight = 0;
			init();
		}
		
		private function init():void
		{
			_handleList = {};
			
			drawDashedBox();
			drawHandles();
			
			//if added/removed to the display list (addChild/removeChild)
			this.addEventListener(Event.ADDED,onAdded);
			this.addEventListener(Event.REMOVED,onRemove);
			
		}
		//draw the dashed box (there is no dashed linestyle so we have to do it manually)
		private function drawDashedBox():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(1,0x555555,.9,false,LineScaleMode.NONE);
			
			for(var i:int = 0; i < _boxWidth; i += (_dashWidth *2))
			{
				this.graphics.moveTo(i,0);
				this.graphics.lineTo(i + _dashWidth,0);
				
				this.graphics.moveTo(i,_boxHeight);
				this.graphics.lineTo(i + _dashWidth,_boxHeight);
			}
			
			for(var k:int = 0; k < _boxHeight; k += (_dashWidth *2))
			{
				this.graphics.moveTo(0,k);
				this.graphics.lineTo(0,k + _dashWidth);
				
				this.graphics.moveTo(_boxWidth,k);
				this.graphics.lineTo(_boxWidth,k + _dashWidth);
			}
		}
		
		//update position of each handle based on the size of this, which corresponds to the dashed box
		//Also update the drag rectangles based on the the new handle positions
		private function updateHandlePos():void
		{
			var halfHandle:Number = _handleSize/2;
			var width:Number = this.x;
			var height:Number = this.y;
			
			_handleList['topLeft'].x = width + -halfHandle;
			_handleList['topLeft'].y = height + -halfHandle;
			
			_handleList['topCenter'].x = width + _boxWidth/2;
			_handleList['topCenter'].y = height + -halfHandle;
			
			
			_handleList['topRight'].x = width + _boxWidth - halfHandle;
			_handleList['topRight'].y = height + -halfHandle;
			
			_handleList['leftCenter'].x = width + -halfHandle;
			_handleList['leftCenter'].y = height + _boxHeight/2;
			
			
			_handleList['rightCenter'].x = width + _boxWidth - halfHandle;
			_handleList['rightCenter'].y = height + _boxHeight/2;
			
			
			_handleList['bottomLeft'].x = width + -halfHandle;
			_handleList['bottomLeft'].y = height + _boxHeight - halfHandle;
			
			_handleList['bottomCenter'].x = width + _boxWidth/2;
			_handleList['bottomCenter'].y = height + _boxHeight - halfHandle;
			
			
			_handleList['bottomRight'].x = width + _boxWidth - halfHandle;
			_handleList['bottomRight'].y = height + _boxHeight - halfHandle;
			
			_tcd.dragRectangle = new Rectangle(_handleList['topCenter'].x,_handleList['topCenter'].y - 600,0, 600 + this.height - _handleSize);
			_lcd.dragRectangle = new Rectangle(_handleList['leftCenter'].x - 600,_handleList['leftCenter'].y,600 + this.width - _handleSize,0);
			_rcd.dragRectangle = new Rectangle(_handleList['leftCenter'].x + 600,_handleList['leftCenter'].y,-600,0);
			_bcd.dragRectangle = new Rectangle(_handleList['topCenter'].x,_handleList['topCenter'].y + 600,0, -600 );
			_tld.dragRectangle = new Rectangle(-600,-600, 600 + this.width/2 - _handleSize * 2, 600 + this.height/2 - _handleSize *2);
			_trd.dragRectangle = new Rectangle(-this.width/2,-600, 600 + this.width - _handleSize*2, 600 + this.height/2 - _handleSize*2);
			_bld.dragRectangle = new Rectangle(-600,-this.height/2, 600 + this.width/2 - _handleSize*2, 600 + this.height - _handleSize*2);
			_brd.dragRectangle = new Rectangle(-this.width/2,-this.height/2, 600 + this.width, 600 + this.height);
			
		}
		
		//create the handles and add dragable controllers to each one
		private function drawHandles():void
		{	
			drawHandle("topLeft");
			drawHandle("topCenter");
			drawHandle("topRight");
			drawHandle("leftCenter");
			drawHandle("rightCenter");
			drawHandle("bottomLeft");
			drawHandle("bottomCenter");
			drawHandle("bottomRight");
			
			_tld = new Controller_Dragable(_handleList['topLeft'],_handleList['topLeft']);
			_tcd = new Controller_Dragable(_handleList['topCenter'],_handleList['topCenter']);
			_trd = new Controller_Dragable(_handleList['topRight'],_handleList['topRight']);
			_lcd = new Controller_Dragable(_handleList['leftCenter'],_handleList['leftCenter']);
			_rcd = new Controller_Dragable(_handleList['rightCenter'],_handleList['rightCenter']);
			_bld = new Controller_Dragable(_handleList['bottomLeft'],_handleList['bottomLeft']);
			_bcd = new Controller_Dragable(_handleList['bottomCenter'],_handleList['bottomCenter']);
			_brd = new Controller_Dragable(_handleList['bottomRight'],_handleList['bottomRight']);
			
			
			updateHandlePos();
		}
		
		//draw individual handle
		private function drawHandle(name:String):void
		{
			var handle:Sprite = new Sprite();
			handle.graphics.lineStyle(.5,0xffffff);
			handle.graphics.beginFill(0x555555);
			handle.graphics.drawRect(0,0,_handleSize,_handleSize);
			handle.graphics.endFill();
			
			handle.name = name;
			handle.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			handle.addEventListener(MouseEvent.MOUSE_UP, handleUp);
			handle.buttonMode = true;
			_handleList[name] = handle;
		}
		
		
		//////////////////////callbacks//////////////////////
		//when added to the displaylist (addChild)
		private function onAdded(e:Event):void
		{
			for each(var handle:Sprite in _handleList)
			{
				this.parent.addChild(handle);
			}
		}
		
		//removed from display list removeChild
		private function onRemove(e:Event):void
		{
			for each(var handle:Sprite in _handleList)
			{
				this.parent.removeChild(handle);
			}
		}
		
		//when a handle is clicked set the drag target to that handle and start the resizeBox enterframe
		private function handleDown(e:MouseEvent):void
		{
			_dragTarget = e.target.name;
			this.addEventListener(Event.ENTER_FRAME,resizeBox);
			stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			stage.addEventListener(MouseEvent.MOUSE_UP,handleUp);
		}
		
		//when the handle is let go remove the resize enterframe and update the handle positions, dispatch a resize event to indicate the edit frame has just been resized
		private function handleUp(e:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP,handleUp);
			stage.removeEventListener(MouseEvent.MOUSE_UP,handleUp);
			this.removeEventListener(Event.ENTER_FRAME,resizeBox);
			
			
			updateHandlePos();
			
			this.dispatchEvent(new ResizeEvent(ResizeEvent.RESIZE));
		}
		
		//resize enterframe, follows a box being dragged, reposition handles and redraw the dotted lines as the handle is dragged
		//dispatch a change event as the box is being resized
		private function resizeBox(e:Event):void
		{

			//individual handle code
			switch(_dragTarget)
			{
				case "topLeft":
					//x axis
					_handleList['leftCenter'].x = _handleList['topLeft'].x;
					_handleList['bottomLeft'].x = _handleList['topLeft'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					this.x = _handleList['leftCenter'].x + _handleSize/2;
					_boxWidth = MathUtil.getDistance(_handleList['topLeft'].x,_handleList['topLeft'].y,_handleList['topRight'].x,_handleList['topRight'].y);
					
					//y axis
					_handleList['topCenter'].y = _handleList['topLeft'].y;
					_handleList['topRight'].y = _handleList['topLeft'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y + _boxHeight/2;
					this.y = _handleList['topLeft'].y + _handleSize/2;
					_boxHeight = MathUtil.getDistance(_handleList['topLeft'].x,_handleList['topLeft'].y,_handleList['bottomLeft'].x,_handleList['bottomLeft'].y);
					
					drawDashedBox();
					break;
				
				case "topCenter":
					//y axis
					_handleList['topLeft'].y = _handleList['topCenter'].y;
					_handleList['topRight'].y = _handleList['topCenter'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y + _boxHeight/2;
					this.y = _handleList['topLeft'].y + _handleSize/2;
					_boxHeight = MathUtil.getDistance(_handleList['topCenter'].x,_handleList['topCenter'].y,_handleList['bottomCenter'].x,_handleList['bottomCenter'].y);
					
					drawDashedBox();
					break;
				
				case "topRight":
					//x axis
					_handleList['rightCenter'].x = _handleList['topRight'].x;
					_handleList['bottomRight'].x = _handleList['topRight'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					_boxWidth = MathUtil.getDistance(_handleList['topLeft'].x,_handleList['topLeft'].y,_handleList['topRight'].x,_handleList['topRight'].y);
					
					//y axis
					_handleList['topCenter'].y = _handleList['topRight'].y;
					_handleList['topLeft'].y = _handleList['topRight'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y+ _boxHeight/2;
					this.y = _handleList['topLeft'].y + _handleSize/2;
					_boxHeight = MathUtil.getDistance(_handleList['topLeft'].x,_handleList['topLeft'].y,_handleList['bottomLeft'].x,_handleList['bottomLeft'].y);
					
					drawDashedBox();
					break;
				
				case "leftCenter":
					_handleList['topLeft'].x = _handleList['leftCenter'].x;
					_handleList['bottomLeft'].x = _handleList['leftCenter'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					this.x = _handleList['leftCenter'].x + _handleSize/2;
					_boxWidth = MathUtil.getDistance(_handleList['leftCenter'].x,_handleList['leftCenter'].y,_handleList['rightCenter'].x,_handleList['rightCenter'].y);
					
					drawDashedBox();
					break;
				
				case "rightCenter":
					_handleList['topRight'].x = _handleList['rightCenter'].x;
					_handleList['bottomRight'].x = _handleList['rightCenter'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					_boxWidth = MathUtil.getDistance(_handleList['leftCenter'].x,_handleList['leftCenter'].y,_handleList['rightCenter'].x,_handleList['rightCenter'].y);
					
					drawDashedBox();
					break;
				case "bottomLeft":
					//x axis
					_handleList['leftCenter'].x = _handleList['bottomLeft'].x;
					_handleList['topLeft'].x = _handleList['bottomLeft'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					this.x = _handleList['bottomLeft'].x + _handleSize/2;
					_boxWidth = MathUtil.getDistance(_handleList['bottomLeft'].x,_handleList['bottomLeft'].y,_handleList['bottomRight'].x,_handleList['bottomRight'].y);
					
					//y axis
					_handleList['bottomCenter'].y = _handleList['bottomLeft'].y;
					_handleList['bottomRight'].y = _handleList['bottomLeft'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y+ _boxHeight/2;
					_boxHeight = MathUtil.getDistance(_handleList['bottomLeft'].x,_handleList['bottomLeft'].y,_handleList['topLeft'].x,_handleList['topLeft'].y);
					
					drawDashedBox();
					break;
				
				case "bottomCenter":
					//y axis
					_handleList['bottomLeft'].y = _handleList['bottomCenter'].y;
					_handleList['bottomRight'].y = _handleList['bottomCenter'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y + _boxHeight/2;
					_boxHeight = MathUtil.getDistance(_handleList['topCenter'].x,_handleList['topCenter'].y,_handleList['bottomCenter'].x,_handleList['bottomCenter'].y);
					
					drawDashedBox();
					break;
				
				case "bottomRight":
					//x axis
					_handleList['rightCenter'].x = _handleList['bottomRight'].x;
					_handleList['topRight'].x = _handleList['bottomRight'].x;
					_handleList['topCenter'].x = this.x + _boxWidth/2;
					_handleList['bottomCenter'].x = this.x + _boxWidth/2;
					_boxWidth = MathUtil.getDistance(_handleList['bottomLeft'].x,_handleList['bottomLeft'].y,_handleList['bottomRight'].x,_handleList['bottomRight'].y);
					
					//y axis
					_handleList['bottomCenter'].y = _handleList['bottomRight'].y;
					_handleList['bottomLeft'].y = _handleList['bottomRight'].y;
					_handleList['rightCenter'].y = this.y + _boxHeight/2;
					_handleList['leftCenter'].y = this.y + _boxHeight/2;
					_boxHeight = MathUtil.getDistance(_handleList['bottomLeft'].x,_handleList['bottomLeft'].y,_handleList['topLeft'].x,_handleList['topLeft'].y);
					
					drawDashedBox();
					break;
			}
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		///////////////public methods////////////////
		/**
		 * update the handle positions and redraw the dashed box 
		 * 
		 */		
		public function update(width:Number = -1 ,height:Number = -1):void
		{
			if(width > -1 && height > -1)
			{
				_boxWidth = width;
				_boxHeight = height;
			}
			
			drawDashedBox();
			updateHandlePos();
		}
		/**
		 * return the object of handles, object keys corrospond to handle position - topLeft, topCenter, topRight, leftCenter, rightCenter, bottomLeft, bottomCenter, bottomRight
		 * @return Object
		 * 
		 */		
		public function get handles():Object
		{
			return _handleList;
		}
		/**
		 * Setter - manually set box width, width of this object. This method should be used instead of this.x 
		 * @param value 
		 * 
		 */		
		public function set boxWidth(value:Number):void
		{
			_boxWidth = value;
		}
		
		/**
		 * Getter for boxWidth 
		 * @return 
		 * 
		 */		
		public function get boxWidth():Number
		{
			return _boxWidth;
		}
		
		/**
		 * Setter - manually set box height, height of this object. This method should be used instead of this.y 
		 * @param value
		 * 
		 */		
		public function set boxHeight(value:Number):void
		{
			_boxHeight = value;
		}
		/**
		 * getter for boxHeight 
		 * @return 
		 * 
		 */		
		public function get boxHeight():Number
		{
			return _boxHeight;
		}
	}
}