package com.clink.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * The LayoutBox class is a multipurpose tool used to laying out objects on the screen. The layout box is placed onto the stage
	 * and objects are added to it's displaylist using the addChild() method. When the LayoutBox is instantiated there are optional 
	 * parameters which can be set to determine if the objects will be positioned horizontally, vertically or on a grid. There are 
	 * also padding properties used for setting the space between objects. The colPadding option is used when grid mode is enabled.
	 * @example Here is an example of use:
	 * <listing version = 3.0>
	 * layoutBox = new LayoutBox(false,10,true,5,5);
	 *	layoutBox.x = 30;
	 *	layoutBox.y = 30;
	 *	addChild(layoutBox);
	 *	
	 *	var btn:ButtonBase = new ButtonBase();
	 *	btn.label = "up";
	 * btn.addEventListener(MouseEvent.CLICK, btnOnClick_Handler);
	 *	layoutBox.addChild(btn);
	 *	
	 *	var btn2:ButtonBase = new ButtonBase();
	 *	btn2.label = "down";
	 * 	btn2.addEventListener(MouseEvent.CLICK, btnOnClick_Handler);
	 *	layoutBox.addChild(btn2);
	 *		
	 *	for(var i:Number = 0; i < 13 ; i++)
	 *	{
	 *		var bt:ButtonBase = new ButtonBase
	 *		bt.label = "btn " + i;
	 *		layoutBox.addChild(bt);
	 * 	}
	 * </listing>
	 * 
	 * 
	 */
	public class LayoutBox extends Sprite
	{
		private var _objects:Array = [];
		private var _padding:Number;
		private var _rowPadding:Number;
		private var _vertical:Boolean;
		private var _gridLayout:Boolean;
		private var _numCols:int;
		
		public function LayoutBox(vertical:Boolean = true,padding:Number = 3,gridLayout:Boolean = false,numCols:int = 3,rowPadding:Number = 20)
		{
			super();
			_vertical = vertical;
			_padding = padding;
			_rowPadding = rowPadding;
			_gridLayout = gridLayout;
			_numCols = numCols;
		}
		/**
		 * Adds a display object to the Layout Box. 
		 * @param child
		 * @return 
		 * 
		 */		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_objects.push(child);
			super.addChild(child);
			
			if(_gridLayout)
			{
				grid();
			}else{
				updateLayout();
			}
			
			return child;
		}
		/**
		 * Removes a display object from the Layout Box 
		 * @param child
		 * @return 
		 * 
		 */		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			_objects.splice(_objects.indexOf(child),1);
			updateLayout();
			super.removeChild(child);
			
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			_objects.splice(index,1);
			updateLayout();
			
			super.removeChildAt(index);
			return new Sprite;
			
			
		}
		
		private function updateLayout():void
		{
			var counter:Number = 0;
			for each(var obj:DisplayObject in _objects)
			{
				if(_vertical)
				{
					if(counter == 0)
					{
						obj.y = counter * (obj.height + _padding);
					}else{
						obj.y = counter * (_objects[counter - 1].height + _padding);
					}
					
				}else{
					if(counter == 0)
					{
						obj.x = counter * (obj.width + _padding);
					}else{
						obj.x = counter * (_objects[counter - 1].width + _padding);
					}
				}
				counter++;
			}
		}
		
		private function grid():void
		{
			//trace(_objects.length);
			
			var newRow:int = 0;
			var resetRow:int = 0;
			
			for(var i:int = 0; i < _objects.length; i++)
			{
				_objects[i].x =  (i - resetRow) * (_objects[i].width + _padding);
				_objects[i].y = (_objects[i].height + _rowPadding) * newRow;
				
				if(_objects[i].x + _objects[i].width  > _objects[i].width * _numCols)
				{
					resetRow = i + 1;
					newRow ++
				}
			}
		}
		
		/* ----------------------GETTERS/SETTERS ---------------------*/
		/**
		 *@private 
		 * @param value
		 * 
		 */
		public function set vertical(value:Boolean):void
		{
			_vertical = value;
		}
		/**
		 * A Boolean value used to set the layout to vertical or horizontal. This value is ignored if grid mode is set to true. 
		 * @return 
		 * 
		 */		
		public function get vertical():Boolean
		{
			return _vertical;
		}
		/**
		 *@private 
		 * @param value
		 * 
		 */		
		public function set padding(value:Number):void
		{
			_padding = value;
		}
		/**
		 * A number value which controls horizontal spacing between objects when vertical = false, and vertical spacing when vertical = true. 
		 * This property controls spacing within a row when gridLayout = true. 
		 * @return 
		 * 
		 */		
		public function get padding():Number
		{
			return _padding;
		}
		/**
		 *@private 
		 * @param value
		 * 
		 */		
		public function set gridLayout(value:Boolean):void
		{
			_gridLayout = value;
		}
		/**
		 * A Boolean value which controls whether the layout box displays objects on a grid. The grid is generated in a left to right, top down manner.
		 * When gridLayout = true, the vertical property is ignored. 
		 * @return 
		 * 
		 */		
		public function get gridLayout():Boolean
		{
			return _gridLayout;
		}
		/**
		 *@private 
		 * @param value
		 * 
		 */		
		public function set numCols(value:int):void
		{
			_numCols = value;
		}
		/**
		 * A Integer value (whole number) which determines how many columns are generated when gridLayout = true. 
		 * This property is ignored when gridLayout = false.
		 * @return 
		 * 
		 */		
		public function get numCols():int
		{
			return _numCols;
		}
		/**
		 *@private 
		 * @param value
		 * 
		 */		
		public function set rowPadding(value:Number):void
		{
			_rowPadding = value;
		}
		/**
		 * A Number which controls vertical spacing when gridLayout = true. This property is ignored when gridLayout = false. 
		 * @return 
		 * 
		 */		
		public function get rowPadding():Number
		{
			return _rowPadding;
		}
		
		public function set items(items:Array):void
		{
			_objects = items;
			updateLayout();
		}
		public function get items():Array
		{
			return _objects;
		}
	}
}