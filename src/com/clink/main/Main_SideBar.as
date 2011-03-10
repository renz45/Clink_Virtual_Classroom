package com.clink.main
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.events.SharedObjectEvent;
	import com.clink.events.SideBarEvent;
	import com.clink.events.UserListItemEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.UserListItem;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.Sprite;
	import flash.net.NetConnection;
	
	[Event(name="userSoLoaded", type="com.clink.events.SideBarEvent")]
	[Event(name="chatSoLoaded", type="com.clink.events.SideBarEvent")]

	public class Main_SideBar extends Sprite
	{
		
		private var _body:Sprite;
		
		private var _userSO:Manager_remoteUserSharedObject;
		private var _chatSO:Manager_remoteCommonSharedObject;
		private var _configInfo:VO_Settings;
		
		private var _vm:VideoMonitor;
		private var _userList:UserList;
		private var _tc:TextChat;
		
		public function Main_SideBar(configInfo:VO_Settings)
		{
			super();
			
			_configInfo = configInfo;
			init();
		}
		
		private function init():void
		{
			//set color and option defaults
			
			
			createComponents();
			draw();
			
		}
		
		private function createComponents():void
		{
			//create the user SharedObject which keeps track of all users
			var template:Object = {userPermission:_configInfo.userPermission, 
									username:_configInfo.username,
									isHidden:false,
									isMute:false,
									isPresenter:false,
									isHandRaised:false,
									isThumbUp:false,
									isThumbDown:false,
									isLaughing:false,
									isAway:false,
									isTalking:false,
									isCameraOn:false,
									isMicOn:false,
									streamName:(_configInfo.userID).toString(),
									disconnect:false,
									connected:false,
									isGroupMute:false};
			
			_userSO = new Manager_remoteUserSharedObject(_configInfo.netConnection,_configInfo.userID,"userSO",template);
			_userSO.addEventListener(SharedObjectEvent.CONNECTED,onUserSoConnect);
			
			//create and position the videoMonitor
			_vm = new VideoMonitor(_configInfo,_userSO);
			_vm.x = 6;
			_vm.y = 6;
			
			//create and position the userList
			_userList = new UserList(_configInfo,_userSO);
			_userList.y = _vm.height+10;
			_userList.addEventListener(UserListItemEvent.BREAK_OUT,onBreakOut);
			_userList.addEventListener(UserListItemEvent.BREAK_IN,onBreakIn);
			
			
			this.addChild(_userList);
			
			
			//create chat sharedObject
			var chatTemplate:Object = {1:{name:_configInfo.textChat_welcomeUsername,msg:_configInfo.textChat_welcomeMessage}};
			
			_chatSO = new Manager_remoteCommonSharedObject("chatSO",chatTemplate,_configInfo.netConnection);
			_chatSO.addEventListener(SharedObjectEvent.CONNECTED,onChatSoConnect);
			//create and position the text chat
			_tc = new TextChat(_chatSO,_configInfo);
			_tc.x = 6;
			_tc.y = _userList.y + _userList.height + 6;
			this.addChild(_tc);
			
			//the video monitor needs to be the top child in the sidebar object so the volume slider doesnt get lost, I will need to revisit this later.
			this.addChild(_vm);
		}
		
		private function draw():void
		{
			if(_body)
			{
				this.removeChild(_body);
				_body = null;
			}
			
			//draw main body
			_body = Factory_prettyBox.drawPrettyBox(232,600,uint(DrawingUtils.fixColorCode(_configInfo.sideBar_BgColor)),_configInfo.sideBar_cornerRadius,_configInfo.sideBar_isGradient);
			this.addChildAt(_body,0);
			var dragger:Controller_Dragable = new Controller_Dragable(this,_body);
			
			
		}
		
		////////////////////////////CallBacks//////////////////////////
		private function onBreakOut(e:UserListItemEvent):void
		{
			_tc.expand();
			_tc.y = _vm.height+10;
		}
		
		private function onBreakIn(e:UserListItemEvent):void
		{
			_tc.shrink();
			_tc.x = 6;
			_tc.y = _userList.y + _userList.height + 6;
		}
		
		private function onUserSoConnect(e:SharedObjectEvent):void
		{
			var evt:SideBarEvent = new SideBarEvent(SideBarEvent.USER_SO_LOADED);
			evt.userSO = _userSO;
			this.dispatchEvent(evt);
		}
		
		private function onChatSoConnect(e:SharedObjectEvent):void
		{
			var evt:SideBarEvent = new SideBarEvent(SideBarEvent.CHAT_SO_LOADED);
			evt.chatSO = _chatSO;
			this.dispatchEvent(evt);
		}
			
			
			///////////////////////Getters/Setters////////////////////////
			
		public function get userSO():Manager_remoteUserSharedObject
		{
			return _userSO;
		}
		
		public function get chatSO():Manager_remoteCommonSharedObject
		{
			return  _chatSO;
		}
		
		public function get textChatObject():TextChat
		{
			return _tc;
		}
	}
}