package com.clink.ui
{
	import com.clink.factories.Factory_prettyBox;
	import com.clink.misc.Keys;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	/**
	 * Creates a scrolling Box of a specified height and width with the specified background color(if any) 
	 * must initialize scrollBars with ScrollBar.initScrollBars(). This has to have been called once before using
	 * @author adamrensel
	 * 
	 */	
	public class ScrollBox extends Sprite
	{
		private var _sbv:ScrollBar;
		private var _sbh:ScrollBar;
		private var _container:Sprite;
		private var _mask:Sprite;
		private var _bg:Sprite;
		
		private var _boxHeight:Number;
		private var _boxWidth:Number;
		private var _bgColor:uint;
		
		/**
		 * Creates the scrolling Box with given height and width and optional background color 
		 * @param width:Number scrollList width
		 * @param height:Number scrollList Height
		 * @param bgColor:String background color can be passed in as a css value ex. #FFFFFF or as an actionscript hex value 0xFFFFFF, either will work
		 * 
		 */		
		public function ScrollBox(width:Number,height:Number,bgColor:String = null)
		{
			super();
			
			_boxWidth = width;
			_boxHeight = height;
			
			if(bgColor)
			{
				_bgColor = uint(DrawingUtils.fixColorCode(bgColor));
			}
			
			
			init();
		}
		
		private function init():void
		{
			
			//create the bg if a color is given
			if(_bgColor)
			{
				_bg = Factory_prettyBox.drawPrettyBox(_boxWidth,_boxHeight,_bgColor,0,false,false,true);
				this.addChild(_bg);
			}
			
			//new layoutBox
			_container = new Sprite();
			this.addChild(_container);
			
			//create and set mask
			_mask = new Sprite();
			_mask.graphics.beginFill(0xffffff,0);
			_mask.graphics.drawRect(0,0,_boxWidth,_boxHeight);
			_mask.graphics.endFill();
			this.addChild(_mask);
			_container.mask = _mask;
			
			//create Vertical scrollbar
			_sbv = new ScrollBar(_boxHeight,true);
			_sbv.length = _boxHeight - _sbv.width;
			_sbv.x = _boxWidth - _sbv.width + 1;
			_sbv.y = 0;
			_sbv.handleSize = 1;
			
			_sbv.addEventListener(Event.CHANGE,onVerticalSbChange);
			
			//create Horizontal scrollbar
			_sbh = new ScrollBar(_boxWidth,false);
			_sbh.length = _boxWidth-_sbh.height
			_sbh.x = 0;
			_sbh.y = _boxHeight - _sbh.height + 1;
			_sbh.handleSize = 1;
			
			_sbh.addEventListener(Event.CHANGE,onHorizontalSbChange);
			
			//adds mouse wheel functionality
			this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheel);
			updateHandleSize();
		}
		
		//updates the handle size and adds/removes the scrollBar if the list is big enough to need to scroll
		private function updateHandleSize():void
		{
			//vertical scrollbar handle resize
			var heightPercent:Number = _boxHeight/_container.height;
			if(heightPercent > 1)
			{
				if(_sbv.parent == this)
				{
					this.removeChild(_sbv);
				}
				
				_sbv.handleSize = 1;	
			}else{
				
				if(_sbv.parent != this)
				{
					this.addChild(_sbv);
				}
				
				if(heightPercent > .15)
				{
					_sbv.handleSize = heightPercent;
				}else{
					_sbv.handleSize = .15;
				}
			}
			
			//horizontal scrollbar handle size
			var widthPercent:Number = _boxWidth/_container.width;
			if(widthPercent > 1)
			{
				if(_sbh.parent == this)
				{
					this.removeChild(_sbh);
				}
				
				_sbh.handleSize = 1;	
			}else{
				
				if(_sbh.parent != this)
				{
					this.addChild(_sbh);
				}
				
				if(widthPercent > .15)
				{
					_sbh.handleSize = widthPercent;
				}else{
					_sbh.handleSize = .15;
				}
			}
		}
		
		
		/////////////callbacks///////////////
		
		
		//mouse wheel scrolling
		private function onMouseWheel(e:MouseEvent):void
		{
			//if the shift key is held down scroll side to side
			if(Keys.keys[16])
			{//horizontal scroll
				
				if(_sbh.value + (-e.delta / 50) < 0)
				{
					_sbh.value = 0;
					
				}else if(_sbh.value + (-e.delta / 50) > 1){
					_sbh.value = 1;
				}else{
					_sbh.value += -e.delta / 50;
				}
			}else{//vertical scroll
				if(_sbv.value + (-e.delta / 50) < 0)
				{
					_sbv.value = 0;
					
				}else if(_sbv.value + (-e.delta / 50) > 1){
					
					_sbv.value = 1;
				}else{
					_sbv.value += -e.delta / 50;
				}
			}
			
		}
		
		//when the vertical scroll bar scrolls
		private function onVerticalSbChange(e:Event):void
		{
			if(_sbv.parent == this)
			{
				_container.y = -Math.round((_container.height - _boxHeight) * _sbv.value);
			}else{
				_container.y = 0;
			}
			
		}
		
		//when the horizontal scroll bar scrolls
		private function onHorizontalSbChange(e:Event):void
		{
			if(_sbv.parent == this)
			{
				_container.x = -Math.round((_container.width - _boxWidth) * _sbh.value);
			}else{
				_container.x = 0;
			}
			
		}
		
		////////////public methods///////////
		/**
		 * Updates the scroll list, will need to be called if a list item has changed size, for example if the item is a textField and something
		 * new has been typed in. 
		 * 
		 */		
		public function update():void
		{
			updateHandleSize();
		}
		
		/**
		 * Adds a displayObject to the scrolling list 
		 * @param item:DisplayObject object to add to the list
		 * 
		 */		
		public function addItem(item:DisplayObject):void
		{
			_container.addChild(item);
			
			updateHandleSize();
		}
		
		/**
		 * Removes an item from the scrolling list 
		 * @param itemIndex:int removes an item from the list at a certain index
		 * 
		 */		
		public function removeItem(itemIndex:int):void
		{
			_container.removeChildAt(itemIndex);
			
			updateHandleSize();
			
		}
		
		/**
		 * setter for vertical scrollBar value
		 * @param value
		 * 
		 */		
		public function set yValue(value:Number):void
		{
			_sbv.value = value;
		}
		/**
		 * getter for vertical scrollBar value 
		 * @return 
		 * 
		 */		
		public function get yValue():Number
		{
			return _sbv.value;
		}
		/**
		 * setter for horizontal scrollBar value 
		 * @param value
		 * 
		 */		
		public function set xValue(value:Number):void
		{
			_sbh.value = value;
		}
		/**
		 * getter for horizontal scrollBar value 
		 * @return 
		 * 
		 */		
		public function get xValue():Number
		{
			return _sbh.value;
		}
		////////////static methods////////////
		
	}
}