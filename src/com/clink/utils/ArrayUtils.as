package com.clink.utils
{
	import flash.display.Sprite;
	
	public class ArrayUtils extends Sprite
	{
		public function ArrayUtils()
		{
			super();
		}
		
		/**
		 * Sorts and object based on the key's values being numbers. 
		 * 
		 * returns array of key names in the sorted order
		 * 
		 * @param object:Object object to be sorted
		 * @param smallToLarge:Boolean indicates the order to sort
		 */
		public static function sortObjectNumericValues(object:Object, smallerToLarge:Boolean = true):Array
		{
			var valueArr:Array = [];
			var sortedObjectKeys:Array = [];
			
			for(var key:String in object)
			{
				valueArr.push(object[key]);
			}
			
			valueArr.sort(Array.NUMERIC);
			
			if(!smallerToLarge)
			{
				valueArr.reverse();
			}
			
			for(var i:int; i < valueArr.length; i++)
			{
				for(var key2:String in object)
				{
					if(object[key2] == valueArr[i] && sortedObjectKeys.indexOf(key2) == -1)
					{
						sortedObjectKeys.push(key2);
					}
				}
			}
			
			return sortedObjectKeys;
		}
	}	
}