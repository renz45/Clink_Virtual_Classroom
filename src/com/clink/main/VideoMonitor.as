package com.clink.main
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.BasicButton;
	import com.clink.ui.LayoutBox;
	import com.clink.valueObjects.VO_Settings;
	import com.clink.video.VideoPlayer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.NetConnection;
	import flash.ui.Keyboard;
	import flash.ui.MouseCursor;
	
	public class VideoMonitor extends Sprite
	{
		private var _vp1:VideoPlayer;
		private var _vp2:VideoPlayer;
		private var _cameraBtn:BasicButton;
		private var _micBtn:BasicButton;
		private var _volumeBtn:BasicButton;
		private var _pushToTalkBtn:BasicButton;
		
		private var _userSO:Manager_remoteUserSharedObject;
		
		private var _configInfo:VO_Settings;
		
		private var _mainLB:LayoutBox;
		private var _btnLB:LayoutBox;
		
		public function VideoMonitor(configInfo:VO_Settings,userSO:Manager_remoteUserSharedObject)
		{
			super();
			
			
			_userSO = userSO;
			
			init();
		}
		
		private function init():void
		{
			_mainLB = new LayoutBox(true);
			this.addChild(_mainLB);
			
			_vp1 = new VideoPlayer(_configInfo.netConnection.uri,_configInfo.netConnection);
			_vp1.width = 220;
			_vp1.height = 145;
			
			_vp2 = new VideoPlayer(_configInfo.netConnection.uri,_configInfo.netConnection);
			
			//load image for this
			var vpBox:Sprite = Factory_prettyBox.drawPrettyBox(220,145,0xffffff,0,false,false,true,2,1,.3);
			vpBox.addChild(_vp1);
			_mainLB.addChild(vpBox);
			
			
			_userSO.addEventListener(SharedObjectEvent.CHANGED,onSoChanged);
			
			setupUI();
		}
		
		private function setupUI():void
		{
			_btnLB = new LayoutBox(false);
			
			//camera button
			_cameraBtn = new BasicButton(28,28,true);
			_cameraBtn.upIcon = _configInfo.cameraBtn_upIcon;
			_cameraBtn.downIcon = _configInfo.cameraBtn_downIcon;
			_cameraBtn.overIcon = _configInfo.cameraBtn_overIcon;
			_cameraBtn.message = _configInfo.cameraBtn_toolTip;
			_cameraBtn.enableToggle();
			
			_btnLB.addChild(_cameraBtn);
			
			//mic button
			_micBtn = new BasicButton(28,28,true);
			_micBtn.upIcon = _configInfo.micBtn_upIcon;
			_micBtn.downIcon = _configInfo.micBtn_downIcon;
			_micBtn.overIcon = _configInfo.micBtn_overIcon;
			_micBtn.message = _configInfo.micBtn_toolTip;
			_micBtn.enableToggle();
			_btnLB.addChild(_micBtn);
			
			//volume button
			_volumeBtn = new BasicButton(28,28,true);
			_volumeBtn.upIcon = _configInfo.volumeBtn_upIcon;
			_volumeBtn.downIcon = _configInfo.volumeBtn_downIcon;
			_volumeBtn.overIcon = _configInfo.volumeBtn_overIcon;
			_volumeBtn.message = _configInfo.volumeBtn_toolTip;
			_btnLB.addChild(_volumeBtn);
			
			//push to talk button
			_pushToTalkBtn = new BasicButton(28,28,true);
			_pushToTalkBtn.upIcon = _configInfo.pushToTalkBtn_upIcon;
			_pushToTalkBtn.downIcon = _configInfo.pushToTalkBtn_downIcon;
			_pushToTalkBtn.overIcon = _configInfo.pushToTalkBtn_overIcon;
			_pushToTalkBtn.message = _configInfo.pushToTalkBtn_toolTip;
			_pushToTalkBtn.shortCutKey = Keyboard.CONTROL;
			_pushToTalkBtn.addEventListener(MouseEvent.MOUSE_DOWN,talkBtnDown);
			_pushToTalkBtn.addEventListener(MouseEvent.MOUSE_UP,talkBtnUp);
			_btnLB.addChild(_pushToTalkBtn);
			
			_mainLB.addChild(_btnLB);
		}
		
		
		/////////////////callbacks///////////////
		
		private function talkBtnDown(e:MouseEvent):void
		{
			_userSO.setProperty("isTalking",true);
			_vp2.record(_configInfo.username+_configInfo.userID.toString(), "live");
		}
		
		private function talkBtnUp(e:MouseEvent):void
		{
			_userSO.setProperty("isTalking",false);
			_vp2.stop();
		}
		
		private function onSoChanged(e:SharedObjectEvent):void
		{
			
			switch(e.propertyName)
			{
				case "isTalking":
					_vp1.play(_userSO.getProperty("streamName",int(e.sharedObjectSlot)) as String);
					break;
			}
		}
	}
}