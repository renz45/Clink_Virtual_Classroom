package com.clink.ui
{
	import com.clink.controllers.Controller_button;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.factories.Factory_triangle;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
		
		
		private const BUTTON_SIZE:Number = 16;
		
		private static var _buttonColor:uint;
		private static var _trackColor:uint;
		private static var _buttonArrowColor:uint;
		private static var _handleColor:uint;
		private static var _scrollBarList:Array;
		
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
			
			_handlePotential = .5;
			_thisValue = 0;
			
			drawScrollBar();
		}
		
		private function drawHandle():void
		{
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
			}else{
				_handleLength = (_length - BUTTON_SIZE*2) * _handlePotential;
				_handle = Factory_prettyBox.drawPrettyBox(_handleLength,BUTTON_SIZE,_handleColor);
				
				_handle.graphics.moveTo(_handle.width/2,3);
				_handle.graphics.lineTo(_handle.width/2,BUTTON_SIZE - 3);
				
				_handle.graphics.moveTo(_handle.width/2 - 3,3);
				_handle.graphics.lineTo(_handle.width/2 - 3,BUTTON_SIZE - 3);
				
				_handle.graphics.moveTo(_handle.width/2 + 3,3);
				_handle.graphics.lineTo(_handle.width/2 + 3,BUTTON_SIZE - 3);
			}
			
			_track.buttonMode = true;
			_track.addChild(_handle);
		}
		
		private function drawTrack():void
		{
			if(_isVertical)
			{
				_trackLength = _length - BUTTON_SIZE*2;
				_track = Factory_prettyBox.drawPrettyBox(BUTTON_SIZE,_trackLength,_trackColor,0,false,false,true);
				_track.y = BUTTON_SIZE;
			}else{
				_trackLength = _length - BUTTON_SIZE*2;
				_track = Factory_prettyBox.drawPrettyBox(_trackLength,BUTTON_SIZE,_trackColor,0,false,false,true);
				_track.x = BUTTON_SIZE;
			}
			
			this.addChild(_track);
		}
		
		private function drawButtons():void
		{
			var button1Dir:String;
			var button2Dir:String;
			
			if(_isVertical)
			{
				button1Dir = "up";
				button2Dir = "down";
			}else{
				button1Dir = "left";
				button2Dir = "right";
			}
			
			//up arrow button
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
			
			//down arrow button
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
			
			if(_isVertical)
			{
				_button2.y = _length - BUTTON_SIZE;
			}else{
				_button2.x = _length - BUTTON_SIZE;
			}
			
			this.addChild(_button1);
			this.addChild(_button2);
		}
		
		///////////////////Callbacks///////////////////////
		private function onChange(e:Event):void
		{
			_thisValue = _slider.value;
			var e:Event = new Event(Event.CHANGE);
			this.dispatchEvent(e);
			
		}
		
		//////////////////Public methods//////////////////
		public function drawScrollBar():void
		{
			
			while(this.numChildren > 0)
			{
				this.removeChildAt(0);
			}
			
			drawTrack();
			drawButtons();			
			drawHandle();
			
			if(_slider)
			{
				_slider.removeEventListener(Event.CHANGE,onChange);
			}
			
			_slider = null;
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
		
		public function set handleSize(percent:Number):void
		{
			_thisValue = _slider.value;
			//trace(percent);
			
			if(percent < .15)
			{
				_handlePotential = .15
			}else{
				_handlePotential = percent;
			}
				
			
			
			drawScrollBar();
		}
		
		public function set value(percent:Number):void
		{
			if(_slider)
			{
				_slider.value = percent;
			}
		}
		
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
		
		
		////////////////Static Methods///////////////////
		public static function initScrollbars(buttonColor:String = "#aaaaaa", trackColor:String = "#ffffff", buttonArrowColor:String = "#333333", handleColor:String = "#aaaaaa"):void
		{
			_buttonColor = uint(DrawingUtils.fixColorCode(buttonColor));
			_trackColor = uint(DrawingUtils.fixColorCode(trackColor));
			_buttonArrowColor = uint(DrawingUtils.fixColorCode(buttonArrowColor));
			_handleColor = uint(DrawingUtils.fixColorCode(handleColor));
			_scrollBarList = [];
			
			redDrawAll();
		}
		
		public static function redDrawAll():void
		{
			for each(var sb:ScrollBar in _scrollBarList)
			{
				sb.drawScrollBar();
			}
		}
		
		
	}
}