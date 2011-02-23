package com.clink.ui
{
	import com.clink.controllers.Controller_button;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.factories.Factory_triangle;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * This class creates a scrollbar component with arrow buttons. This draws the scrollbar programatically instead of importing movieClips.
	 * The static functions can be used to change the color of the different scrollBar parts.
	 * @author adamrensel
	 * 
	 */	
	public class ScrollBar extends Sprite
	{
		private var _button1:Controller_button;
		private var _button2:Controller_button;
		private var _handle:Sprite;
		private var _track:Sprite;
		private var _slider:Slider;
		
		private var _length:Number;
		private var _isVertical:Boolean;
		private var _handlePotential:Number;
		private var _handleLength:Number;
		private var _handlePos:Number;
		private var _trackLength:Number;
		private var _thisValue:Number;
		private var _direction:Number;
		
		
		private const BUTTON_SIZE:Number = 16;
		
		private static var _buttonColor:uint;
		private static var _trackColor:uint;
		private static var _buttonArrowColor:uint;
		private static var _handleColor:uint;
		private static var _scrollBarList:Array;
		/**
		 * Instantiates a new scrollBar
		 *  
		 * @param length:Number Length of the scrollBar
		 * @param isVertical:Boolean whether or not the scrollBar is vertical or not.
		 * 
		 */		
		public function ScrollBar(length:Number,isVertical:Boolean = true)
		{
			super();
			
			_length = length;
			_isVertical = isVertical;
			
			init();
		}
		
		private function init():void
		{
			_scrollBarList.push(this);
			
			_handlePotential = 1;
			_thisValue = 0;
			
			drawScrollBar();
			
		}
		
		//draws the handle of the scrollBar
		private function drawHandle():void
		{
			//if its vertical draw this
			if(_isVertical)
			{
				_handleLength = (_length - BUTTON_SIZE*2) * _handlePotential;
				_handle = Factory_prettyBox.drawPrettyBox(BUTTON_SIZE,_handleLength,_handleColor);
				
				_handle.graphics.moveTo(3,_handle.height/2);
				_handle.graphics.lineTo(BUTTON_SIZE - 3,_handle.height/2);
				
				_handle.graphics.moveTo(3,_handle.height/2 - 3);
				_handle.graphics.lineTo(BUTTON_SIZE - 3,_handle.height/2 - 3);
				
				_handle.graphics.moveTo(3,_handle.height/2 + 3);
				_handle.graphics.lineTo(BUTTON_SIZE - 3,_handle.height/2 + 3);
			}else{//if its horizontal draw this
				_handleLength = (_length - BUTTON_SIZE*2) * _handlePotential;
				_handle = Factory_prettyBox.drawPrettyBox(_handleLength,BUTTON_SIZE,_handleColor);
				
				_handle.graphics.moveTo(_handle.width/2,3);
				_handle.graphics.lineTo(_handle.width/2,BUTTON_SIZE - 3);
				
				_handle.graphics.moveTo(_handle.width/2 - 3,3);
				_handle.graphics.lineTo(_handle.width/2 - 3,BUTTON_SIZE - 3);
				
				_handle.graphics.moveTo(_handle.width/2 + 3,3);
				_handle.graphics.lineTo(_handle.width/2 + 3,BUTTON_SIZE - 3);
			}
			
			_handle.buttonMode = true;
			_track.addChild(_handle);
		}
		
		//draw the track of the scrollBar
		private function drawTrack():void
		{
			//if vertical
			if(_isVertical)
			{
				_trackLength = _length - BUTTON_SIZE*2;
				_track = Factory_prettyBox.drawPrettyBox(BUTTON_SIZE,_trackLength,_trackColor,0,false,false,true);
				_track.y = BUTTON_SIZE;
			}else{//if horizontal
				_trackLength = _length - BUTTON_SIZE*2;
				_track = Factory_prettyBox.drawPrettyBox(_trackLength,BUTTON_SIZE,_trackColor,0,false,false,true);
				_track.x = BUTTON_SIZE;
			}
			
			this.addChild(_track);
		}
		
		//draw the arrow buttons of the scrollBar
		private function drawButtons():void
		{
			var button1Dir:String;
			var button2Dir:String;
			
			//determines the values of the button directions if its horizontal or vertical, these values get passed to the triangle Factory
			if(_isVertical)
			{
				button1Dir = "up";
				button2Dir = "down";
			}else{
				button1Dir = "left";
				button2Dir = "right";
			}
			
			//up/left arrow button
			var btn1Up:Sprite = Factory_prettyBox.drawPrettyBox(16,16,_buttonColor,0,true);
			var arrow1:Sprite = Factory_triangle.drawEqTriangle(8,3.5,_buttonArrowColor,button1Dir);
			arrow1.x = 8;
			arrow1.y = 8;
			btn1Up.addChild(arrow1);
			
			var btn1Down:Sprite = Factory_prettyBox.drawPrettyBox(16,16,_buttonColor,0,true,true,true);
			var arrow2:Sprite = Factory_triangle.drawEqTriangle(8,3.5,_buttonArrowColor,button1Dir);
			arrow2.x = 9;
			arrow2.y = 9;
			btn1Down.addChild(arrow2);
			
			_button1 = new Controller_button(btn1Up);
			_button1.downState = btn1Down;
			
			//down/right arrow button
			var btn2Up:Sprite = Factory_prettyBox.drawPrettyBox(16,16,_buttonColor,0,true);
			var arrow3:Sprite = Factory_triangle.drawEqTriangle(8,3.5,_buttonArrowColor,button2Dir);
			arrow3.x = 8;
			arrow3.y = 8;
			btn2Up.addChild(arrow3);
			
			var btn2Down:Sprite = Factory_prettyBox.drawPrettyBox(16,16,_buttonColor,0,true,true,true);
			var arrow4:Sprite = Factory_triangle.drawEqTriangle(8,3.5,_buttonArrowColor,button2Dir);
			arrow4.x = 9;
			arrow4.y = 9;
			btn2Down.addChild(arrow4);
			
			_button2 = new Controller_button(btn2Up);
			_button2.downState = btn2Down;
			
			//position the buttons based on if vertical or horizontal
			if(_isVertical)
			{
				_button2.y = _length - BUTTON_SIZE;
			}else{
				_button2.x = _length - BUTTON_SIZE;
			}
			
			this.addChild(_button1);
			this.addChild(_button2);
			
			//add event listeners to control handle movement
			_button1.addEventListener(MouseEvent.MOUSE_DOWN,onButtonDown);
			_button1.addEventListener(MouseEvent.MOUSE_UP,onButtonUp);
			_button2.addEventListener(MouseEvent.MOUSE_DOWN,onButtonDown);
			_button2.addEventListener(MouseEvent.MOUSE_UP,onButtonUp);
		}
		
		///////////////////Callbacks///////////////////////
		
		
		
		
		//slider changes position
		private function onChange(e:Event):void
		{
			_thisValue = _slider.value;
			var e:Event = new Event(Event.CHANGE);
			this.dispatchEvent(e);
			
			
			
		}
		
		//mouse down on buttons
		private function onButtonDown(e:MouseEvent):void
		{
			_direction = 1;
			
			if(e.target == _button1)
			{
				
				_direction = -1
			}
			
			this.addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		//mouse up
		private function onButtonUp(e:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		//when mouse is down this listner gets activated and makes the bar scroll
		private function onFrame(e:Event):void
		{
			var incr:Number = this.value + .1 * _direction;
			
			if(incr >=0 && incr <=1)
			{
				if(incr > 1)
				{
					this.value = 1;	
				}else if(incr < 0){
					this.value = 0;
				}else if(this.value != incr){
					this.value = incr;
					var e:Event = new Event(Event.CHANGE);
					this.dispatchEvent(e);
				}	
			}	
		}
		
		//////////////////Public methods//////////////////
		
		/**
		 * Redraw the entire scrollbar 
		 * 
		 */		
		public function drawScrollBar():void
		{
			//remove all the children - helps with memory
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			drawTrack();
			drawButtons();			
			drawHandle();
			
			//remove listeners
			if(_slider)
			{
				_slider.removeEventListener(Event.CHANGE,onChange);
			}
			//clear the _slider object
			_slider = null;
			//create a new slider object
			if(_isVertical)
			{
				_slider = new Slider(_handle,_track);
			}else{
				_slider = new Slider(_handle,_track,true);
			}
			
			_slider.value = _thisValue;
			_slider.addEventListener(Event.CHANGE,onChange);
		}
		
		////////////////Getters/Setters///////////////////
		/**
		 * SETTER
		 * Changes the size of the handle, usually used to indicate how many items are in whatever the scrollBar is controling 
		 * @param percent:Number percent value of the handle size 1 being the size of the track
		 * 
		 */		
		public function set handleSize(percent:Number):void
		{
			_thisValue = _slider.value;
			
			if(percent < .15)
			{
				_handlePotential = .15
			}else if(percent > 1){
				_handlePotential = 1;
			}else{
				_handlePotential = percent;
			}
			_slider.potential = _handlePotential;
		}
		/**
		 *	GETTER for handle size returns a percent 
		 * @return Number
		 * 
		 */		
		public function get handleSize():Number
		{
			return _handlePotential;
		}
		
		/**
		 * SETTER
		 * sets a manual value for the slider, takes a percent value 
		 * @param percent:Number percent value between 1 and 0
		 * 
		 */		
		public function set value(percent:Number):void
		{
			
			if(_slider)
			{
				_slider.value = percent;
			}
			
		}
		/**
		 * GETTER gets value as a percent between 0 and 1 
		 * @return Number
		 * 
		 */		
		public function get value():Number
		{
			if(_slider)
			{
				if(_slider.value > .94)
				{
					return 1;
				}else{
					return _slider.value;
				}
			}else{
				return -1;
			}	
		}
		
		/**
		 * SETTER  for scrollBar length
		 * @param value:Number sets length
		 * 
		 */		
		public function set length(value:Number):void
		{
			_length = value;
			drawScrollBar();
		}
		
		/**
		 * GETTER for scrollBar length 
		 * @return Number
		 * 
		 */		
		public function get length():Number
		{
			return _length
		}
		
		
		////////////////Static Methods///////////////////
		/**
		 * This method needs to be called before any scrollBars are instantiated.
		 * 
		 * 
		 */		
		public static function initScrollBars():void
		{
			setScrollBarColors();
			_scrollBarList = [];
		}
		
		/**
		 * This method can set/change all scrollBar colors of all instantiated scrollBars
		 * @param buttonColor:String Arrow Button color can be passed in as a css value ex. #FFFFFF or as an actionscript hex value 0xFFFFFF, either will work
		 * @param trackColor:String Track color can be passed in as a css value ex. #FFFFFF or as an actionscript hex value 0xFFFFFF, either will work
		 * @param buttonArrowColor:String Arrow color on the buttons can be passed in as a css value ex. #FFFFFF or as an actionscript hex value 0xFFFFFF, either will work
		 * @param handleColor:String handle color can be passed in as a css value ex. #FFFFFF or as an actionscript hex value 0xFFFFFF, either will work
		 * 
		 */		
		public static function setScrollBarColors(buttonColor:String = "#aaaaaa", trackColor:String = "#ffffff", buttonArrowColor:String = "#333333", handleColor:String = "#aaaaaa"):void
		{
			_buttonColor = uint(DrawingUtils.fixColorCode(buttonColor));
			_trackColor = uint(DrawingUtils.fixColorCode(trackColor));
			_buttonArrowColor = uint(DrawingUtils.fixColorCode(buttonArrowColor));
			_handleColor = uint(DrawingUtils.fixColorCode(handleColor));
			
			redDrawAll();
		}
		
		/**
		 * redraws all scrollbars instantiated 
		 * 
		 */		
		public static function redDrawAll():void
		{
			for each(var sb:ScrollBar in _scrollBarList)
			{
				sb.drawScrollBar();
			}
		}
		
		
	}
}