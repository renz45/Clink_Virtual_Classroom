package com.clink.utils
{
	import flash.geom.Point;
	
	public class MathUtil
	{
		/**
		 * Assortment of static functions for different math operations 
		 * 
		 */		
		public function MathUtil()
		{
		}
		/**
		 * Public static function used to find the average from a group of numbers. Function accepts an array of numbers, returns a number. 
		 * @param numberList
		 * @return 
		 * 
		 */		
		public static function average(numberList:Array):Number
		{
			var total:Number = 0;
			
			for each(var n:Number in numberList)
			{
				total += n;
			}
			
			return total = total / (numberList.length);
		}
		/**
		 * public static function that finds the angle between 2 points.  Accepts 2 points, returns a number in degrees.
		 * @param point1
		 * @param point2
		 * @return 
		 * 
		 */		
		public static function getAngle(point1:Point,point2:Point):Number
		{
			var radians:Number = Math.atan2(point1.y - point2.y, point1.x - point2.x);
			
			return Convert.radiansToDegrees(radians);
		}
		/**
		 * public static function that gives the whole number at a certain decimal place, and only that number as a positive int 
		 * @param number
		 * @param getNumberAtDecimal
		 * @return 
		 * 
		 */		
		public static function getNumberFrom(number:Number,getNumberAtDecimal:int):Number
		{
			return (int(number * Math.pow(10,getNumberAtDecimal))) - int((number * Math.pow(10,getNumberAtDecimal - 1))) * 10;	
		}
		
		public static function getDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			
			var answer:Number =  Math.sqrt(dx * dx + dy * dy)
			if(answer < 0)
			{
				return answer * -1;
			}else{
				return answer;
			}
		}


	}
}