package com.clink.ui
{
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class UserListItem extends Sprite
	{
		private var _name:String;
		private var _bgColor:uint;
		private var _textColor:uint;
		private var _handRaisedColor:uint;
		private var _thumbUpColor:uint;
		private var _thumbDownColor:uint;
		private var _laughColor:uint;
		private var _isGradient:Boolean;
		
		private var _defaultbg:Sprite;
		private var _handRaisedBg:Sprite;
		private var _thumbUpBg:Sprite;
		private var _thumbDownBg:Sprite;
		private var _laughBg:Sprite;
		private var _awayBg:Sprite;
		private var _tf:TextField;
		private var _tff1:TextFormat;
		private var _tff2:TextFormat;
		
		private var _itemWidth:Number;
		private var _itemHeight:Number;
		private var _userID:Number;
		
		private var _counter:Number;
		private var _userSO:Manager_remoteUserSharedObject;
		
		private var _slot:Number;
		
		public function UserListItem(name:String,bgColor:String,textColor:String,handRaisedColor:String,thumbUpColor:String, thumbDownColor:String, laughColor:String,userSO:Manager_remoteUserSharedObject,isGradient:Boolean = true)
		{
			super();
			
			_name = name;
			_bgColor = int(DrawingUtils.fixColorCode(bgColor));
			_textColor = int(DrawingUtils.fixColorCode(textColor));
			_handRaisedColor = int(DrawingUtils.fixColorCode(handRaisedColor));
			_thumbUpColor = int(DrawingUtils.fixColorCode(thumbUpColor));
			_thumbDownColor = int(DrawingUtils.fixColorCode(thumbDownColor));
			_laughColor = int(DrawingUtils.fixColorCode(laughColor));
			_isGradient = isGradient;
			
			_userSO = userSO;
			
			init();
		}
		
		private function init():void
		{
			_itemWidth = 186;
			_itemHeight = 22;
			
			
			//draw the various bgs
			_defaultbg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,_bgColor,0,_isGradient);
			
			_handRaisedBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,_handRaisedColor,0,_isGradient);
			_handRaisedBg.buttonMode = true;
			
			_thumbDownBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,_thumbDownColor,0,_isGradient);
			_thumbDownBg.mouseEnabled = false;
			
			_thumbUpBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,_thumbUpColor,0,_isGradient);
			_thumbUpBg.mouseEnabled = false;
			
			_laughBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,_laughColor,0,_isGradient);
			_laughBg.mouseEnabled = false;
			
			_awayBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,0xaaaaaa,0,_isGradient,false,false,2,1,.3);
			_awayBg.alpha = .7;
			
			//create the text field
			_tf = new TextField();
			_tf.text = _name;
			_tf.maxChars = 20;
			_tf.height = 14;
			_tf.width = 145;
			_tf.x = 7;
			_tf.y = 4;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			
			var hv:Font = new HelveticaRegular();
			_tff1 = new TextFormat(hv.fontName,12, _textColor);
			_tff2 = new TextFormat(hv.fontName,12, 0xffffff);
			
			_tf.setTextFormat(_tff1);
			
			this.addChild(_defaultbg);
			this.addChild(_tf);
			
		}
		
		private function fadeThis(bg:DisplayObject):Boolean
		{
			if(_counter % 10 == 0)
			{
				if(bg.alpha - .1 < 0)
				{
					bg.alpha = 0;
					if(bg.parent == this)
					{
						this.removeChild(bg);
					}
					bg.alpha = 1;
					
					return false
				}else{
					bg.alpha -= .1;
				}
			}
			
			_counter ++;
			return true;
		}
		
		private function removeAwayStatus():void
		{
			try{
				if(_awayBg.parent == this)
				{
					this.removeChild(_awayBg);
				}
			}
			catch(error:Error){
				trace("[UserListItem][userID: "+_userID+"] failed to remove 'awayBG' child from this userListItem");
			}
		}
		
		/////////////////Callbacks//////////////////////
		
		private function thumbUpFader(e:Event):void
		{
			if(!fadeThis(_thumbUpBg))
			{
				this.removeEventListener(Event.ENTER_FRAME,thumbUpFader);
				
				if(_slot == _userID)
				{
					_userSO.setProperty("isThumbUp",false);
				}
			}
		}
		
		private function thumbDownFader(e:Event):void
		{
			if(!fadeThis(_thumbDownBg))
			{
				this.removeEventListener(Event.ENTER_FRAME,thumbDownFader);
				
				if(_slot == _userID)
				{
					_userSO.setProperty("isThumbDown",false);
				}
			}
		}
		
		private function laughFader(e:Event):void
		{
			if(!fadeThis(_laughBg))
			{
				this.removeEventListener(Event.ENTER_FRAME,laughFader);
				
				if(_slot == _userID)
				{
					_userSO.setProperty("isLaughing",false);
				}
			}
		}
		
		
		/////////////////////public methods////////////////////
		
		public function raiseHandEnable():void
		{
			removeAwayStatus();
			this.addChildAt(_handRaisedBg,1);
		}
		
		public function raiseHandDisable():void
		{
			removeAwayStatus();
			try{
				this.removeChild(_handRaisedBg);
			}
			catch(error:Error){
				trace("[UserListItem][userID: "+_userID+"] failed to remove 'handRaisedBG' child from this userListItem");
			}
			
		}
		
		public function thumbUp(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_thumbUpBg.alpha = 1;
			this.addChildAt(_thumbUpBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,thumbUpFader);
		}
		
		public function thumbDown(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_thumbDownBg.alpha = 1;
			this.addChildAt(_thumbDownBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,thumbDownFader);
		}
		
		public function laugh(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_laughBg.alpha = 1;
			this.addChildAt(_laughBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,laughFader);
		}
		
		public function awayEnable():void
		{
			this.addChildAt(_awayBg,this.numChildren);
		}
		
		public function awayDisable():void
		{
			removeAwayStatus();
		}
		
		////////////////getters/setters/////////////////
		public function get username():String
		{
			return _name;
		}
		
		public function set userID(userID:Number):void
		{
			_userID = userID;
		}
		
		public function get userID():Number
		{
			return _userID;
		}
	}
}