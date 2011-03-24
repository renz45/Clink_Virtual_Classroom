package com.critique.drawingObjects
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.utils.MathUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import lib.rotateCursor;
	
	import mx.events.ResizeEvent;
	/**
	 * This is the base of all drawing objects. It uses the EditFrame to make objects resizable. This has rotaion functionality built in that rotates around the center. 
	 * This class is a little messy but it works fairly well, I learned a lot from building it and will make a new one someday that works much better
	 * @author adamrensel
	 * 
	 */	
	public class BaseDrawingObject extends Sprite
	{
		private var _editFrame:EditFrame;
		private var _mainContainer:Sprite;
		
		private var _referenceX:Number;
		private var _referenceY:Number;
		
		private var _toggleOn:Boolean;
		
		private var _trRotateHandle:Sprite;
		private var _tlRotateHandle:Sprite;
		private var _brRotateHandle:Sprite;
		private var _blRotateHandle:Sprite;
		
		private var _rotateCursor:rotateCursor;
		
		private var _startAngle:Number;
		private var _rotateDown:Boolean;
		
		
		private var _boxWidth:Number;
		private var _boxHeight:Number;
		
		private static var _canvas:DisplayObject;
		
		public function BaseDrawingObject()
		{
			super();
			
			startup();
		}
		//start up the object
		private function startup():void
		{
			this.addEventListener(Event.ADDED,init);
			
			_boxWidth = 1;
			_boxHeight = 1;
			
			_toggleOn = false;
			
			_mainContainer = new Sprite();
			
			var dragger:Controller_Dragable = new Controller_Dragable(_mainContainer,this);
			this.addEventListener(MouseEvent.ROLL_OVER,onOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onOut);
			
			this.tabEnabled = true;
			
			_mainContainer.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			_mainContainer.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
			
			
		}
		
		//initialize when the object is added to the display list
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED,init);
			
			//this creates a new container that will hold this class, by positioning the visible object's center at the 0,0 of this wrapper container we can fake a center point for rotation
			this.parent.addChild(_mainContainer);
			_mainContainer.addChild(this);
			
			_editFrame = new EditFrame();
			
			_editFrame.addEventListener(ResizeEvent.RESIZE,onResize);
			_editFrame.addEventListener(Event.CHANGE, onChange);
			
			//create rotation handles
			addRotateHandles();
			
			//initialize a new object
			registerNewObject(super.x,super.y);
			
		}
		
		/**
		 * This registers a new object, whenever the main object is changed by somthing other than the resize handles or rotation handles this function most be called to re-register 
		 * @param x:number this is the x coord of the main_continer (position container)
		 * @param y:number this is the y coord of the main_continer (position container)
		 * 
		 */		
		public function registerNewObject(x:Number,y:Number):void
		{
			_referenceX = x + this.width/2;
			_referenceY = y + this.height/2;
			
			_editFrame.boxHeight = this.height;
			_editFrame.boxWidth = this.width;
			
			
			update();
		}
		
		//create rotate handle and instantiate the rotation curser
		private function addRotateHandles():void
		{
			_trRotateHandle = Factory_prettyBox.drawPrettyBox(15,15,0xeeeeee,0,false,false,false,2,1,0);
			_tlRotateHandle = Factory_prettyBox.drawPrettyBox(15,15,0xeeeeee,0,false,false,false,2,1,0);
			_brRotateHandle = Factory_prettyBox.drawPrettyBox(15,15,0xeeeeee,0,false,false,false,2,1,0);
			_blRotateHandle = Factory_prettyBox.drawPrettyBox(15,15,0xeeeeee,0,false,false,false,2,1,0);
			
			_trRotateHandle.addEventListener(MouseEvent.ROLL_OVER,onRotateOver);
			_tlRotateHandle.addEventListener(MouseEvent.ROLL_OVER,onRotateOver);
			_brRotateHandle.addEventListener(MouseEvent.ROLL_OVER,onRotateOver);
			_blRotateHandle.addEventListener(MouseEvent.ROLL_OVER,onRotateOver);
			
			_trRotateHandle.addEventListener(MouseEvent.ROLL_OUT,onRotateOut);
			_tlRotateHandle.addEventListener(MouseEvent.ROLL_OUT,onRotateOut);
			_brRotateHandle.addEventListener(MouseEvent.ROLL_OUT,onRotateOut);
			_blRotateHandle.addEventListener(MouseEvent.ROLL_OUT,onRotateOut);
			
			_trRotateHandle.addEventListener(MouseEvent.MOUSE_DOWN,rotateDown);
			_tlRotateHandle.addEventListener(MouseEvent.MOUSE_DOWN,rotateDown);
			_brRotateHandle.addEventListener(MouseEvent.MOUSE_DOWN,rotateDown);
			_blRotateHandle.addEventListener(MouseEvent.MOUSE_DOWN,rotateDown);
			
			_trRotateHandle.addEventListener(MouseEvent.MOUSE_UP,rotateUp);
			_tlRotateHandle.addEventListener(MouseEvent.MOUSE_UP,rotateUp);
			_brRotateHandle.addEventListener(MouseEvent.MOUSE_UP,rotateUp);
			_blRotateHandle.addEventListener(MouseEvent.MOUSE_UP,rotateUp);
			
			_trRotateHandle.name = "tr";
			_tlRotateHandle.name = "tl";
			_brRotateHandle.name = "br";
			_blRotateHandle.name = "bl";
			
			_rotateCursor = new rotateCursor();
			_rotateCursor.mouseEnabled = false;
		}
		
		//////////////////callbacks///////////////////
		
		//when a rotate handle is clicked, the rotaion is determined using a math formula for angle, and subtracts the start handle in order to prevent the box from jumping around
		private function rotationEngine(e:Event):void
		{
			_mainContainer.rotation = MathUtil.getAngle(_mainContainer.localToGlobal(new Point(0,0)),new Point(this.stage.mouseX, this.stage.mouseY)) - _startAngle;
			rotating();
		}
		
		/**
		 * This method is used for overriding, incase a class extending this base class needs to do something whenever the object is rotating 
		 * 
		 */		
		public function rotating():void
		{
			//for overriding
		}
		
		//when a rotate handle is clicked, start the rotation enterframe.
		private function rotateDown(e:MouseEvent):void
		{
			this.addEventListener(Event.ENTER_FRAME, rotationEngine);
			//im dispatching a mouseDown event to the stage inorder for the mouse_up to fire for the stage.
			this.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			this.stage.addEventListener(MouseEvent.MOUSE_UP, rotateUp);
			_startAngle = MathUtil.getAngle(new Point(0,0), new Point(_mainContainer.mouseX, _mainContainer.mouseY));
			_rotateDown = true;
		}
		
		//on rotate button up, remove the rotate pointer and remove the enter frame
		private function rotateUp(e:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, rotateUp);
			this.removeEventListener(Event.ENTER_FRAME, rotationEngine);
			if(_rotateCursor.parent == _mainContainer)
			{
				_mainContainer.removeChild(_rotateCursor);
			}
			_rotateDown = false;
		}
		
		//when a rotation button is rolled over, add the rotation cursor and rotate/position it accordingly
		private function onRotateOver(e:MouseEvent):void
		{
			//remove the focus event temporarily so the main object doesnt lose focus when clicking on the handles
			_mainContainer.removeEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
			
			switch(e.currentTarget.name)
			{
				case "tr":
					_rotateCursor.rotation = 0;
					_rotateCursor.x = _mainContainer.mouseX;
					_rotateCursor.y = _mainContainer.mouseY - _rotateCursor.height;
					break;
				
				case "tl":
					_rotateCursor.rotation = 270;
					_rotateCursor.x = _mainContainer.mouseX - _rotateCursor.width;
					_rotateCursor.y = _mainContainer.mouseY;
					break;
				
				case "br":
					_rotateCursor.rotation = 90;
					_rotateCursor.x = _mainContainer.mouseX + _rotateCursor.width;
					_rotateCursor.y = _mainContainer.mouseY;
					break;
				
				case "bl":
					_rotateCursor.rotation = 180;
					_rotateCursor.x = _mainContainer.mouseX;
					_rotateCursor.y = _mainContainer.mouseY + _rotateCursor.height;
					break;
			}
			
			
			
			_mainContainer.addChildAt(_rotateCursor,0);
		}
		
		//rotate button roll out, give focus back to the main object, remove the cursor, add the focus event back in to the main object
		private function onRotateOut(e:MouseEvent):void
		{	
			if(!_rotateDown && _rotateCursor.parent == _mainContainer)
			{
				_mainContainer.removeChild(_rotateCursor);
			}
			_mainContainer.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
			_mainContainer.focusRect = false;
			this.stage.focus = _mainContainer;
			
		}
		
		//remove focus event for edit frame handle clicks, this prevents the main object from losing focus
		private function onFrameDown(e:MouseEvent):void
		{
			_mainContainer.removeEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
		}
		
		//add the focus event back onto the main object
		private function onFrameUp(e:MouseEvent):void
		{
			_mainContainer.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
		}
		
		//when this is focused add the edit frame, add in rotate handles
		protected function onFocusIn(e:FocusEvent):void
		{
			_mainContainer.addChild(_editFrame);
			
			for each(var s:Sprite in _editFrame.handles)
			{
				s.addEventListener(MouseEvent.ROLL_OVER,onFrameDown);
				s.addEventListener(MouseEvent.ROLL_OUT,onFrameUp);
			}
			
			_mainContainer.addChildAt(_trRotateHandle,0);
			_mainContainer.addChildAt(_tlRotateHandle,0);
			_mainContainer.addChildAt(_brRotateHandle,0);
			_mainContainer.addChildAt(_blRotateHandle,0);
			
		}
		
		// when this main object loses focus, remove all handles
		protected function onFocusOut(e:FocusEvent):void
		{
			this._mainContainer.removeChild(_editFrame);
			
			for each(var s:Sprite in _editFrame.handles)
			{
				s.removeEventListener(MouseEvent.ROLL_OVER,onFrameDown);
				s.removeEventListener(MouseEvent.ROLL_OUT,onFrameUp);
			}
			
			_mainContainer.removeChild(_trRotateHandle);
			_mainContainer.removeChild(_tlRotateHandle);
			_mainContainer.removeChild(_brRotateHandle);
			_mainContainer.removeChild(_blRotateHandle);
			
			
		}
		
		//event listener for when the edit frame has been resized
		private function onResize(e:ResizeEvent):void
		{
			alignContainers();
			resize();
		}
		
		/**
		 * public function that can be overridden by classes extended by this class if actions are needed on resize 
		 * 
		 */		
		public function resize():void
		{
			//override
		}
		
		//whenever the object is being resized update the width and x/y coords based on the edit frame
		private function onChange(e:Event):void
		{
			//this.width = _editFrame.boxWidth;
			//this.height = _editFrame.boxHeight;
			//this.x = _editFrame.x;
			//this.y = _editFrame.y;
			
			changing(_editFrame.boxWidth,_editFrame.boxHeight,_editFrame.x,_editFrame.y);
		}
		
		/**
		 * change function, this is fired when the edit frame changes
		 *  
		 * @param width edit frame width
		 * @param height edit frame height
		 * @param x edit frame xpos
		 * @param y edit frame ypos
		 * 
		 */		
		public function changing(width:Number, height:Number,x:Number,y:Number):void
		{
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
		}
		
		//change cursors when mouse over this main object
		private function onOver(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function onOut(e:MouseEvent):void
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		//////////////////public methods////////////////
		
		/**
		 * update function re-positions elements back to this visible container(this) being centered on the 0,0 point of the position (_mainContainer)
		 * this assures that the centerd rotation is preserved
		 * 
		 */		
		public function update():void
		{
			if(this.parent == _mainContainer)
			{
				/*_mainContainer.graphics.clear();
				_mainContainer.graphics.beginFill(0xaaffaa);
				_mainContainer.graphics.drawRect(0,0,_mainContainer.width,_mainContainer.height);
				_mainContainer.graphics.endFill();*/
				
				_mainContainer.x = _referenceX;
				_mainContainer.y = _referenceY;
				
				super.x = -super.width/2;
				super.y = -super.height/2;
				
				if(_editFrame)
				{
					_editFrame.x = -super.width/2;
					_editFrame.y = -super.height/2;
					
				}
			}
			
			_editFrame.update();
			
			//reposition rotate handles
			if(_editFrame)
			{
				_trRotateHandle.x = this.x + this.width;
				_trRotateHandle.y = this.y - _trRotateHandle.height;
				
				_tlRotateHandle.x = this.x - _tlRotateHandle.width;
				_tlRotateHandle.y = this.y - _tlRotateHandle.height;
				
				_brRotateHandle.x = this.x + this.width;
				_brRotateHandle.y = this.y + this.height;
				
				_blRotateHandle.x = this.x - _blRotateHandle.width;
				_blRotateHandle.y = this.y + this.height;
			}
			
		}
	
		/**
		 * finds the new position container (_mainContainer) x/y coords based on the center point of the drawing container(this) using localToGlobal and globalToLocal 
		 * 
		 */		
		public function alignContainers():void
		{	
			var pt:Point = this.parent.localToGlobal(new Point(this.x + this.width/2,this.y + this.height/2));
			
			var pt2:Point = _mainContainer.parent.globalToLocal(pt);
			
			_referenceX = pt2.x;
			_referenceY = pt2.y;
		
			this.x = -(_editFrame.width/2);
			this.y = -(_editFrame.height/2);
			
			update();
		}
		/**
		 * getter returns the drawing object container 
		 * @return 
		 * 
		 */		
		public function get drawingObjectContainer():Sprite
		{
			return this;
		}
		/**
		 * returns the position container (_mainContainer) 
		 * @return 
		 * 
		 */		
		public function get positionContainer():Sprite
		{
			return _mainContainer;
		}
		
		/**
		 * manually set the rotation of the object - rotates from the center 
		 * this should be used instead of the default .rotation
		 * @param value
		 * 
		 */		
		public function setRotation(value:Number):void
		{
			_mainContainer.rotation = value;
		}
		
		/**
		 * getter for rotation, this should be used over the build in .rotation 
		 * @return 
		 * 
		 */		
		public function getRotation():Number
		{
			return _mainContainer.rotation;
		}
		
		public function updateEditFrame(width:Number = -1 ,height:Number = -1):void
		{
			_editFrame.update(width,height);
		}
		
		
		///////////////////////statics//////////////////////
		/**
		 * initialize the class by loading in a main canvas reference, this is used for positioning purposes
		 * @param canvas
		 * 
		 */		
		public static function init(canvas:DisplayObject):void
		{
			_canvas = canvas;
		}
		
		/**
		 * getter for the canvas reference 
		 * @return 
		 * 
		 */		
		public static function get canvas():DisplayObject
		{
			return _canvas;
		}
		
	}
}