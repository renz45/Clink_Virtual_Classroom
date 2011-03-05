package com.clink.ui
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.events.UserListItemEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.loaders.EasyImageLoader;
	import com.clink.loaders.loaderEvents.ImageComplete_Event;
	import com.clink.main.ClinkMain;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class UserListItem extends Sprite
	{
		private var _name:String;
		private var _configInfo:VO_Settings;
		private var _isGradient:Boolean;
		private var _talkingIcon:Sprite;
		
		private var _userPermission:String;
		
		private var _defaultbg:Sprite;
		private var _handRaisedBg:Sprite;
		private var _thumbUpBg:Sprite;
		private var _thumbDownBg:Sprite;
		private var _laughBg:Sprite;
		private var _awayBg:Sprite;
		private var _modBar:Sprite;
		private var _tf:TextField;
		private var _tff1:TextFormat;
		private var _tff2:TextFormat;
		
		private var _mb:UserListButton;
		private var _hb:UserListButton;
		private var _pb:UserListButton;
		
		private var _itemWidth:Number;
		private var _itemHeight:Number;
		private var _userID:Number;
		
		private var _counter:Number;
		private var _userSO:Manager_remoteUserSharedObject;
		
		private var _slot:Number;
		
		private var _timer:Timer;
		
		private static var _userListItemList:Array;
		
		public function UserListItem(name:String,configInfo:VO_Settings, userSO:Manager_remoteUserSharedObject,userPermission:String,userId:Number,isGradient:Boolean = true)
		{
			super();
			
			_name = name;
			_configInfo = configInfo;
			_isGradient = isGradient;
			_userPermission = userPermission;
			_userSO = userSO;
			_userID = userId;
			init();
		}
		
		private function init():void
		{
			//keeps track of all the list items, this is used to help the rollover moderator panel disppear properly if the list is scrolled over quickly
			_userListItemList.push(this);
			
			_itemWidth = 186;
			_itemHeight = 22;
			
			//load the talking icon
			var eil:EasyImageLoader = new EasyImageLoader(_configInfo.userListItem_talkingIcon);
			eil.addEventListener(ImageComplete_Event.IMAGE_LOADED,onTalkingIconLoad);
			
			//draw the various bgs
			//default bg
			_defaultbg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_backgroundColor)),0,_isGradient);
			
			//raisedHand
			_handRaisedBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_handRaisedColor)),0,_isGradient);
			
			//thumbdown
			_thumbDownBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_thumbDownColor)),0,_isGradient);
			_thumbDownBg.mouseEnabled = false;
			
			//thumbUp
			_thumbUpBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_thumbUpColor)),0,_isGradient);
			_thumbUpBg.mouseEnabled = false;
			
			//laughing
			_laughBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_laughColor)),0,_isGradient);
			_laughBg.mouseEnabled = false;
			
			//away
			_awayBg = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_awayColor)),0,_isGradient,false,false,2,1,.3);
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
			_tff1 = new TextFormat(hv.fontName,12, uint(DrawingUtils.fixColorCode(_configInfo.userListItem_textColor)));
			_tff2 = new TextFormat(hv.fontName,12, uint(DrawingUtils.fixColorCode(_configInfo.userListItem_emoteTextColor)));
			
			_tf.setTextFormat(_tff1);
			
			this.addChild(_defaultbg);
			this.addChild(_tf);
			
			//if the current client has teacher permissions then add in the moderator bar
			if(_configInfo.userPermission == ClinkMain.TEACHER_PERMISSION)
			{
				this.buttonMode = true;
				
				//timer had to be added to delay the displaying of the moderator functions. Without the slight delay the mouse wheel scrolling doesn't work properly
				//the delay may have to be adjusted more to get the right balance.
				_timer = new Timer(150);
				_timer.addEventListener(TimerEvent.TIMER,showModFunc);
				
				//create the moderator bar
				_modBar = Factory_prettyBox.drawPrettyBox(_itemWidth,_itemHeight,uint(DrawingUtils.fixColorCode(_configInfo.userListItem_backgroundColor)),0,_configInfo.userListItem_isGradient);
				_modBar.buttonMode = true;
				
				var lb:LayoutBox = new LayoutBox(false,5);
				lb.x = 3;
				lb.y = 2;
				_modBar.addChild(lb);
				
				//presenter
				_pb = new UserListButton(18,18);
				_pb.upIcon = _configInfo.presenterBtn_upIcon;
				_pb.downIcon = _configInfo.presenterBtn_downIcon;
				_pb.message = _configInfo.presenterBtn_toolTip;
				_pb.enableToggle();
				lb.addChild(_pb);
				_pb.addEventListener(MouseEvent.CLICK,onPresenterClick);
				
				
				//mute
				_mb = new UserListButton(18,18);
				_mb.upIcon = _configInfo.muteBtn_upIcon;
				_mb.downIcon = _configInfo.muteBtn_downIcon;
				_mb.message = _configInfo.muteBtn_toolTip;
				_mb.enableToggle();
				lb.addChild(_mb);
				_mb.addEventListener(MouseEvent.CLICK,onMuteClick);
				
				
				//spacer
				var sp:Spacer = new Spacer(92,18);
				lb.addChild(sp);
				
				//boot
				var bb:UserListButton = new UserListButton(18,18);
				bb.upIcon = _configInfo.bootBtn_upIcon;
				bb.downIcon = _configInfo.bootBtn_downIcon;
				bb.message = _configInfo.bootBtn_toolTip;
				lb.addChild(bb);
				bb.addEventListener(MouseEvent.CLICK,onBootClick);
				
				
				
				this.addEventListener(MouseEvent.ROLL_OVER,onTeacherOver);
				this.addEventListener(MouseEvent.ROLL_OUT,onTeacherOut);
				_modBar.addEventListener(MouseEvent.ROLL_OUT,onTeacherOut);
				
				if(_userSO.getProperty("isMute",_userID))
				{
					_mb.down();
				}
				
				if(_userSO.getProperty("isPresenter",_userID))
				{
					_pb.down();
				}
			}
			
			//set default symbols if someone is mute or a presenter at login
			if(_userSO.getProperty("isMute",_userID))
			{
				setSymbol(_userID.toString(),true,"(M)");	
			
			}
			
			if(_userSO.getProperty("isPresenter",_userID))
			{
				setSymbol(_userID.toString(),true,"(P)");
			
			}
			
			_userSO.addEventListener(SharedObjectEvent.CHANGED,onSOChange);
			_userSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onSOChange);
		}
		
		//fades a bg added to the list item, these are the emote colors
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
		
		//removes away status when called
		private function removeAwayStatus():void
		{
	
			if(_awayBg.parent == this)
			{
				this.removeChild(_awayBg);
			}
			
		}
		
		//sets a symbol in the username textfield
		private function setSymbol(slot:String,value:Boolean,symbol:String):void
		{
			if(slot == _userID.toString())
			{
				if(value == true)
				{
					_tf.appendText(" " + symbol);
				}else{
					var tmpArr:Array = _tf.text.split(" ");
					
					tmpArr.splice(tmpArr.indexOf(symbol),1);
					_tf.text = tmpArr.join(" ");
					
				}
				_tf.setTextFormat(_tff1);
			}
		}
		
		/////////////////Callbacks//////////////////////
		
		//when the sharedObject changes
		private function onSOChange(e:SharedObjectEvent):void
		{
			switch(e.propertyName)
			{
				case "isMute":
					setSymbol(e.sharedObjectSlot,e.propertyValue,"(M)");
					break;
				case "isPresenter":
					setSymbol(e.sharedObjectSlot,e.propertyValue,"(P)");
					break;
				
			}
		}
		
		//the boot button is clicked
		private function onBootClick(e:MouseEvent):void
		{
			_userSO.setProperty("disconnect",true,_userID);
		}
		
		//mute is clicked
		private function onMuteClick(e:MouseEvent):void
		{
			if(_userSO.getProperty("isMute",_userID) == true)
			{
				_userSO.setProperty("isMute",false,_userID);
			}else{
				_userSO.setProperty("isMute",true, _userID);
			}
		}
		
		//presenter button is clicked
		private function onPresenterClick(e:MouseEvent):void
		{
			if(_userSO.getProperty("isPresenter",_userID))
			{
				_userSO.setProperty("isPresenter",false,_userID);	
			}else{
				_userSO.setProperty("isPresenter",true,_userID);
			}
			
		}
		
		//roll out of the mod panel
		private function onTeacherOut(e:MouseEvent):void
		{		
			
			for each(var u:UserListItem in _userListItemList)
			{
				u.removeMod();
			}
			
		}
		
		//teacher rolls of a list item
		private function onTeacherOver(e:MouseEvent):void
		{
			_timer.start();
			for each(var u:UserListItem in _userListItemList)
			{
				if(u != this)
				{
					u.removeMod();
				}
			}
		}
		
		//shows the mod panel, result of a timer action
		private function showModFunc(e:TimerEvent):void
		{
			this.addChildAt(_modBar,this.numChildren);
			
			for each(var u:UserListItem in _userListItemList)
			{
				if(u != this)
				{
					u.removeMod();
				}
			}
			_timer.reset();
		}
		
		//positions the talking icon so when the user is talking this icon is displayed accordingly
		private function onTalkingIconLoad(e:ImageComplete_Event):void
		{
			_talkingIcon = new Sprite();
			var bmp:Bitmap = e.imageLoaded;
			if(bmp.height > 22)
			{
				bmp.width =  bmp.width/(22/bmp.height);
				bmp.height = 22;
			}
			_talkingIcon.addChild(bmp);
			
			_talkingIcon.x = _itemWidth - bmp.width - 22;
			_talkingIcon.y = _itemHeight/2 - _talkingIcon.height/2;
			
		}
		
		//shows the hand up color
		private function onHandUpClick(e:MouseEvent):void
		{
			var evt:UserListItemEvent = new UserListItemEvent(UserListItemEvent.TEACHER_CALLED_ON);
			evt.userId = _userID;
			this.dispatchEvent(evt);
		}
		
		//fades thumbup bg
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
		
		//fades thumb down bg
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
		
		//fades laugh bg
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
		//removes mod panel for this item
		public function removeMod():void
		{
			_timer.reset();
			
			if(_modBar.parent == this)
			{
				this.removeChild(_modBar);
			}
		}
		
		//raise hand toggle on
		public function raiseHandEnable():void
		{
			removeAwayStatus();
			this.addChildAt(_handRaisedBg,1);
		}
		
		//raise hand toggle off
		public function raiseHandDisable():void
		{
			removeAwayStatus();
			if(_handRaisedBg.parent == this)
			{
				this.removeChild(_handRaisedBg);
			}
			
			
		}
		
		//thumb up bg comes on and fades out
		public function thumbUp(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_thumbUpBg.alpha = 1;
			this.addChildAt(_thumbUpBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,thumbUpFader);
		}
		
		//thumb down bg come on and fades out
		public function thumbDown(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_thumbDownBg.alpha = 1;
			this.addChildAt(_thumbDownBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,thumbDownFader);
		}
		
		//laugh bg comes on and fades out
		public function laugh(slot:Number):void
		{
			removeAwayStatus();
			_slot = slot;
			_laughBg.alpha = 1;
			this.addChildAt(_laughBg,this.numChildren - 1);
			_counter = 0;
			this.addEventListener(Event.ENTER_FRAME,laughFader);
		}
		
		//sets the away bg to on
		public function awayEnable():void
		{
			this.addChildAt(_awayBg,this.numChildren);
		}
		
		//sets the away bg to off
		public function awayDisable():void
		{
			removeAwayStatus();
		}
		
		//toggle the talking icon
		public function talking():void
		{
			if(_talkingIcon.parent == this)
			{
				this.removeChild(_talkingIcon);
			}else{
				this.addChildAt(_talkingIcon, this.numChildren - 1);
			}	
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
		
		//statics
		public static function init():void
		{
			_userListItemList = [];
		}
		
	}
}