package com.clink.utils
{
	public class StringUtils
	{
		public function StringUtils()
		{
		}
		/**
		 * Takes a string and deletes all characters after the index specified, than rounds the string to the nearest word seperated by a space. 
		 * @param string
		 * @param numChars
		 * @param roundToNearestWord
		 * @param hypenate
		 * @return 
		 * 
		 */		
		public static function chop(string:String,numChars:int,roundToNearestWord:Boolean = true,hypenate:Boolean = false):String
		{
			var choppedString:String = string;
			//trace(choppedString.length + ">" + numChars + "?")
			if(choppedString.length > numChars)
			{
				choppedString = choppedString.slice(0,numChars + 1);
			
				
				if(!hypenate)
				{
					if(roundToNearestWord)
					{
						for(var i:int = choppedString.length - 1; i > 0; i--)
						{
							if(choppedString.charAt(i) == " " && choppedString.charAt(i-1) != " ")
							{
								choppedString = choppedString.slice(0,i);
								return choppedString;
							}
						}
					}
				}else{
					return choppedString + "-";
				}
			}
			
			return choppedString;
		}
		/**
		 * takes all the excess white spaces out of a string and leaves only one between characters 
		 * @param string
		 * @return 
		 * 
		 */		
		public static function trimExtraWhiteSpace(string:String):String
		{
			var trimmedString:String = string;
			var stringArray:Array;
			
			stringArray = trimmedString.split(" ");
			
			stringArray = stringArray.filter(noSpace);
			
			return stringArray.join(" ");
		}
		private static function noSpace(element:String, index:int, array:Array):Boolean {
			return (element != "");
		}
		/**
		 * this funnction will strip out line breaks from a string. The default where allLineBreaks = false only strips out line returns(\r)
		 * while if set to true it will strip out even the new line breaks, these are usually after paragraphs(\n). 
		 * @param string
		 * @param allLineBreaks
		 * @return 
		 * 
		 */		
		public static function trimLineBreaks(string:String, allLineBreaks:Boolean = false):String
		{
			var s:String = string;
			if(allLineBreaks)
			{
				s = s.split("\n").join(" ");
			}
			
			return s.split("\r").join(" ");
		}
		/**
		 * counts the amount of characters specified in a string. 
		 * @param string
		 * @param chars
		 * @return 
		 * 
		 */		
		public static function countChars(string:String,chars:String):int
		{
			return string.match(new RegExp(chars,"g")).length;
		}
		
		public static function trimExtraLineBreaks(string:String):String
		{
			var trimmedString:String = string;
			
			for(var i:int = 0; i < 20; i++)
			{
				trimmedString = trimmedString.replace(new RegExp("\r\r","g"),"\r");
				trimmedString = trimmedString.replace(new RegExp("\r\n","g"),"\r");
				trimmedString = trimmedString.replace(new RegExp("\n\n","g"),"\n");
				trimmedString = trimmedString.replace(new RegExp("\n\r","g"),"\n");
				trimmedString = trimmedString.replace(new RegExp("\n ","g"),"\n");
				trimmedString = trimmedString.replace(new RegExp("\r ","g"),"\n");
				trimmedString = trimmedString.replace(new RegExp(" \n","g"),"\n");
				trimmedString = trimmedString.replace(new RegExp(" \r","g"),"\n");
			}
			
			
			return trimmedString;
		}


	}
}