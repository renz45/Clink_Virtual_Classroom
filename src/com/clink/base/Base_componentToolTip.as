package com.clink.base
{
	import com.clink.factories.Factory_prettyBox;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import flashx.textLayout.formats.TextAlign;

	/**
	 * Base component for all interactive elements. This provides toolTip functionality for an element. 
	 * The msg, bg color, text color, max tooltip width are set via static setters
	 * 
	 * the static method initTooltips() needs to be called before any tooltips can be created or an error is thrown
	 * 
	 * 
	 */
	public class Base_componentToolTip extends Sprite
	{
		private var _msg:String;
		private var _toolTip:Sprite;
		
		private var _toolTipPadding:Number = 2;
		private var _delayTimer:Timer;
		
		private static var _bgColor:uint;
		private static var _textColor:uint
		private static var _toolTipList:Array;
		private static var _textSize:Number;
		private static var _toolTipWidth:Number;
		private static var _font:Font;
		private static var _initialized:Boolean = false;
		private static var _displayDelay:Number;
		private static var _stage:Stage;
		
		public function Base_componentToolTip()
		{
			super();
			
			//check to make sure this class was initialized
			if(!_initialized)
			{
				throw new Error("This class must be initialized by calling the static method initToolTips() before any tooltips are generated.");
			}else{
				init();
			}
			
		}
		
		private function init():void
		{
			_msg = "";
			
			_delayTimer = new Timer(0);
			_toolTipList.push(this);
			
			this.addEventListener(MouseEvent.ROLL_OVER,onMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
			
		}
		
		private function onTimerComplete(e:TimerEvent):void
		{
			var stagePos:Point = localToGlobal(new Point(mouseX,mouseY));
			
			_toolTip.x = stagePos.x;
			_toolTip.y = stagePos.y - _toolTip.height;
		
			//check to make sure the tooltip is on the stage, if not move it down so it can be seen
			if(stagePos.y - _toolTip.height < 0)
			{
				_toolTip.y = 0;
			}
			
			//checks to make sure the tooltip doesn't continue off the right of the stage, if it does it is moved left until it's edge meets the stage
			if(stagePos.x + _toolTip.width > _stage.stageWidth)
			{
				_toolTip.x = _stage.stageWidth - _toolTip.width;
			}
			
			_stage.addChild(_toolTip);
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			if(_toolTip)
			{
				_delayTimer.delay = _displayDelay;
				_delayTimer.start();
				_delayTimer.addEventListener(TimerEvent.TIMER,onTimerComplete);
			}
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			_delayTimer.reset();
			
			if(_toolTip && _toolTip.parent == _stage)
			{
				_stage.removeChild(_toolTip);
			}
		}
		///////////////PUBLIC METHODS//////////////
		
		/**
		 * draws the tooltip, this is called by other functions when colors/text are changed
		 * 
		 */
		public function drawToolTip():void
		{
			if(_toolTip && _toolTip.parent == _stage)
			{
				_stage.removeChild(_toolTip);
			}
			_toolTip = null;
			
			//create text field 
			var tf:TextField = new TextField();
			tf.embedFonts = true;
			tf.autoSize = TextFieldAutoSize.RIGHT;
			
			//sets a default text format to the toolTip
			tf.defaultTextFormat = new TextFormat(_font.fontName,_textSize,_textColor,null,null,null,null,null,TextAlign.LEFT);
			tf.text = _msg;
			
			
			//resize the tooltip to a max width and turn on word wrap if it is larger than the max width
			if(tf.width > _toolTipWidth)
			{
				tf.width = _toolTipWidth;
				tf.wordWrap = true;
			}
			
			//draw the tooltip bg and add the textfield to the background centering it with padding
			_toolTip = Factory_prettyBox.drawPrettyBox(tf.width + _toolTipPadding*2, tf.height + _toolTipPadding*2,_bgColor,0,false,false,false,2,1,.8);
			tf.x = tf.y = _toolTipPadding;
			_toolTip.addChild(tf);
			_toolTip.mouseEnabled = false;
			_toolTip.mouseChildren = false;

		} 
		
		
		/////////////SETTERS/GETTERS///////////////
		
		/**
		 * setter for toolTip message 
		 * @param msg:String
		 * 
		 */		
		public function set message(msg:String):void
		{
			_msg = msg;
			drawToolTip();
		}
		
		/**
		 * getter for tooltip message
		 * 
		 * @return String
		 */
		public function get message():String
		{
			return _msg;
		}
		
		//////////////STATICS(used for setting up colors)////////////////
		/**
		 * initializes the tooltips, this must be called before this class or any class that extends it can be used.
		 * ***If this is not called, an error is thrown***
		 * 
		 * @param bgColor:String color of the toolTip BG. Can either be passed as a css hex value #ffffff or a AS hex value 0xffffff
		 * @param textColor:String color of the toolTip text. Can either be passed as a css hex value #ffffff or a AS hex value 0xffffff
		 * @param textSize:Number size of the text
		 * @param toolTipWidth:Number maximum width the tooltip can be
		 * 
		 */
		public static function initTooltips(stage:Stage,bgColor:String = "#666666", textColor:String = "#ffffff", textSize:Number = 10,toolTipWidth:Number = 100):void
		{	
			_stage = stage;
			_displayDelay = 0;
			_font = new HelveticaRegular();
			_toolTipWidth = toolTipWidth;
			_bgColor = uint(DrawingUtils.fixColorCode(bgColor));
			_textColor = uint(DrawingUtils.fixColorCode(textColor));
			_textSize = textSize;
			
			_initialized = true;
			
			if(!_toolTipList)
			{
				_toolTipList = [];
			}
		}
		
		//changes the bg color of all toolTips
		/**
		 *setter for bgColor 
		 * @param color:String bg color as a string either #ffffff or 0xffffff
		 * 
		 */		
		public static function set bgColor(color:String):void
		{
			_bgColor = uint(DrawingUtils.fixColorCode(color));
			
			updateToolTips();
		}
		/**
		 * getter for bgColor
		 * @return String
		 * 
		 */		
		public static function get bgColor():String
		{
			return "#" + _bgColor.toString(16);
		}
		
		
		/**
		 * setter for text color 
		 * @param color:String text color can be either #ffffff or 0xffffff
		 * 
		 */		
		public static function set textColor(color:String):void
		{
			_textColor = uint(DrawingUtils.fixColorCode(color));
			
			updateToolTips();
		}
		
		/**
		 * getter for text color 
		 * @return:String
		 * 
		 */		
		public static function get textColor():String
		{
			return "#" + _textColor.toString(16);
		}
		
		/**
		 * setter for text size 
		 * @param size:Number 
		 * 
		 */		
		public static function set textSize(size:Number):void
		{
			_textSize = size;
			
			updateToolTips();
		}
		
		/**
		 * getter for text size 
		 * @return Number
		 * 
		 */		
		public static function get textSize():Number
		{
			return _textSize;
		}
		
		/**
		 * Setter for maximum toolTip width 
		 * @param size:Number
		 * 
		 */		
		public static function set toolTipWidth(size:Number):void
		{
			_toolTipWidth = size;
			
			updateToolTips();
		}
		
		/**
		 * getter for tool tip maximum width 
		 * @return Number
		 * 
		 */		
		public static function get toolTipWidth():Number
		{
			return _toolTipWidth;
		}
		
		/**
		 * setter for tooltip font defaults to helvetica:regular 
		 * @param font:Font must be a font datatype
		 * 
		 */		
		public static function set toolTipFont(font:Font):void
		{
			_font = font;
		}
		
		/**
		 * getter for tool tip font 
		 * @return Font
		 * 
		 */		
		public static function get toolTipFont():Font
		{
			return _font;
		}
		
		/**
		 * setter for the tooltip display delay 
		 * @param delay:Number delay in milliseconds
		 * 
		 */		
		public static function set toolTipDisplayDelay(delay:Number):void
		{
			_displayDelay = delay;
		}
		
		/**
		 * getter for tool tip display delay 
		 * @return Number in milliseconds
		 * 
		 */		
		public function get toolTipDisplayDelay():Number
		{
			return _displayDelay;
		}
		
		/**
		 * forces all tooltips currently instantiated to be redrawn
		 * 
		 */		
		public static function updateToolTips():void
		{
			for each(var TT:Base_componentToolTip in _toolTipList)
			{
				TT.drawToolTip();
			}
		}
	}
}