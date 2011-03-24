package com.critique.ui
{
	import com.clink.base.Base_componentToolTip;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.Slider;
	import com.critique.controllers.MultiButton;
	import com.critique.events.ColorPickerEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	import lib.MainToolBar;
	
	public class LeftToolBar extends MainToolBar
	{
		private var _buttonToggleList:Object;
		private var _strokeCp:ColorPickerModal;
		private var _fillCp:ColorPickerModal;
		
		private var _zSlider:Slider;
		private var _userValuesSO:Manager_remoteUserSharedObject;
		
		public function LeftToolBar(userValuesSO:Manager_remoteUserSharedObject)
		{
			super();
			
			_userValuesSO = userValuesSO;
			
			init();
		}
		
		private function init():void
		{
			_buttonToggleList = {};
			//setup buttons and their controllers
			var btnArrowController:MultiButton = new MultiButton(this.btn_arrow,true,true);
			_buttonToggleList[this.btn_arrow.name] = btnArrowController;
			this.btn_arrow.addEventListener(MouseEvent.CLICK, setTool);
			btnArrowController.down();
			
			var btnPencilController:MultiButton = new MultiButton(this.btn_pencil,true,true);
			_buttonToggleList[this.btn_pencil.name] = btnPencilController;
			this.btn_pencil.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnSquareController:MultiButton = new MultiButton(this.btn_square,true,true);
			_buttonToggleList[this.btn_square.name] = btnSquareController;
			this.btn_square.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnCircleController:MultiButton = new MultiButton(this.btn_circle,true,true);
			_buttonToggleList[this.btn_circle.name] = btnCircleController;
			this.btn_circle.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnLineController:MultiButton = new MultiButton(this.btn_line,true,true);
			_buttonToggleList[this.btn_line.name] = btnLineController;
			this.btn_line.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnEraserController:MultiButton = new MultiButton(this.btn_eraser,true,true);
			_buttonToggleList[this.btn_eraser.name] = btnEraserController;
			this.btn_eraser.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnDrawMaskController:MultiButton = new MultiButton(this.btn_drawMask,true,true);
			_buttonToggleList[this.btn_drawMask.name] = btnDrawMaskController;
			this.btn_drawMask.addEventListener(MouseEvent.CLICK, setTool);
			
			var btnToggleMaskController:MultiButton = new MultiButton(this.btn_toggleMask,true,true);
			
			var btnTextController:MultiButton = new MultiButton(this.btn_text,true,true);
			_buttonToggleList[this.btn_text.name] = btnTextController;
			this.btn_text.addEventListener(MouseEvent.CLICK, setTool);
			
			//set up the color button
			this.btn_colors.addEventListener(MouseEvent.CLICK, setColors);
			this.btn_colors.mc_strokeColor.mouseChildren = false; 
			this.btn_colors.mc_fillColor.mouseChildren = false;
			this.btn_colors.buttonMode = true;
			
			_strokeCp = new ColorPickerModal();
			_fillCp = new ColorPickerModal();
			
			_strokeCp.addEventListener(ColorPickerEvent.COLOR_CHOSEN,onStrokeChosen);
			_fillCp.addEventListener(ColorPickerEvent.COLOR_CHOSEN,onFillChosen);
			
			//setup zoom slider
			_zSlider = new Slider(this.slider_zoom.mc_handle,this.slider_zoom);  
			_zSlider.addEventListener(Event.CHANGE,onZoomChange);
			
		}
		
		
		
		//////////////////////////Callbacks/////////////////////////
		
		private function onZoomChange(e:Event):void
		{
			_userValuesSO.setProperty("zoomPercent", _zSlider.value);
		}
		
		private function onStrokeChosen(e:ColorPickerEvent):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = e.color;
			
			_userValuesSO.setProperty("strokeColor",e.color);
			
			this.btn_colors.mc_strokeColor.inner.transform.colorTransform = ct;
		}
		
		private function onFillChosen(e:ColorPickerEvent):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = e.color; 
			
			_userValuesSO.setProperty("fillColor",e.color);
			
			this.btn_colors.mc_fillColor.inner.transform.colorTransform = ct;
		}
		
		private function setColors(e:MouseEvent):void
		{
			this.btn_colors.setChildIndex(e.target as MovieClip,this.btn_colors.numChildren - 1);
			
			_strokeCp.x = _fillCp.x = this.btn_colors.x + this.btn_colors.width + 10;
			_strokeCp.y = _fillCp.y = this.btn_colors.y - _strokeCp.height + this.btn_colors.height;
			
			switch(e.target.name)
			{
				case "mc_fillColor":
					this.addChild(_fillCp);
					
					if(_strokeCp.parent == this)
					{
						this.removeChild(_strokeCp);
					}
					break;
				
				case "mc_strokeColor":
					this.addChild(_strokeCp);
					
					if(_fillCp.parent == this)
					{
						this.removeChild(_fillCp);
					}
					break;
			}
		}
		
		private function setTool(e:MouseEvent):void
		{

			for (var k:String in _buttonToggleList)
			{
				if(k != (e.target as MovieClip).name)
				{
					(_buttonToggleList[k] as MultiButton).up();
				}else{
					(_buttonToggleList[k] as MultiButton).down();
				}
			}
			
			switch(e.target.name)
			{
				case "btn_arrow":
					_userValuesSO.setProperty("tool","arrow");
					break;
				
				case "btn_pencil":
					_userValuesSO.setProperty("tool","pencil");
					break;
				
				case "btn_square":
					_userValuesSO.setProperty("tool","square");
					break;
				
				case "btn_circle":
					_userValuesSO.setProperty("tool","circle");
					break;
				
				case "btn_line":
					_userValuesSO.setProperty("tool","line");
					break;
				
				case "btn_eraser":
					_userValuesSO.setProperty("tool","eraser");
					break;
				
				case "btn_drawMask":
					_userValuesSO.setProperty("tool","mask");
					break;
				
				case "btn_text":
					_userValuesSO.setProperty("tool","text");
					break;
			}
			
		}
		
		/////////////////////////public methods/////////////////////
	}
}