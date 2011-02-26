package com.clink.main
{
	import com.clink.controllers.Controller_Dragable;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteUserSharedObject;
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
		
		public function Main_SideBar(configInfo:VO_Settings)
		{
			super();
			
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
									streamName:_configInfo.username + _configInfo.userID.toString(),
									disconnect:false};
			
			_userSO = new Manager_remoteUserSharedObject(_configInfo.netConnection,_configInfo.userID,"userSO",template);
			
			_vm = new VideoMonitor(_configInfo,_userSO);
			
			this.addChild(_vm);
			_vm.x = 6;
			_vm.y = 6;
			
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