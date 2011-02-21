package com.clink.factories
{
	import com.clink.utils.Convert;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Factory_prettyBox extends Sprite
	{
		public function Factory_prettyBox()
		{
			super();
		}
		
		/**
		 * This public static method draws a pre formatted box, either with or without rounded corners.
		 * This is intended to be used with almost every object created, so customization can be facilitated.
		 * 
		 */
		public static function drawPrettyBox(width:Number, height:Number, fillColor:uint,cornerRadius:Number = 0, gradient:Boolean = false, reverseGradient:Boolean = false, reverseBorder:Boolean = false,strokeSize:Number = 1 ,alpha:Number = 1):Sprite
		{
			var drawIntoThis:Sprite = new Sprite();
			var x:Number = 0;
			var y:Number = 0;
			var borderColors:Array = [];
			
			drawIntoThis.graphics.lineStyle(strokeSize,fillColor,alpha);
			
			//draw rectangle
			if(gradient)
			{
				borderColors = DrawingUtils.getBorderColors(fillColor,4);
				var gradColors:Array = DrawingUtils.getBorderColors(fillColor,2);
				
				var deg:Number = Convert.degreesToRadians(90);
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox(width,height,deg,x,y);
				if(reverseGradient)
				{
					drawIntoThis.graphics.beginGradientFill(GradientType.LINEAR, [gradColors[2],gradColors[1]],[1,1],[25,227],matrix);
				}else{
					drawIntoThis.graphics.beginGradientFill(GradientType.LINEAR, [gradColors[1],gradColors[2]],[1,1],[25,227],matrix);
				}
				
			}else{
				borderColors = DrawingUtils.getBorderColors(fillColor,4);
				drawIntoThis.graphics.beginFill(fillColor,alpha);
			}
			
			//if there are rounded corners, switch the border to a gradient to fit the rounded corners
			if(cornerRadius > 0)
			{
				var borderMatrix:Matrix = new Matrix();
				borderMatrix.createGradientBox(width,height,Math.atan(height/(width - (width-height))),x,y);
				
				if(!reverseBorder)
				{
					drawIntoThis.graphics.lineGradientStyle(GradientType.LINEAR, [borderColors[1],borderColors[2]],[1,1],[110,137],borderMatrix)
				}else{
					drawIntoThis.graphics.lineGradientStyle(GradientType.LINEAR, [borderColors[2],borderColors[1]],[1,1],[110,137],borderMatrix);
				}
			}
			
			drawIntoThis.graphics.drawRoundRect(x,y,width,height,cornerRadius,cornerRadius);
			drawIntoThis.graphics.endFill();
			
			//if there are no rounded corners than draw normal borders
			if(cornerRadius <= 0)
			{
				//light border
				if(!reverseBorder)
				{
					drawIntoThis.graphics.lineStyle(strokeSize,borderColors[1],alpha);
				}else{
					drawIntoThis.graphics.lineStyle(strokeSize,borderColors[2],alpha);
					
				}
				
				drawIntoThis.graphics.moveTo(x,y + height);
				drawIntoThis.graphics.lineTo(x,y);
				drawIntoThis.graphics.lineTo(x + width, y);
				drawIntoThis.graphics.endFill();
				
				//dark border
				if(!reverseBorder)
				{
					drawIntoThis.graphics.lineStyle(strokeSize,borderColors[2],alpha);
				}else{
					drawIntoThis.graphics.lineStyle(strokeSize,borderColors[1],alpha);
				}
				
				drawIntoThis.graphics.moveTo(x + width, y);
				drawIntoThis.graphics.lineTo(x + width, y + height);
				drawIntoThis.graphics.lineTo(x, y + height);
				drawIntoThis.graphics.endFill();
			}
			
			return drawIntoThis;
		}
	}
}