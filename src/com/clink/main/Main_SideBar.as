package com.clink.main
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.UserListItem;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.Sprite;
	import flash.net.NetConnection;

	public class Main_SideBar extends Sprite
	{
		
		private var _body:Sprite;
		
		private var _userSO:Manager_remoteUserSharedObject;
		private var _configInfo:VO_Settings;
		
		private var _vm:VideoMonitor;
		private var _userList:UserList;
		
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
									connected:false};
			
			_userSO = new Manager_remoteUserSharedObject(_configInfo.netConnection,_configInfo.userID,"userSO",template);
			
			//create and position the videoMonitor
			_vm = new VideoMonitor(_configInfo,_userSO);
			_vm.x = 6;
			_vm.y = 6;
			
			//create and position the userList
			_userList = new UserList(_configInfo,_userSO);
			_userList.y = _vm.height+10;
			
			this.addChild(_userList);
			
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
		
		
		///////////////////////Getters/Setters////////////////////////
		
	}
}