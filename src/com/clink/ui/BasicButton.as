package com.clink.ui
{
	import com.clink.base.Base_componentToolTip;
	import com.clink.controllers.Controller_button;
	import com.clink.events.BasicButtonEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.loaders.EasyImageLoader;
	import com.clink.loaders.loaderEvents.ImageComplete_Event;
	import com.clink.misc.Keys;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import org.osmf.layout.AbsoluteLayoutFacet;
	
	[Event (name="buttonDown", type="com.clink.events.BasicButtonEvent")]
	[Event (name="buttonUp", type="com.clink.events.BasicButtonEvent")]
	/**
	 * basic button class. This class produces buttonts according to colors set with a static function, this way all the buttons 
	 * will share a common color and be uniform throughout the application. colors, size, icons(from external source or a display object), 
	 * gradients, gradient contrast, and text labels can be set.
	 * 
	 * the toggle group connects the buttons in the array and will toggle them all up when one is pressed down. enableToggle needs to be set to true in order
	 * for the toggleGroup to work. Setting the enable toggle alone will just create a toggle button.
	 * 
	 * @author adamrensel
	 * 
	 */	
	public class BasicButton extends Base_componentToolTip
	{
		private var _buttonControl:Controller_button;
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		private var _upBtn:Sprite;
		private var _downBtn:Sprite;
		private var _overBtn:Sprite;
		private var _isRollOver:Boolean;
		private var _isDown:Boolean;
		
		private var _upIcon:DisplayObject;
		private var _downIcon:DisplayObject;
		private var _overIcon:DisplayObject;
		private var _keyCode:Number;
		private var _toggleGroup:Array;
		
		private static var _buttonList:Array;
		private static var _upColor:uint;
		private static var _downColor:uint;
		private static var _overColor:uint;
		private static var _cornerRadius:Number;
		private static var _isGradient:Boolean;
		private static var _gradientContrast:Number
		/**
		 * constructor for BasicButton, a width and height are required. Rollover mode can also be set. 
		 * @param width:Number width of the button
		 * @param height:Number height of the button
		 * @param isRollOver:Boolean setting this to true enables rollover mode.
		 * 
		 */		
		public function BasicButton(width:Number,height:Number,isRollOver:Boolean = false)
		{
			super();
			
			//check to make sure the basicButton class was intialized with BasicButton.init()
			if(!_buttonList)
			{
				throw new Error("Please initialize this class by calling BasicButton.init() at the beginning of your application");
			}
			_isRollOver = isRollOver;
			_btnWidth = width;
			_btnHeight = height;
			
			init();
		}
		
		private function init():void
		{		
			//create a new button controller
			_buttonControl = new Controller_button(new Sprite()); 
			this.addChild(_buttonControl);
			
			_isDown = false;
			redraw();
		}
		
		// this function takes the icons after they have been loaded and places them into the correct sprites, centers and resizes them if they are larger then the button
		private function setUpIcon(icon:DisplayObject,button:Sprite):void
		{
			if(icon)
			{
				button.addChild(icon);
				if(icon.width > _btnWidth)
				{
					icon.width = _btnWidth
				}
				
				if(icon.height > _btnHeight)
				{
					icon.height = _btnHeight
				}
				icon.x = _btnWidth/2 - icon.width/2;
				icon.y = _btnHeight/2 - icon.height/2;
			}
		}
		
		
		///////////////////Callbacks///////////////////
		
		//callback for the loader which loads the external icon images.
		private function onUpIconLoaded(e:com.clink.loaders.loaderEvents.ImageComplete_Event):void
		{
			_upIcon = null;
			_upIcon = e.imageLoaded;
			redraw();
		}
		
		private function onDownIconLoaded(e:com.clink.loaders.loaderEvents.ImageComplete_Event):void
		{
			_downIcon = null;
			_downIcon = e.imageLoaded;
			redraw();
		}
		
		private function onOverIconLoaded(e:com.clink.loaders.loaderEvents.ImageComplete_Event):void
		{
			_overIcon = null;
			_overIcon = e.imageLoaded;
			redraw();
		}
		
		//looks for the stage if a shortcutKey is specified
		private function lookforStage(e:Event):void
		{	
			if(this.stage)
			{
				this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
				this.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
				this.removeEventListener(Event.ENTER_FRAME,lookforStage);
			}
		}
		
		//shortcutKey calbacks
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == _keyCode)
			{
				
				_buttonControl.down();
				this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == _keyCode)
			{
				
				_buttonControl.up();
				this.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
			}
		}
		
		//mouse callback used if the toggle is enabled
		private function onMouseDown(e:MouseEvent):void
		{
			if(_toggleGroup && _toggleGroup.length > 0)
			{
				if(_buttonControl.State == "up" )
				{
					toggle();
				}
			}else{
				toggle();
			}
		}
		
		///////////////////Public Methods///////////////////
		/**
		 * enable toggle functionality in the button, this must be enabled if a toggle group is used. 
		 * 
		 */		
		public function enableToggle():void
		{
			this.addEventListener(MouseEvent.CLICK,onMouseDown);
			_buttonControl.disable();
		}
		/**
		 * disables toggle functionality 
		 * 
		 */		
		public function disableToggle():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_buttonControl.enable();
		}
		
		/**
		 * redraws the button, this shouldn't need to be called unless the class is extended. All methods which change the look/style
		 * automatically call this method. 
		 * 
		 */		
		public function redraw():void
		{
			//creates the upstate sprite
			_upBtn = null;
			_upBtn = Factory_prettyBox.drawPrettyBox(_btnWidth,_btnHeight,_upColor,_cornerRadius,_isGradient,false,false,_gradientContrast);
			
			//if there isnt a down color than generate a color similar to the dark color in the borders and use that to create the down state
			if(!_downColor)
			{
				_downColor = DrawingUtils.getBorderColors(_upColor,3)[2];
			}
			//create down button sprite
			_downBtn = null;
			_downBtn = Factory_prettyBox.drawPrettyBox(_btnWidth,_btnHeight,_downColor,_cornerRadius,_isGradient,true,true,_gradientContrast);
			
			_buttonControl.upState = _upBtn;
			_buttonControl.downState = _downBtn;
			
			//if there is a rollover active create an over state sprite
			if(_isRollOver)
			{
				// if there isnt a over state color set than generate one, this color is similar to the light color of the borders
				if(!_overColor)
				{
					_overColor = DrawingUtils.getBorderColors(_upColor,3)[1];
				}
				//create over button sprite
				_overBtn = null;
				_overBtn = Factory_prettyBox.drawPrettyBox(_btnWidth,_btnHeight,_overColor,_cornerRadius,_isGradient,false,false,_gradientContrast);
				_buttonControl.overState = _overBtn;
			}
			
			//call the setUpIcon method which resizes and centers the icons according to the button size
			setUpIcon(_upIcon,_upBtn);
			setUpIcon(_downIcon,_downBtn);
			setUpIcon(_overIcon,_overBtn);
			
			//if the button is set to down than make sure it looks like it's down, this preserves the state through multiple redraws
			if(_isDown)
			{
				_buttonControl.down();
			}
		}
		/**
		 * manually set the button state to down 
		 * 
		 */		
		public function down():void
		{
			_buttonControl.down();
			this.dispatchEvent(new BasicButtonEvent(BasicButtonEvent.BUTTON_DOWN));
			_isDown = true;
		}
		
		/**
		 * manually sets the button state to up 
		 * 
		 */		
		public function up():void
		{
			_buttonControl.up();
			this.dispatchEvent(new BasicButtonEvent(BasicButtonEvent.BUTTON_UP));
			_isDown = false;
		}
		
		/**
		 * toggles the button up or down, enableToggle must be called in order for this to work.
		 * 
		 */		
		public function toggle():void
		{
			
			if(_buttonControl.State == "up")
			{
				down();
			}else{
				up();
			}
			
			//if a toggle group exists than loop through the list, ignore this instance, but set the rest to up
			if(_toggleGroup && _toggleGroup.length > 0)
			{
				for each(var b:BasicButton in _toggleGroup)
				{
					if(b != this)
					{
						b.up();
					}
				}
			}
		}
		/**
		 * sets a toggle group, an array of basicButtons which are toggle up when one of their group is toggled down. 
		 * @param buttonGroup:Array This must be an array of BasicButtons or an error is thrown.
		 * 
		 */		
		public function setToggleGroup(buttonGroup:Array):void
		{
			for each(var b:Object in _toggleGroup)
			{
				//check to make sure all items are a basic button
				if(!(b is BasicButton))
				{
					throw new Error("All items in the button group must be instances of BasicButton");
				}
			}
			_toggleGroup = buttonGroup;
		}
		
		public function enable():void
		{
			_buttonControl.enable();
		}
		
		public function disable():void
		{
			_buttonControl.disable();
		}
		
		///////////////////Statics///////////////////
		
		/**
		 * static method which must be called at the beginning of the application, has options to set the button colors as well 
		 * @param upColor:String color of up state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * @param downColor:String color of down state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * @param overColor:String color of over state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * 
		 */		
		public static function init(upColor:String = "#aaaaaa", downColor:String = "", overColor:String = ""):void
		{
			
			setButtonColors(upColor,downColor,overColor);
			
			_cornerRadius = 0;
			_isGradient = false;
			_gradientContrast = 1;
			
			if(!_buttonList)
			{
				_buttonList = [];
			}
			
			redrawAll();
		}
		
		/**
		 * set the colors of all buttons 
		 * @param upColor:String color of up state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * @param downColor:String color of down state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * @param overColor:String color of over state, can be css style of color #FFFFFF or a AS3 hex color 0xFFFFFF
		 * 
		 */		
		
		public static function setButtonColors(upColor:String = "#aaaaaa", downColor:String = "", overColor:String = ""):void
		{
			//throw an error if the up state color is nothing
			if(upColor == "")
			{
				throw new Error("The attribute upColor cannot be an empty string");
			}
			//convert the string to a uint the class can use
			_upColor = uint(DrawingUtils.fixColorCode(upColor));
			
			if(downColor != "")
			{
				_downColor = uint(DrawingUtils.fixColorCode(downColor));
			}
			
			if(overColor != "")
			{
				_overColor = uint(DrawingUtils.fixColorCode(overColor));
			}
			
			redrawAll();
		}
		// redraws all instances of basic buttons after colors are changed
		private static function redrawAll():void
		{
			for each(var b:BasicButton in _buttonList)
			{
				b.redraw();
			}
		}
		/**
		 * Setter Static
		 * enables or disables gradient on all of the buttons 
		 * @param value:Boolean enables or disables button gradients
		 * 
		 */		
		public static function set isGradient(value:Boolean):void
		{
			_isGradient = value;
			redrawAll();
		}
		/**
		 * getter for if gradients are enabled  
		 * @return Boolean
		 * 
		 */		
		public static function get isGradient():Boolean
		{
			return _isGradient;
		}
		/**
		 * Setter
		 * sets the corner radius for all buttons
		 * @param radius:Number radius of corners for all buttons, any value greater than 0 will result in rounded corners
		 * 
		 */		
		public static function set cornerRadius(radius:Number):void
		{
			_cornerRadius = radius;
			redrawAll();
		}
		/**
		 * Getter
		 * returns value of corner radius 
		 * @return Number
		 * 
		 */		
		public static function get cornerRadius():Number
		{
			return _cornerRadius;
		}
		/**
		 * Setter
		 * Sets the gradient contrast for all buttons 
		 * @param contrast:Number contrast for all gradients
		 * 
		 */		
		public static function set gradientContrast(contrast:Number):void
		{
			_gradientContrast = contrast;
		}
		/**
		 * Getter
		 * getter for gradient contrast 
		 * @return Number
		 * 
		 */		
		public static function get gradientContrast():Number
		{
			return _gradientContrast;
		}
		
		
		///////////////////Getters/Setters///////////////////
		/**
		 * Setter
		 * overrides the orginal setter, set the width of the drawn button instead of the sprite as a whole. 
		 * @param value:Number width of drawn button
		 * 
		 */		
		override public function set width(value:Number):void
		{
			_btnWidth = value;
			redraw();
		}
		/**
		 * Setter
		 * overrides original setter, set the height of the drawn button instead of the sprite as a whole 
		 * @param value:Number height of drawn button
		 * 
		 */		
		override public function set height(value:Number):void
		{
			_btnHeight = value;
			redraw();
		}
		/**
		 * Setter
		 * Enables or disables rollover functionality 
		 * @param value:Boolean
		 * 
		 */		
		public function set isRollOver(value:Boolean):void
		{
			_isRollOver = value;
		}
		/**
		 * Getter
		 * returns if rollovers are enabled or not , true/false
		 * @return Boolean
		 * 
		 */		
		public function get isRollOver():Boolean
		{
			return _isRollOver;
		}
		/**
		 * Setter for the up state icon, either a displayObject or a string of the external image file path is accepted, anything else will throw an error
		 * @param displayObjectOrPath:DisplayObject/String DisplayObject of a string to the path of an external image
		 * 
		 */		
		public function set upIcon(displayObjectOrPath:*):void
		{
			//if the value is a String than load the external image, if its a display object than assign it to the correct button sprite
			if(displayObjectOrPath is String)
			{
				var elU:EasyImageLoader = new EasyImageLoader(displayObjectOrPath);
				elU.addEventListener(ImageComplete_Event.IMAGE_LOADED,onUpIconLoaded);
			}else if(displayObjectOrPath is DisplayObject){
				_upIcon = null;
				_upIcon = displayObjectOrPath;
			}else{
				throw new Error("The upIcon method requires a String path to external file or a displayObject for icon");
			}
		}
		/**
		 * getter for upstate icon 
		 * @return DisplayObject 
		 * 
		 */		
		public function get upIcon():DisplayObject
		{
			return _upIcon;
		}
		/**
		 * Setter for the down state icon, either a displayObject or a string of the external image file path is accepted, anything else will throw an error
		 * @param displayObjectOrPath:DisplayObject/String DisplayObject of a string to the path of an external image
		 * 
		 */		
		public function set downIcon(displayObjectOrPath:*):void
		{
			//if the value is a String than load the external image, if its a display object than assign it to the correct button sprite
			if(displayObjectOrPath is String)
			{
				var elD:EasyImageLoader = new EasyImageLoader(displayObjectOrPath);
				elD.addEventListener(ImageComplete_Event.IMAGE_LOADED,onDownIconLoaded);
			}else if(displayObjectOrPath is DisplayObject){
				_overIcon = null;
				_downIcon = displayObjectOrPath;
			}else{
				throw new Error("The downIcon method requires a String path to external file or a displayObject for icon");
			}
		}
		/**
		 * getter for down state icon 
		 * @return DisplayObject
		 * 
		 */		
		public function get downIcon():DisplayObject
		{
			return _downIcon;
		}
		/**
		 * Setter for the over state icon, either a displayObject or a string of the external image file path is accepted, anything else will throw an error
		 * @param displayObjectOrPath:DisplayObject/String DisplayObject of a string to the path of an external image
		 * 
		 */	
		public function set overIcon(displayObjectOrPath:*):void
		{
			//if the value is a String than load the external image, if its a display object than assign it to the correct button sprite
			if(displayObjectOrPath is String)
			{
				var elO:EasyImageLoader = new EasyImageLoader(displayObjectOrPath);
				elO.addEventListener(ImageComplete_Event.IMAGE_LOADED,onOverIconLoaded);
			}else if(displayObjectOrPath is DisplayObject){
				_overIcon = null;
				_overIcon = displayObjectOrPath;
			}else{
				throw new Error("The overIcon method requires a String path to external file or a displayObject for icon");
			}
		}
		/**
		 * getter for over state icon 
		 * @return DisplayObject
		 * 
		 */		
		public function get overIcon():DisplayObject
		{
			return _overIcon;
		}
		/**
		 * adds shortcut key functionality to the button if a keycode is passed in 
		 * @param keyCode:Number needs to be a keyboard keycode or nothing will happen
		 * 
		 */		
		public function set shortCutKey(keyCode:Number):void
		{
			//if the keycode doesnt exist remove the keyboard listeners. If there is a keycode than start an enterframe to look for the stage so keyboard listeners can be started
			if(keyCode)
			{
				_keyCode = keyCode;
				this.addEventListener(Event.ENTER_FRAME,lookforStage);
			}else{
				if(this.stage)
				{
					this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
					this.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
				}
			}
		}
		/**
		 * getter for keycode assigned to the shortcut key 
		 * @return Number
		 * 
		 */		
		public function get shortCutKey():Number
		{
			return _keyCode;
		}
		
		public function get state():String
		{
			return _buttonControl.State;
		}
	}
}