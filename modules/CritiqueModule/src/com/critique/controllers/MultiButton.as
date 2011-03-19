package com.critique.controllers
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MultiButton
	{
		private var _button:MovieClip;
		private var _rollover:Boolean;
		private var _toggle:Boolean;
		/**
		 * button controller class used to control button states, toggle and rollover functions are optional set by boolean values.
		 * 
		 * animation frame labels are "up" "down" " over"
		 *  
		 * @param button
		 * @param rollover
		 * @param toggle
		 * 
		 */		
		public function MultiButton(button:MovieClip,rollover:Boolean = false,toggle:Boolean = false)
		{
			_button = button;
			_rollover = rollover;
			_toggle = toggle;
			
			button.buttonMode = true;
			button.mouseChildren = false;
			button.gotoAndStop("up");
			
			//_button.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			//_button.stage.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			//_button.addEventListener(Event.ADDED_TO_STAGE,onStage);
			_button.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			_button.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			
			if(_rollover)
			{
				_button.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
				_button.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			}
			
		}
	
		private function mouseDown(evt:MouseEvent):void
		{
			if(_toggle && _button.currentLabel == "down")
			{
				if(_rollover)
				{
					_button.gotoAndStop("over");
				}else{
					_button.gotoAndStop("up");
				}
			}else{
				_button.gotoAndStop("down");
			}
		}
		private function mouseUp(evt:MouseEvent):void
		{
			if(!_toggle)
			{
				if(_rollover)
				{
					_button.gotoAndStop("over");
				}else{
					_button.gotoAndStop("up");
				}
				
			} 
	
		}
		private function mouseOver(evt:MouseEvent):void
		{
			if(_toggle && _button.currentLabel == "up")
			{
				_button.gotoAndStop("over");
			}
			
			if(!_toggle)
			{
				_button.gotoAndStop("over");
			}
			
		}
		private function mouseOut(evt:MouseEvent):void
		{
			if(_toggle && _button.currentLabel == "over")
			{
				_button.gotoAndStop("up");
			}
			
			if(!_toggle)
			{
				_button.gotoAndStop("up");
			}
		}
		/**
		 * public method for manually setting an up state 
		 * 
		 */		
		public function up():void
		{
			_button.gotoAndStop("up");
		}
		/**
		 * public method for manually setting a down state 
		 * 
		 */		
		public function down():void
		{
			_button.gotoAndStop("down");
		}

	}
}