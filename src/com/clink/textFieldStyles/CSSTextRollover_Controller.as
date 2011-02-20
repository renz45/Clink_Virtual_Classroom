package com.clink.textFieldStyles
{
	import flash.text.StyleSheet;
	
	public class CSSTextRollover_Controller
	{
		/**
		 * class containing public static functions which return stylesheets for styling htmlText in TextFields. 
		 * 
		 */		
		public function CSSTextRollover_Controller()
		{
			
		}
		/**
		 * public static function that creates a css styleSheet property to make css rollovers on textfields using htmlText with anchor tags.
		 * the color values must be passed in as strings and in normal css style(#666666, #444444, etc).
		 * the function returns a stylesheet, and the receiving text field must be given this, 
		 * example - myTF.styleSheet =  CSSTextRollover_Controller.colorRollover("#444444","#FF0000",#444444);
		 * 
		 * @param unvisitedColor
		 * @param rolloverColor
		 * @param visitedColor
		 * @return 
		 * 
		 */		
		public static function colorRollover(unvisitedColor:String,rolloverColor:String,visitedColor:String):StyleSheet
		{
			var style:StyleSheet = new StyleSheet();

            var aHover:Object = new Object();
            aHover.color = rolloverColor;

            var aLink:Object = new Object();
            aLink.color = unvisitedColor;
            
            var aVisited:Object = new Object();
            aVisited.color = visitedColor;

			style.setStyle("a:link", aLink);
			style.setStyle("a:visited", aVisited);
            style.setStyle("a:hover", aHover);

            return style;

		}

	}
}