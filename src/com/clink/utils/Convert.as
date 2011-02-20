package com.clink.utils
{
	/**
	 * Class containing useful conversion functions 
	 * @author adamrensel
	 * 
	 */	
	public class Convert
	{
		public function Convert()
		{
		}
		/**
		 * Convert radians to degrees, number value required. 
		 * @param radians
		 * @return 
		 * 
		 */		
		public static function radiansToDegrees(radians:Number):Number
		{
			return radians * (180 / Math.PI);
		}
		/**
		 * Convert degrees to radians, number value required. 
		 * @param degrees
		 * @return 
		 * 
		 */		
		public static function degreesToRadians(degrees:Number):Number
		{
			return degrees * ( Math.PI / 180);
		}
		/**
		 * Convert seconds to millseconds, number value required. 
		 * @param secs
		 * @return 
		 * 
		 */		
		public static function secondsToMilli(secs:Number):Number
		{
			return secs * 1000;
		}
		/**
		 * Convert milliseconds to seconds, number value required. 
		 * @param milli
		 * @return 
		 * 
		 */		
		public static function milliToSeconds(milli:Number):Number
		{
			return milli / 1000;
		}

	}
}