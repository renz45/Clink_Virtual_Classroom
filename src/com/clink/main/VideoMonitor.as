package com.clink.main
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.factories.Factory_triangle;
	import com.clink.loaders.EasyImageLoader;
	import com.clink.loaders.loaderEvents.ImageComplete_Event;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.BasicButton;
	import com.clink.ui.LayoutBox;
	import com.clink.ui.Slider;
	import com.clink.ui.Spacer;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_Settings;
	import com.clink.video.VideoChatPlayer;
	
	import flash.display.Sprite;
	import flash.events.ActivityEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.geom.Point;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.ui.Keyboard;
	import flash.ui.MouseCursor;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.elements.Configuration;
	
	import org.osmf.net.dynamicstreaming.INetStreamMetrics;
	
	public class VideoMonitor extends Sprite
	{	
		private var _streamList:Array;
		private var _streamNameList:Array;
		
		private var _streamPublisher:VideoChatPlayer;
		private var _cameraBtn:BasicButton;
		private var _micBtn:BasicButton;
		private var _volumeBtn:BasicButton;
		private var _pushToTalkBtn:BasicButton;
		private var _vpBox:Sprite;
		private var _vSlider:Slider;
		private var _volumeSlider:Sprite;
		private var _selfVideo:Video;
		
		private var _userSO:Manager_remoteUserSharedObject;
		
		private var _configInfo:VO_Settings;
		private var _volume:Number;
		private var _bufferTime:Number;
		
		private var _mainLB:LayoutBox;
		private var _btnLB:LayoutBox;
		
		private var _hasCamera:Boolean;
		private var _hasMic:Boolean;
		private var _isMute:Boolean;
		
		public function VideoMonitor(configInfo:VO_Settings,userSO:Manager_remoteUserSharedObject)
		{
			super();
			
			
			_userSO = userSO;
			_configInfo = configInfo;
			init();
		}
		
		private function init():void
		{
			//set default vaules
			_volume = 1;
			_bufferTime = _configInfo.videoMonitor_videoBufferTime;
			
			_isMute = false;
			
			_streamList = [];
			_streamNameList = [];
			
			_mainLB = new LayoutBox(true);
			this.addChild(_mainLB);
			
			//create the videoChatPlayer instance that is responsible for publishing the stream when the talk button is pressed.
			_streamPublisher = new VideoChatPlayer(_configInfo.netConnection);
			
			//load an image for the background of the the video play area
			var eil:EasyImageLoader = new EasyImageLoader(_configInfo.videoMonitor_videoBg);
			eil.addEventListener(ImageComplete_Event.IMAGE_LOADED,bgImgLoaded);
			
			_vpBox = Factory_prettyBox.drawPrettyBox(220,145,0xffffff,0,false,false,true);
			_mainLB.addChild(_vpBox);
			
			//add event listners to the sharedObject created by the main sideBar class
			_userSO.addEventListener(SharedObjectEvent.CHANGED,onSoChanged);
			_userSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onSoChanged);
			_userSO.addEventListener(SharedObjectEvent.CONNECTED,onSoConnected);
			_userSO.addEventListener(SharedObjectEvent.DELETED,onSoDelete);
			
			//create the ui components
			setupUI();
		}
		
		private function setupUI():void
		{
			//layout box that holds the buttons
			_btnLB = new LayoutBox(false);
			
			//create the camera button
			_cameraBtn = new BasicButton(28,28,true);
			_cameraBtn.upIcon = _configInfo.cameraBtn_upIcon;
			_cameraBtn.downIcon = _configInfo.cameraBtn_downIcon;
			_cameraBtn.overIcon = _configInfo.cameraBtn_overIcon;
			_cameraBtn.addEventListener(MouseEvent.CLICK,cameraToggle);
			_btnLB.addChild(_cameraBtn);
			_cameraBtn.enableToggle();
			_hasCamera = false;
			//if there is a camera connected
			if(Camera.getCamera())
			{
				//give it the set tooltip from the config.xml
				_cameraBtn.message = _configInfo.cameraBtn_toolTip;
				
				//create the self video, picture in picture showing your feed, resize and position it in the bottom right corner of the main video
				_selfVideo = new Video();
				_selfVideo.width = 73;
				_selfVideo.height = 52;
				_selfVideo.x = 147;
				_selfVideo.y = 93;
				
			}else{
				//if there is no camera attached/installed than change the button tooltip to an error message
				_cameraBtn.message = "Please attach a camera to use this function";
			}
			
			//create the mic button
			_micBtn = new BasicButton(28,28,true);
			_micBtn.upIcon = _configInfo.micBtn_upIcon;
			_micBtn.downIcon = _configInfo.micBtn_downIcon;
			_micBtn.overIcon = _configInfo.micBtn_overIcon;
			_micBtn.addEventListener(MouseEvent.CLICK,micToggle);
			_btnLB.addChild(_micBtn);
			_micBtn.enableToggle();
			_hasMic = false;
			//if there is a mic connected/installed
			if(Microphone.getMicrophone())
			{
				_micBtn.message = _configInfo.micBtn_toolTip;
				Microphone.getMicrophone().gain = _configInfo.videoMonitor_micGain;
			}else{
				//if there is no mic than change the tooltip to an error message
				_micBtn.message = "Please attach a microphone to use this function";
			}
			
			//create the volume button
			_volumeBtn = new BasicButton(28,28,true);
			_volumeBtn.upIcon = _configInfo.volumeBtn_upIcon;
			_volumeBtn.downIcon = _configInfo.volumeBtn_downIcon;
			_volumeBtn.overIcon = _configInfo.volumeBtn_overIcon;
			_volumeBtn.message = _configInfo.volumeBtn_toolTip;
			_btnLB.addChild(_volumeBtn);
			_volumeBtn.addEventListener(MouseEvent.MOUSE_DOWN,volumeClick);
			
			//create a spacer so the push to talk button is in the correct location
			var spacer:Spacer = new Spacer(95,28);
			_btnLB.addChild(spacer);
			
			//create the push to talk button
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
			
			//create the volume slider
			//slider background
			_volumeSlider = Factory_prettyBox.drawPrettyBox(28,100,uint(DrawingUtils.fixColorCode(_configInfo.videoMonitor_volumeTrackColor)),0,true,true,true);
			var trackTri:Sprite = Factory_triangle.drawEqTriangle(50,140,uint(DrawingUtils.fixColorCode(_configInfo.videoMonitor_volumeTriangleColor)),"down");
			trackTri.y = 51;
			_volumeSlider.addChild(trackTri);
			var triMask:Sprite = new Sprite();
			triMask.graphics.beginFill(0xffffff,0);
			triMask.graphics.drawRect(0,0,26,98);
			triMask.graphics.endFill();
			triMask.x = triMask.y = 1;
			_volumeSlider.addChild(triMask);
			trackTri.mask = triMask;
			
			//track, which is invisible and overlayed on the track background
			var track:Sprite = new Sprite();
			track.graphics.beginFill(0xffffff,0);
			track.graphics.drawRect(0,0,28,100);
			track.graphics.endFill();
			_volumeSlider.addChild(track);
			
			//handle
			var handle:Sprite = Factory_prettyBox.drawPrettyBox(30,15,uint(DrawingUtils.fixColorCode(_configInfo.videoMonitor_volumeHandleColor)),0,true);
			track.addChild(handle);
			
			//attach the slider controller
			_vSlider = new Slider(handle,track);
			_vSlider.value = 0;
			
			//position the slider to be right on top of the volume toggle button
			_volumeSlider.x = 64;
			_volumeSlider.y = _mainLB.height - 29;
			
			//add event listeners to remove the slider on mouseout and to update the volume when the slider value changes.
			_volumeSlider.addEventListener(MouseEvent.ROLL_OUT,volumeSliderOut);
			_vSlider.addEventListener(Event.CHANGE,volumeSliderChange);
		}
		
		//called to update the voice/video chat
		/*this function takes a slot and isTalking boolean value, this is called by the sharedObject CHANGE, CLIENT_CHANGE events, and is also looped through in the beginning
		in order to display people who are talking when the user logs in. */
		private function connectToStreams(slot:int,isTalking:Boolean):void
		{	
			var stream:String = slot.toString();
	
			if(isTalking == true)
			{//is playing isTalking = true
				//if the stream name exists in the the array of stream names
				if(_streamNameList.indexOf(stream) == -1)
				{
					//create new videoChatPlayer
					var vcp:VideoChatPlayer = new VideoChatPlayer(_configInfo.netConnection);
					vcp.width = 220;
					vcp.height = 145;
					vcp.volume = _volume;
					vcp.bufferTime = _bufferTime;
					
					//add that player into the player array and the stream name into the name array
					_streamNameList.push(stream);
					_streamList.push(vcp);
					
					/*if the stream is this clients stream, than only display the video, no sound. This does it's best to prevent feedback, 
					although feedback will still occur if two people are talkinga t the same time */
					if(slot == _configInfo.userID)
					{
						vcp.isMute = true;
					}
					
					vcp.play(stream);
					//if that is the first stream in the array then go ahead and display the video on the monitor
					if(_streamList.indexOf(vcp) == 0)
					{
						_vpBox.addChild(vcp);
					}
				}
			}else{//stops playing isTalking = false
				
				//get the index from the stream name array
				var index:int = _streamNameList.indexOf(stream);
				//if the stream isnt found in the stream name array we want to ignore it.
				if(index > -1)
				{
					//extract the videoChatPlayer from the array with stream name given, stop the player.
					var vcpDeleted:VideoChatPlayer = _streamList[index];
					vcpDeleted.stop();
					
					//if the stream name list has more than one item in it, than remove this player and stream name from the arrays, else set the arrays to empty
					//I had to set these to empty because you cant splice the last item from the array, so if only 1 exists we just empty the arrays completely
					if(_streamNameList.length > 1)
					{
						_streamList.splice(index,1);
						_streamNameList.splice(index,1);
					}else{
						_streamList = [];
						_streamNameList = [];
					}
					
					//if the video was displayed on the monitor than go ahead and remove it.
					if(vcpDeleted.parent == _vpBox)
					{
						_vpBox.removeChild(vcpDeleted);
						vcpDeleted = null;
						/*if there is still one video player in the list than display the one at the first array slot. 
						This makes it so users are displayed in order of pushing their talk buttons */
						if(_streamList[0])
						{
							_vpBox.addChild(_streamList[0]);
						}
					}
				}
			}
		}
		
		
		/////////////////callbacks///////////////
		
		//loading the monitor bg image callback
		private function bgImgLoaded(e:ImageComplete_Event):void
		{
			_vpBox.addChildAt(e.imageLoaded,0);
		}
		
		//volume slider change
		private function volumeSliderChange(e:Event):void
		{
			_volume = 1 - _vSlider.value;
			//go into the player list array and change all their volumes.
			for each(var vcp:VideoChatPlayer in _streamList)
			{
				vcp.volume = _volume;
			}
		}

		//remove the volume slider when the user mouses out
		private function volumeSliderOut(e:MouseEvent):void
		{
			this.removeChild(_volumeSlider);
		}
		
		//display the volume slider when a user clicks on the volume button
		private function volumeClick(e:MouseEvent):void
		{
			this.addChild(_volumeSlider);
		}
		
		//toggle the camera on and off when the user clicks the camera toggle button
		private function cameraToggle(e:MouseEvent):void
		{	
			//the state is down because when the listener picks this up the button is starting from down going to up state and down is seen first
			if(_cameraBtn.state == "down")
			{
				_hasCamera = false;
				//remove picture in picture
				if(_selfVideo.parent == this)
				{
					_selfVideo.attachCamera(null);
					this.removeChild(_selfVideo);
				}
			//the state is up because when the listener picks this up the button is starting from up going to down state and up is seen first
			}else if(_cameraBtn.state == "up")
			{
				//if the camera is installed/plugged in and the user accepted the flash security settings pop-up
				if(Camera.getCamera() && !(Camera.getCamera().muted))
				{
					_cameraBtn.message = _configInfo.cameraBtn_toolTip;
					_hasCamera = true;
					
					//attach picture in picture
					_selfVideo.attachCamera(Camera.getCamera());
					this.addChild(_selfVideo);
					
				}else{//if the camera isnt installed or plaugged in, or the user didn't accept the security settings
					//remove picture in picture
					if(_selfVideo.parent == this)
					{
						_selfVideo.attachCamera(null);
						this.removeChild(_selfVideo);
					}
					
					_cameraBtn.up();
					_hasCamera = false;
					_cameraBtn.message = "Please attach or allow your camera to use this function";
				}
				
			}
		}
		//toggle the mic on and off
		private function micToggle(e:MouseEvent):void
		{
			
			if(_micBtn.state == "down")
			{
				_hasMic = false;
			}else if(_micBtn.state == "up")
			{
				//if mic is installed or user didnt accept security settings
				if(Microphone.getMicrophone() && !(Microphone.getMicrophone().muted))
				{
					_micBtn.message = _configInfo.micBtn_toolTip;
					_hasMic = true;
				}else{
					_micBtn.up();
					_hasMic = false;
					_micBtn.message = "Please attach or allow your microphone to use this function";
				}
				
			}
		}
		
		//user pressed the push to talk
		private function talkBtnDown(e:MouseEvent):void
		{
			//this mute settings comes from the sharedObject, the teacher can mute other users
			if(!_isMute)
			{
				if(!(Camera.getCamera().muted) /*|| _userSO.getProperty("isMute", _configInfo.userID)*/)
				{
					//if the camera is enabled or the mic is enabled, if neither are enabled than do nothing
					if(_hasCamera || _hasMic)
					{
						//tell the stream publisher to publish the stream.
						_streamPublisher.isCamera = _hasCamera;
						_streamPublisher.isMic = _hasMic;
						//set this user id isTalking to true so all users connected will get this stream
						_userSO.setProperty("isTalking",true);
						_streamPublisher.record((_configInfo.userID).toString(), "live");
					}
				}
			}
		}
		
		//pushtotalk button is mouse up, this tells the shared object to tell all users to stop streaming this stream
		private function talkBtnUp(e:MouseEvent):void
		{
			//if the user accepted security settings
			if(!(Camera.getCamera().muted))
			{
				_userSO.setProperty("isTalking",false);
				_streamPublisher.stop();
			}
		}
		
		//when a user is disconnected and their sharedObject Slot is deleted, than check and make sure to remove their stream from the stream lists
		private function onSoDelete(e:SharedObjectEvent):void
		{
			connectToStreams(int(e.sharedObjectSlot),false);
		}
		
		//when the sharedObject is connected, loop through all slots and connect to any streams of users who are talking
		private function onSoConnected(e:SharedObjectEvent):void
		{
			var tmpData:Object = _userSO.sharedObject.data;
			
			for(var slot:String in tmpData)
			{
				connectToStreams(int(slot),tmpData[slot]["isTalking"]);
			}
		}
		
		//when the sharedObject changes, if it is "isTalking" than check and connect or disconnect from the streams, if it is this client's slot "isMute" than mute this client
		private function onSoChanged(e:SharedObjectEvent):void
		{	
			switch(e.propertyName)
			{
				
				case "isTalking":
					connectToStreams(int(e.sharedObjectSlot),e.propertyValue);
					break;
				
				case "isMute":
					if(int(e.sharedObjectSlot) == _configInfo.userID)
					{
						_isMute = e.propertyValue as Boolean;
					}
					break;
			}
		}
	}
}