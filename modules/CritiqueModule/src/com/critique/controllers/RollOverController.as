package com.critique.controllers
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * This class will automatically control a button rollover.
	 * 
	 * @example Example of proper use:
	 * <listing version = 3.0>
	 * var btn:Button = new Button();
	 * var rc:RollOverController = new RollOverController(btn);
	 * addChild(btn);
	 * </listing>
	 *
	 * 
	 */	
	public class RollOverController
	{
		private var _mc:MovieClip;
		private var dir:Number = 1;
		
		public function RollOverController(mc:MovieClip)
		{
			this.movieClip = mc;
		}
		
		private function buttonOver_Handler(evt:MouseEvent):void
		{
			dir = 1;
			_mc.addEventListener(Event.ENTER_FRAME, buttonOnFrame_Handler,false,0,true);
		}
		
		private function buttonOut_Handler(evt:MouseEvent):void
		{
			dir = -1
		}
		
		private function buttonOnFrame_Handler(evt:Event):void
		{
			_mc.gotoAndStop(_mc.currentFrame + dir);
			
			if(_mc.currentFrame == 1 && dir == -1)
			{
				_mc.removeEventListener(Event.ENTER_FRAME, buttonOnFrame_Handler);
			}
		}
		/**
		 * @private
		 * @param mc
		 * 
		 */		
		public function set movieClip(mc:MovieClip):void
		{
			_mc = mc
			_mc.gotoAndStop(1);
			
			_mc.addEventListener(MouseEvent.ROLL_OVER, buttonOver_Handler);
			_mc.addEventListener(MouseEvent.ROLL_OUT, buttonOut_Handler);
		}
		/**
		 * Property where the MovieClip/Button can be changed after the class is instantiated. 
		 * @return 
		 * 
		 */		
		public function get movieClip():MovieClip
		{
			return _mc;
		}

	}
}