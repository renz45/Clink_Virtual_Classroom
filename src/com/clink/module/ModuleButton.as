package com.clink.module
{
	import com.clink.base.Base_componentToolTip;
	import com.clink.events.ModuleButtonEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.main.ClinkMain;
	import com.clink.ui.BasicButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ModuleButton extends Sprite
	{
		private var _moduleName:String;
		private var _module:BaseModule;
		
		private var _labelColor:uint;
		private var _upColor:uint;
		private var _downColor:uint;
		private var _label:String;
		
		private var _upBg:Sprite;
		private var _downBg:Sprite;
		private var _userPermission:String;
		
		private static var _moduleBtnList:Array;
		
		public function ModuleButton(label:String, labelColor:uint, upColor:uint, downColor:uint, userPermission:String)
		{
			_labelColor = labelColor;
			_upColor = upColor;
			_downColor = downColor;
			_label = label;
			_userPermission = userPermission;
			
			init();
		}
		
		private function init():void
		{
			_moduleBtnList.push(this);
			
			var tf:TextField = new TextField();
			tf.text = _label;
			tf.height = 24;
			tf.width -= 25;
			
			var f:Font = new HelveticaRegular();
			
			var tff:TextFormat = new TextFormat(f.fontName, 12,_labelColor,null,null,null,null,null,TextFormatAlign.CENTER);
			tf.setTextFormat(tff);
			this.addChild(tf);
			
			tf.y = 8;
			tf.mouseEnabled = false;
			tf.selectable = false;
			this.buttonMode = true;
	
			//add focus button onto the button if the client is a teacher
			if(_userPermission == ClinkMain.TEACHER_PERMISSION)
			{
				var focusBtn:Base_componentToolTip = new Base_componentToolTip();
				
				focusBtn.graphics.beginFill(0xffffff,0);
				focusBtn.graphics.drawRect(0,0,16,16);
				focusBtn.graphics.endFill();
				focusBtn.graphics.lineStyle(1,_labelColor);
				focusBtn.graphics.moveTo(8,0);
				focusBtn.graphics.lineTo(8,16);
				focusBtn.graphics.moveTo(0,8);
				focusBtn.graphics.lineTo(16,8);
				focusBtn.graphics.drawCircle(8,8,6);
				
				_upBg = Factory_prettyBox.drawPrettyBox(tf.width + 13,tf.height + 6,_upColor);
				this.addChildAt(_upBg,0);
				_downBg = Factory_prettyBox.drawPrettyBox(tf.width + 13,tf.height + 6,_downColor);
				this.addChildAt(_downBg,0);
				
				focusBtn.x = this.width - 20;
				focusBtn.y = this.height/2 - focusBtn.height/2;
				
				focusBtn.addEventListener(MouseEvent.CLICK,onFocusClick);
				
				this.addChildAt(focusBtn,this.numChildren);
				
			}else{
				_upBg = Factory_prettyBox.drawPrettyBox(tf.width,tf.height + 6,_upColor);
				this.addChildAt(_upBg,0);
				
				_downBg = Factory_prettyBox.drawPrettyBox(tf.width,tf.height + 6,_downColor);
				this.addChildAt(_downBg,0);
			}
			
			this.addEventListener(MouseEvent.CLICK,onClick);
			
		}
		////////////////////////callbacks/////////////////////////
		
		private function onFocusClick(e:MouseEvent):void
		{
			this.dispatchEvent(new ModuleButtonEvent(ModuleButtonEvent.FOCUS_THIS));
		}
		
		private function onClick(e:MouseEvent):void
		{
			for each(var b:ModuleButton in _moduleBtnList)
			{
				if(b != this)
				{
					b.up();
				}else{
					b.down();
				}
			}
		}
		
		
		///////////////////////public methods///////////////////////
		public function up():void
		{
			this.setChildIndex(_downBg,0);
		}
		
		public function down():void
		{
			this.setChildIndex(_upBg,0);
		}
		
		///////////////////////getters/setters//////////////////////
		public function set moduleName(name:String):void
		{
			_moduleName = name;
		}
		
		public function get moduleName():String
		{
			return _moduleName;
		}
		
		public function set module(mod:BaseModule):void
		{
			_module = mod;
		}
		
		public function get module():BaseModule
		{
			return _module;
		}
		
		//////////////////////////////statics////////////////////////
		public static function init():void
		{
			_moduleBtnList = [];
		}
	}
}