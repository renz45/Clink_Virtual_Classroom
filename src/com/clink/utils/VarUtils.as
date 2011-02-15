package com.clink.utils
{
	import flash.utils.ByteArray;

	public class VarUtils extends Object
	{
		/**
		 * Collection of static functions used for various utilities
		 *
		 */
		public function VarUtils()
		{
			super();
		}
		
		/**
		 * Returns the datatype of an object as a String
		 *
		 * @param variable:Object Object to test for datatype
		 *
		 * @return String
		 */
		public static function getDataType(variable:Object):String
		{
			if(variable is int)
			{
				return "int";
			}else if(variable is Number){
				return "Number";
			}else if(variable is String){
				return "String";
			}else if(variable is Array){
				return "Array";
			}else if(variable is Boolean){
				return "Boolean";
			}else if(variable is Object){
				return "Object";
			}else{
				return "false";
			}
		}
		
		/**
		 * Copies an object, returns the copy. (Be aware, his will break all references within an object)
		 *
		 * @param object:Object Object to copy
		 *
		 * @return Object
		 */
		public static function copyObject(object:Object):Object
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(object);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		/**
		 * Compare two objects and returns a boolean to indicate if they are the same or not
		 *
		 * @param object1:Object First Object to compare
		 * @param object2:Object Second Object to compare
		 *
		 * @return Boolean
		 */
		public static function compareObjects(object1:Object,object2:Object):Boolean
		{
			var bytes1:ByteArray = new ByteArray();
			bytes1.writeObject(object1);
			
			var bytes2:ByteArray = new ByteArray();
			bytes2.writeObject(object2);
			return bytes1.toString() === bytes2.toString();
		}
	}
}