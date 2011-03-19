package com.critique.controllers
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class PlayPauseButton
	{
		private var _button:MovieClip;
		private var _rollover:Boolean;
		
		/**
		 * Custom button class for a play/pause toggle with an optional rollover state.
		 * 
		 * The required frame labels within the button movieClip are playUp, playDown, playOver, pauseUp, pauseDown, pauseOver
		 *  
		 * @param button
		 * @param rollover
		 * 
		 */		
		public function PlayPauseButton(button:MovieClip,rollover:Boolean = false)
		{
			_button = button;
			_rollover = rollover;
			
			button.buttonMode = true;
			button.mouseChildren = false;
			button.gotoAndStop("up");
			
			_button.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			_button.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			
			if(_rollover)
			{
				_button.addEventListener(MouseEvent.MOUSE_OVER,mouseOver);
				_button.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
			}
			
		}
		
		private function mouseDown(evt:MouseEvent):void
		{
			if(!_rollover)
			{	
				if(_button.currentLabel == "playUp")
				{
					_button.gotoAndStop("playDown");
				}else{
					_button.gotoAndStop("pauseDown");
				}
			}else{
				if(_button.currentLabel == "playOver")
				{
					_button.gotoAndStop("playDown");
				}else{
					_button.gotoAndStop("pauseDown");
				}
			}
	
		}
		private function mouseUp(evt:MouseEvent):void
		{
				if(_button.currentLabel == "playDown")
				{
					if(_rollover)
					{
						_button.gotoAndStop("pauseOver");
					}else{
						_button.gotoAndStop("pauseUp");
					}
				}else{
					if(_rollover)
					{
						_button.gotoAndStop("playOver");
					}else{
						_button.gotoAndStop("playUp");
					}
					
				}
	
		}
		private function mouseOver(evt:MouseEvent):void
		{
			if(_button.currentLabel == "playUp")
			{
				_button.gotoAndStop("playOver");
			}else{
				_button.gotoAndStop("pauseOver");
			}
		}
		private function mouseOut(evt:MouseEvent):void
		{
			if(_button.currentLabel == "playOver")
			{
				_button.gotoAndStop("playUp");
			}else{
				_button.gotoAndStop("pauseUp");
			}
		}
		/**
		 *	public method used to manually set a play state 
		 * 
		 */		
		public function play():void
		{
				_button.gotoAndStop("playUp");
		}
		/**
		 * public method used to manually set a paused state 
		 * 
		 */		
		public function pause():void
		{
				_button.gotoAndStop("pauseUp");
		}

	}
}