package com.critique.ui
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.ui.Slider;
	import com.clink.utils.ArrayUtils;
	import com.clink.utils.Convert;
	import com.clink.utils.DrawingUtils;
	import com.critique.controllers.MultiButton;
	import com.critique.events.ColorPickerEvent;
	
	import fl.motion.Color;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import lib.colorPicker;
	
	[Event(name="colorChosen", type="com.critique.events.ColorPickerEvent")]
	
	public class ColorPickerModal extends colorPicker
	{	
		private var _finalColor:uint;
		private var _subColor:uint;
		private var _mainBmd:BitmapData;
		private var _subBmd:BitmapData;
		
		private var _grad1:Sprite;
		private var _grad2:Sprite;
		private var _gradContainer:Sprite;
		
		private var _tfHasFocus:Boolean;
		
		public function ColorPickerModal()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			//set defaults
			_tfHasFocus = false;
			
			_finalColor = 0xffffff;
			_subColor = 0xffffff;
			
			//create double layered gradient for the main color chooser
			_grad1 = new Sprite();
			_grad2 = new Sprite();
			_gradContainer = new Sprite();
			//position the main gradient container
			_gradContainer.x = 17;
			_gradContainer.y = 16;
			
			_gradContainer.addChild(_grad1);
			_gradContainer.addChild(_grad2);
			this.addChild(_gradContainer);
			
			//create the gradient on the black to transparent overlay
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(229,208,Convert.degreesToRadians(90),0,0);
			_grad2.graphics.beginGradientFill(GradientType.LINEAR,[0x000000,0x000000],[0,1],[10,245],matrix);
			_grad2.graphics.drawRect(0,0,229,208);
			_grad2.graphics.endFill();
			
			//set up the button controllers
			var chooseController:MultiButton = new MultiButton(this.btn_choose,true);
			this.btn_choose.addEventListener(MouseEvent.CLICK, chooseColor);
			
			var cancelController:MultiButton = new MultiButton(this.btn_cancel,true);
			this.btn_cancel.addEventListener(MouseEvent.CLICK,cancelPicker);
			
			//set up the color rainbow slider
			setupColorSlider();
			
			drawLargeColorPicker(0xffffff);
			
			this.mc_colorPickerPointer.mouseEnabled = false;
			this.setChildIndex(this.mc_colorPickerPointer,this.numChildren-1);
			
			//create the initial bitmap data for the main color picker container
			_subBmd = new BitmapData(_gradContainer.width,_gradContainer.height);
			_gradContainer.addEventListener(MouseEvent.CLICK,onMainColorClick);
			
			//listeners for typing in color codes
			this.tf_colorCode.addEventListener(Event.CHANGE,onTfChange);
			this.tf_colorCode.addEventListener(FocusEvent.FOCUS_IN, tfFocusIn);
			this.tf_colorCode.addEventListener(FocusEvent.FOCUS_OUT, tfFocusOut);
			
			//make the whole thing dragable
			var dragger:Controller_Dragable = new Controller_Dragable(this,this.bg);
		}
		
		//this sets up the rainbow color slider
		private function setupColorSlider():void
		{ 
			this.colorPickerHandle.mouseEnabled = false;
			_mainBmd = new BitmapData(this.colorPickerTrack.width,this.colorPickerTrack.height);
			_mainBmd.draw(this.colorPickerTrack); 
			
			this.colorPickerTrack.addEventListener(MouseEvent.CLICK, onRainbowClick);
			
			this.colorPickerHandle.y = this.colorPickerTrack.y+1;
			this.mc_colorPickerPointer.x = _gradContainer.x + 2;
			this.mc_colorPickerPointer.y = _gradContainer.y + 2;
		}
		
		//this redraws the main color picker everytime a color is chosen from the rainbow slider
		private function drawLargeColorPicker(color:uint):void
		{
			_grad1.graphics.clear();

			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(229,208,Convert.degreesToRadians(0),0,0);
			_grad1.graphics.beginGradientFill(GradientType.LINEAR,[0xffffff,color],[1,1],[10,227],matrix);
			_grad1.graphics.drawRect(0,0,229,208);
			_grad1.graphics.endFill();
		}
		
		//this sets the color preview box, and makes sure the text is output correctly
		private function setFinalColor(color:uint, noText:Boolean = false):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			
			(this.finalColor.final as Sprite).transform.colorTransform = ct;
			
			_finalColor = ct.color;
			
			if(!noText)
			{
				var red:String = ct.redOffset.toString(16);
				var green:String = ct.greenOffset.toString(16);
				var blue:String = ct.blueOffset.toString(16);
				//when converting from hex to a string sometimes zeros are left out, this just adds them back in so we always get a 6 digit color code
				if(red.length == 1)
				{
					red = "0" + red;
				}
				
				if(green.length == 1)
				{
					green = "0" + green;
				}
				
				if(blue.length == 1)
				{
					blue = "0" + blue;
				}
				
				this.tf_colorCode.text = red + green + blue;
			}
		}
		
		//gets the color from the main color picker
		private function getMainColor(x:Number,y:Number):void
		{
			_subBmd.draw(_gradContainer);
			
			setFinalColor(_subBmd.getPixel(x,y))
		}
		
		/////////////////////callbacks///////////////////////
		
		//when a user types into the text box we want to set the color preview
		private function onTfChange(e:Event):void
		{
			if(_tfHasFocus)
			{
				setFinalColor(uint("0x" + this.tf_colorCode.text),true);
			}
		}
		
		//sets focus
		private function tfFocusIn(e:FocusEvent):void
		{
			_tfHasFocus = true;
		}
		//sets focus
		private function tfFocusOut(e:FocusEvent):void
		{
			_tfHasFocus = false;
		}
		
		//when the main color picker is clicked, position the pointer send the color
		private function onMainColorClick(e:MouseEvent):void
		{
			getMainColor((e.target as Sprite).mouseX,(e.target as Sprite).mouseY);
			this.mc_colorPickerPointer.x = this.mouseX;
			this.mc_colorPickerPointer.y = this.mouseY;
		}
		
		//after the rainbow slider is clicked, position the pointer and redraw the main color picker
		private function onRainbowClick(e:MouseEvent):void
		{
			this.colorPickerHandle.y = this.mouseY;
			
			drawLargeColorPicker(_mainBmd.getPixel((e.target as Sprite).mouseX,(e.target as Sprite).mouseY));
			
			getMainColor(this.mc_colorPickerPointer.x - _gradContainer.x,this.mc_colorPickerPointer.y - _gradContainer.y);
		}
		
		//when the choose button is clicked dispatch an event with the color attached
		private function chooseColor(e:MouseEvent):void
		{
			var evt:ColorPickerEvent = new ColorPickerEvent(ColorPickerEvent.COLOR_CHOSEN);
			evt.color = _finalColor;
			this.dispatchEvent(evt);
			
			this.parent.removeChild(this);
		}
		
		//cancel button is clicked
		private function cancelPicker(e:MouseEvent):void
		{
			this.parent.removeChild(this);
		}
		
		/////////////////////public methods///////////////////
		
		
		////////////////////////getters/setters///////////////
		public function get color():uint
		{
			return _finalColor;
		}
	}
}