package com.clink.ui
{
	import flash.display.Sprite;
	
	public class Spacer extends Sprite
	{
		private var _width:Number;
		private var _height:Number;
		
		public function Spacer(width:Number,height:Number)
		{
			super();
			
			_width = width;
			_height = height;
			
			init();
		}
		
		private function init():void
		{
			this.graphics.beginFill(0xffffff,0);
			this.graphics.drawRect(0,0,_width,_height);
			this.graphics.endFill();
			this.mouseEnabled = false;
		}
	}
}