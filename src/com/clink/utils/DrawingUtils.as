package com.clink.utils
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class DrawingUtils extends Sprite
	{
		
		public function DrawingUtils()
		{
			super();
		}
		
		
		/**
		 * Takes a color code formatted like "#ffeeff"(string) and outputs a proper hex code AS3 can use: 0xffeeff
		 * 
		 * 
		 */
		public static function fixColorCode($color:String) :String
		{
			var submittedColor:String = $color;
			var validColor:String;
			var pattern:RegExp = /#/;
			
			submittedColor = $color.replace(pattern,"");
			
			pattern = /0x/;
			if (submittedColor.substring(0,2) != "0x") {
				validColor = "0x"+submittedColor;
			} else {
				validColor = submittedColor;
			}
			
			return validColor;	
		}
		
		/**
		 * returns an array of colors [orginal,light,dark] based off the original color. Darker and lighter depending on the contrast value
		 * 
		 */
		public static function getBorderColors(color:uint,contrast:int = 5):Array
		{
			var RGBColor:Object = DrawingUtils.hexToRGB(color);
			var cLight:Object = {};
			var cDark:Object = {};
			
			var	RGBColorSortedKeys:Array = ArrayUtils.sortObjectNumericValues(RGBColor,false);
			
			
			
			for(var key:String in RGBColor)
			{
				cDark[key] = RGBColor[key] - (contrast * 14);
				cDark[key] = Math.min(cDark[key], 255); // -- make sure below 255
				cDark[key] = Math.max(cDark[key], 0);   // -- make sure above 0
			}
			
			//this chunk prevents a value of 0xFFFFFF from being returned in every instance, this way lighter colors are as light as those colors can get, not white
			for (var i:int = 0;i <  RGBColorSortedKeys.length; i++)
			{
				
				cLight[RGBColorSortedKeys[i]] =  RGBColor[RGBColorSortedKeys[i]] + (contrast * 17);
				
				if(i == 0 || RGBColor[RGBColorSortedKeys[i]] == RGBColor[RGBColorSortedKeys[0]])
				{
					cLight[RGBColorSortedKeys[i]] = Math.min(cLight[RGBColorSortedKeys[i]], 245); // -- make sure below 255
				}else if(RGBColor[RGBColorSortedKeys[i]] == RGBColor[RGBColorSortedKeys[2]]){
					cLight[RGBColorSortedKeys[i]] = Math.min(cLight[RGBColorSortedKeys[i]], 238);
				}else{
					cLight[RGBColorSortedKeys[i]] = Math.min(cLight[RGBColorSortedKeys[i]], 221);
				}
				
				cLight[RGBColorSortedKeys[i]] = Math.max(cLight[RGBColorSortedKeys[i]], 0);   // -- make sure above 0
			}
			
			return [color, DrawingUtils.RGBToHex(cLight), DrawingUtils.RGBToHex(cDark)];
		}
		
		/**
		 * Convert a uint (0x000000) to a color object.
		 *
		 * @param hex  Color.
		 * @return Converted object {r:, g:, b:}
		 */
		public static function hexToRGB(hex:uint):Object
		{
			var c:Object = {};
			
			c.a = hex >> 24 & 0xFF;
			c.r = hex >> 16 & 0xFF;
			c.g = hex >> 8 & 0xFF;
			c.b = hex & 0xFF;
			
			return c;
		}
		
		/**
		 * Convert a color object to uint octal (0x000000).
		 *
		 * @param c  Color object {r:, g:, b:}.
		 * @return Converted color uint (0x000000).
		 */
		public static function RGBToHex(c:Object):uint
		{
			var ct:ColorTransform = new ColorTransform(0, 0, 0, 0, c.r, c.g, c.b, 100);
			return ct.color as uint
		}

	}
}