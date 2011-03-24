package com.critique.ui
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.main.ClinkMain;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.SortingScrollList;
	import com.clink.valueObjects.VO_ModuleApi;
	import com.critique.controllers.MultiButton;
	
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import lib.TopNav;
	
	public class TopBar extends TopNav
	{
		private var _userValuesSO:Manager_remoteUserSharedObject;
		private var _layerListSO:Manager_remoteCommonSharedObject;
		private var _moduleApi:VO_ModuleApi;
		
		private var _strokeList:SortingScrollList;
		private var _fontList:SortingScrollList;
		private var _layerList:SortingScrollList;
		
		override public function TopBar(userValuesSO:Manager_remoteUserSharedObject,layerListSO:Manager_remoteCommonSharedObject, moduleApi:VO_ModuleApi)
		{
			super();
			
			_userValuesSO = userValuesSO;
			_layerListSO = layerListSO;
			_moduleApi = moduleApi;
			
			init();
		}
		
		private function init():void
		{
			//addLayer Button 
			var btnAddLayerController:MultiButton = new MultiButton(this.btn_addLayer,true);
			this.btn_addLayer.addEventListener(MouseEvent.CLICK,onAddLayerClick);
			
			//font dropdown
			var fontSizeUpController:MultiButton = new MultiButton(this.dropdown_font.btn_up,true);
			var fontSizeDownController:MultiButton = new MultiButton(this.dropdown_font.btn_down,true);
			this.dropdown_font.btn_up.addEventListener(MouseEvent.CLICK,onUpClick);
			this.dropdown_font.btn_down.addEventListener(MouseEvent.CLICK,onDownClick);

			this.dropdown_font.btn_content.mouseChildren = false;
			this.dropdown_font.btn_content.buttonMode = true;
			this.dropdown_font.btn_content.tf_value.text = "1 pt";
			this.dropdown_font.btn_content.addEventListener(MouseEvent.CLICK,onFontClick);
			
			//stroke dropdown
			var strokeSizeUpController:MultiButton = new MultiButton(this.dropdown_stroke.btn_up,true);
			var strokeSizeDownController:MultiButton = new MultiButton(this.dropdown_stroke.btn_down,true);
			this.dropdown_stroke.btn_up.addEventListener(MouseEvent.CLICK,onUpClick);
			this.dropdown_stroke.btn_down.addEventListener(MouseEvent.CLICK,onDownClick);
			
			this.dropdown_stroke.btn_content.mouseChildren = false;
			this.dropdown_stroke.btn_content.buttonMode = true;
			this.dropdown_stroke.btn_content.addEventListener(MouseEvent.CLICK,onStrokeClick);
			this.dropdown_stroke.btn_content.tf_value.text = "1 px";
			
			//layer dropdown
			this.dropdown_chooseLayer.mouseChildren = false;
			this.dropdown_chooseLayer.buttonMode = true;
			this.dropdown_chooseLayer.addEventListener(MouseEvent.CLICK,onLayerClick);
			
			//scrolling lists
			//stroke list
			_strokeList = new SortingScrollList(this.dropdown_stroke.width,180,"#ffffff");
			_strokeList.x = this.dropdown_stroke.x;
			_strokeList.y = this.dropdown_stroke.y;
			_strokeList.addEventListener(MouseEvent.ROLL_OUT,onListOut);
			//font list
			_fontList = new SortingScrollList(this.dropdown_font.width,180,"#ffffff");
			_fontList.x = this.dropdown_font.x;
			_fontList.y = this.dropdown_font.y;
			_fontList.addEventListener(MouseEvent.ROLL_OUT,onListOut);
			//layer list
			_layerList = new SortingScrollList(this.dropdown_chooseLayer.width,180, "#ffffff"); 
			_layerList.x = this.dropdown_chooseLayer.x;
			_layerList.y = this.dropdown_chooseLayer.y;
			_layerList.addEventListener(MouseEvent.ROLL_OUT,onListOut);
			this.dropdown_chooseLayer.tf_content.text = "default";
			//text field
			this.tf_newLayer.addEventListener(FocusEvent.FOCUS_IN,onTfFocusIn);
			
			populateLists();
			//sharedObjects
			_layerListSO.addEventListener(SharedObjectEvent.CHANGED,onLayerListChange);
			_layerListSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onLayerListChange);
			_layerListSO.addEventListener(SharedObjectEvent.DELETED,onLayerListDelete);
			
			//delete button
			//if the user is a student, hide the layer delete button
			if(_moduleApi.userPermission == ClinkMain.STUDENT_PERMISSION)
			{
				this.btn_deleteLayer.visible = false;
			}else{
				this.btn_deleteLayer.buttonMode = true;
				this.btn_deleteLayer.addEventListener(MouseEvent.CLICK,onDeleteClick);
			}
			
		}
		
		//builds list items for all the drop downs.
		private function buildListItem(text:String,width:Number = 200):Sprite
		{
			var li:Sprite = Factory_prettyBox.drawPrettyBox(width,19,0xeeeeee);
			li.mouseChildren = false;
			li.buttonMode = true;
			li.addEventListener(MouseEvent.CLICK,onListItemClick);
			li.addEventListener(MouseEvent.ROLL_OVER,onListItemOver);
			li.addEventListener(MouseEvent.ROLL_OUT,onListItemOut);
			var tf:TextField = new TextField();
			tf.width = width;
			tf.height = 15;
			tf.y = 2;
			var f:Font = new HelveticaRegular();
			tf.defaultTextFormat = new TextFormat(f.fontName,10,0x555555,null,null,null,null,TextFormatAlign.LEFT);
			tf.text = text;
			li.addChild(tf);
			
			return li;
		}
		
		//populate the stroke and font size lists with values to choose from
		private function populateLists():void
		{
			for(var f:int = 1; f < 60; f++)
			{
				_fontList.addListItem(buildListItem(f.toString()+" pt"),f.toString(),Array.NUMERIC);	
			}
			
			for(var s:int = 1; s < 16; s++)
			{
				_strokeList.addListItem(buildListItem(s.toString()+" px"),s.toString(),Array.NUMERIC);	
			}

		}
		
		//update the layer list dropdown
		private function updateLayerList():void
		{	
			var lList:Object = _layerListSO.sharedObject.data;
			
			//test for if the layers in the sharedObject are contained in the list, if one is missing than make a new list item and add it to the list
			var doesExist:Boolean = false;
			for(var l:String in lList)
			{
				doesExist = false;
				for (var obj:String in _layerList.items)
				{					
					if(_layerList.items[obj].label == lList[l])
					{
						doesExist = true;
					}
				}
				if(!doesExist && lList[l].length > 0)
				{
					_layerList.addListItem(buildListItem(lList[l]),lList[l]);
				}
				
			}
			
			//test the list to make sure it matches the sharedObject, if one is missing than delete it from the list (when a layer is deleted)
			var exists:Boolean;
			for (var obj2:String in _layerList.items)
			{
				exists = false;
				for(var l2:String in lList)
				{
					if(lList[l2] == _layerList.items[obj2].label)
					{
						exists = true
					}
				}
				
				if(!exists)
				{
					_layerList.removeListItem(_layerList.items[obj2].item,_layerList.items[obj2].label);
					this.dropdown_chooseLayer.tf_content.text = _layerList.items[0].label;
				}
			}
			
			//adjust the height of the dropdown if too few items are in it
			var height:Number = _layerList.items.length * 20;
			if(height > 150)
			{
				height = 150;
			}
			
			_layerList.height = height;
		}
		
		//////////////////////Callbacks///////////////////////
		
		//delete layer button is clicked
		private function onDeleteClick(e:MouseEvent):void
		{
			var data:Object = _layerListSO.sharedObject.data;
			
			//find the index of the value to be deleted
			for(var s:String in data)
			{
				if(data[s] == this.dropdown_chooseLayer.tf_content.text)
				{
					_layerListSO.deleteProperty(s);
				}
			}
		}
		
		//on layer add text field focus, reset the text to blank
		private function onTfFocusIn(e:FocusEvent):void
		{
			this.tf_newLayer.text = "";
		}
		
		//add layer button is clicked
		private function onAddLayerClick(e:MouseEvent):void
		{
			//figure out what the layer index would be, based on the other layers sequentially
			if(this.tf_newLayer.text.length > 0)
			{
				var length:Number = 0;
				 
				for(var l:String in _layerListSO.sharedObject.data)
				{
					length ++;
				}
				length ++;
				_layerListSO.addProperty(length.toString(),this.tf_newLayer.text);
				this.tf_newLayer.text = "new layer";
			}
		}
		
		//when the list of layers in the sharedObject changes than run the update layer list function
		private function onLayerListChange(e:SharedObjectEvent):void
		{
			updateLayerList();
		}
		
		private function onLayerListDelete(e:SharedObjectEvent):void
		{
			updateLayerList();
		}
		
		//when the up button on the stroke and font size drop downs are pressed
		private function onUpClick(e:MouseEvent):void
		{
			var value:Number = e.currentTarget.parent.btn_content.tf_value.text.split(" ")[0];
			
			//if the list item's parent is the font drop down than do one thing, if not than it has to be the stroke so do the other
			if(e.currentTarget.parent.name == this.dropdown_font.name)
			{
				if(value != 59)
				{
					value = value + 1;
				}
				
				this.dropdown_font.btn_content.tf_value.text = value.toString() + " pt";
				_userValuesSO.setProperty("fontSize", value);
			}else{
				if(value != 15)
				{
					value  = value + 1;
				}
				
				this.dropdown_stroke.btn_content.tf_value.text = value.toString() + " px";
				_userValuesSO.setProperty("strokeSize",value);
			}
		}
		
		//when the up button on the stroke and font size drop downs are pressed
		private function onDownClick(e:MouseEvent):void
		{
			var value:Number = e.currentTarget.parent.btn_content.tf_value.text.split(" ")[0];
			
			//if the list item's parent is the font drop down than do one thing, if not than it has to be the stroke so do the other
			if(e.currentTarget.parent.name == this.dropdown_font.name)
			{
				if(value != 1)
				{
					value = value - 1;
				}
				
				this.dropdown_font.btn_content.tf_value.text = value.toString() + " pt";
				_userValuesSO.setProperty("fontSize", value);
			}else{
				if(value != 1)
				{
					value  = value - 1;
				}
				
				this.dropdown_stroke.btn_content.tf_value.text = value.toString() + " px";
				_userValuesSO.setProperty("strokeSize",value);
			}
		}
		
		//adds the stroke dropdown when the button is pressed
		private function onStrokeClick(e:MouseEvent):void
		{
			this.addChild(_strokeList);
		}
		
		//adds the font dropdown when the button is pressed
		private function onFontClick(e:MouseEvent):void
		{
			this.addChild(_fontList);
		}
		
		//adds the layer dropdown when the button is pressed
		private function onLayerClick(e:MouseEvent):void
		{
			this.addChild(_layerList);
		}
		
		//when the mouse leaves a list than remove that list
		private function onListOut(e:MouseEvent):void
		{
			if(e.currentTarget.parent == this)
			{
				this.removeChild(e.currentTarget as Sprite);
			}
		}
		
		//rollover effect for list items
		private function onListItemOut(e:MouseEvent):void
		{
			e.target.alpha = 1;
		}
		
		private function onListItemOver(e:MouseEvent):void
		{
			e.target.alpha = .8;
		}
		
		//when  list item is clicked look at which drop down is active and target that parent.
		private function onListItemClick(e:MouseEvent):void 
		{	
			var value:Number;

			if(_fontList.parent == this)
			{
				value = e.currentTarget.getChildAt(0).text.split(" ")[0]; 
				this.dropdown_font.btn_content.tf_value.text = value.toString() + " pt";
				this.removeChild(_fontList);
				_userValuesSO.setProperty("fontSize",value);
			}
			
			if(_strokeList.parent == this)
			{
				value = e.currentTarget.getChildAt(0).text.split(" ")[0]; 
				
				this.dropdown_stroke.btn_content.tf_value.text = value.toString() + " px";
				this.removeChild(_strokeList);
				_userValuesSO.setProperty("strokeSize",value);
			}
			
			if(_layerList.parent == this)
			{
				this.dropdown_chooseLayer.tf_content.text = e.currentTarget.getChildAt(0).text;
				this.removeChild(_layerList);
				_userValuesSO.setProperty("layer",e.currentTarget.getChildAt(0).text);
			}
		}
	}
}