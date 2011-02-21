package com.clink.factories
{
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	
	public class Factory_triangle extends Sprite
	{
		public static const DIRECTION_UP:String = "up";
		public static const DIRECTION_DOWN:String = "down";
		public static const DIRECTION_LEFT:String = "left";
		public static const DIRECTION_RIGHT:String = "right";
		
		public function Factory_triangle()
		{
			super();
		}
		
		public static function drawEqTriangle(width:Number,height:Number, color:uint, direction:String = "up", drawBorder:Boolean = true ):Sprite
		{
			var t:Sprite = new Sprite();
			
			var borderColors:Array = DrawingUtils.getBorderColors(color,3);
			
			if(drawBorder)
			{
				t.graphics.lineStyle(1,borderColors[2]);
			}
			
			t.graphics.beginFill(color);
			t.graphics.moveTo(-width/2,height/2);
			t.graphics.lineTo(0, -height/2);
			t.graphics.lineTo(width/2,height/2);
			t.graphics.lineTo(-width/2,height/2);
			t.graphics.endFill();
			
			switch(direction)
			{
				case "up":
					t.rotation = 0;
					break;
				case "down":
					t.rotation = 180;
					break;
				case "left":
					t.rotation = 270;
					break;
				case "right":
					t.rotation = 90;
					break;
			}
				
			return t;
		}
	}
}