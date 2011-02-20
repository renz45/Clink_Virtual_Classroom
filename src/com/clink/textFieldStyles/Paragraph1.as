package com.clink.textFieldStyles
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Paragraph1
	{
		
		private static var tFormat:TextFormat = new TextFormat("Helvetica",10,0x000000);
		private static var textFields:Array;
		
		private var _tf:TextField;
		
		public static function textFormat(font:String = "Helvetica",textSize:Number = 10,color:int = 0x000000,bold:Boolean = false,italic:Boolean = false,underLine:Boolean = false):void
		{
			tFormat = new TextFormat(font,textSize,color,bold,italic,underLine);
			
			if(textFields)
			{
				for each(var tf:TextField in textFields)
				{
					tf.defaultTextFormat = tFormat;
					tf.setTextFormat(tFormat);
				}
			}
			
			if(!textFields)
			{
				textFields = [];
			}
			
		}
		
		
		public function Paragraph1(content:String,container:DisplayObjectContainer,width:Number = 100,height:Number = 100)
		{
			if(!textFields)
			{
				textFields = [];
			}
			
			_tf = createTF();
			_tf.multiline = true;
			_tf.text = content;
			_tf.width = width;
			_tf.height = 100;
			container.addChild(_tf);
			
			textFields.push(_tf);
			
			
			
		}
		
		private function createTF():TextField
		{
			var tf:TextField = new TextField()
			tf.defaultTextFormat = tFormat;
			
			return tf;
		}
		
		public function set text(text:String):void
		{
			_tf.text = text;
		}
		
		public function get text():String
		{
			return _tf.text;
		}

	}
}