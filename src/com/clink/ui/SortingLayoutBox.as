package com.clink.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * The LayoutBox class is a multipurpose tool used to laying out objects on the screen. The layout box is placed onto the stage
	 * and objects are added to it's displaylist using the addChild() method. When the LayoutBox is instantiated there are optional 
	 * parameters which can be set to determine if the objects will be positioned horizontally, vertically or on a grid. There are 
	 * also padding properties used for setting the space between objects. The colPadding option is used when grid mode is enabled.
	 * 
	 * ***Modified layout box to add sorting capabilities******
	 * 
	 */
	public class SortingLayoutBox extends Sprite
	{
		private var _items:Array = [];
		private var _padding:Number;
		private var _rowPadding:Number;
		private var _vertical:Boolean;
		private var _gridLayout:Boolean;
		private var _numCols:int;
		
		public function SortingLayoutBox(vertical:Boolean = true,padding:Number = 3,gridLayout:Boolean = false,numCols:int = 3,rowPadding:Number = 20)
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
		 * @param item display object that is in the list
		 * @param sortByLabel unique label used to sort the items by
		 * @param araySortSetting uint constant from the Array class that sets different sorting options
		 * @return 
		 * 
		 */		
		public function addItem(item:DisplayObject,sortByLabel:String, arraySortSetting:uint = -1):void
		{
			var itemObj:Object;
			
			if(arraySortSetting == Array.NUMERIC)
			{
				itemObj = {item:item, label:Number(sortByLabel)}
			}else{
				itemObj = {item:item, label:sortByLabel}
			}
		    
			_items.push(itemObj);
			
			if(arraySortSetting != -1)
			{
				_items.sortOn("label",[arraySortSetting]);
			}else{
				_items.sortOn("label");
			}
		
			
			this.addChild(item);
			
			if(_gridLayout)
			{
				grid();
			}else{
				updateLayout();
			}
		}

		/**
		 * Removes a display object from the Layout Box 
		 * @param child
		 * @return 
		 * 
		 */		
		public function removeItem(item:DisplayObject,sortByLabel:String):void
		{
			
			for(var i:int = 0; i < _items.length; i++)
			{
				if(_items[i]["label"] == sortByLabel)
				{
					this.removeChild(_items[i]["item"]);
					_items.splice(i,1);
				}
			}
			
			
			if(_gridLayout)
			{
				grid();
			}else{
				updateLayout();
			}
			
		}
		
		public function updateLayout():void
		{
			var totalDist:Number = 0;
			
			for(var i:int = 0; i < _items.length; i++)
			{
				if(_vertical)
				{
					_items[i]["item"].y = (totalDist + _padding);
					totalDist += _items[i]["item"].height;
				}else{
					
					_items[i]["item"].x = (totalDist + _padding);
					totalDist += _items[i]["item"].width;
				}
			}
		}
		
		private function grid():void
		{	
			var newRow:int = 0;
			var resetRow:int = 0;
			
			for(var i:int = 0; i < _items.length; i++)
			{
				_items[i]["item"].x =  (i - resetRow) * (_items[i]["item"].width + _padding);
				_items[i]["item"].y = (_items[i]["item"].height + _rowPadding) * newRow;
				
				if(_items[i]["item"].x + _items[i]["item"].width  > _items[i]["item"].width * _numCols)
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
		
		/**
		 * must be an array of objects formatted as such: {item:displayObject goes here, label:"sorting label goes here"}
		 * 
		 */
		public function set items(items:Array):void
		{
			_items = items;
			updateLayout();
		}
		public function get items():Array
		{
			return _items;
		}
	}
}