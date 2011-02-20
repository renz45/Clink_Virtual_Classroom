package com.clink.video
{
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * This videoPlayer class is used to establish a connection to a media server and stream video.  It has the capability to just stream a video, or to
	 * publish live and recorded video.
	 * 
	 */
	public class VideoPlayer extends Sprite
	{
		
		private var _nc:NetConnection;
		private var _ns:NetStream;
		private var _vp:Video;
		private var _st:SoundTransform;
		
		private var _duration:Number;
		
		//properties
		private var _appURL:String;
		private var _streamName:String;
		private var _volume:Number = 1;
		private var _bufferTime:int;
		/**
		 * Creates a videoPlayer object. This method requires an application URL as a string to establish a connection to.(server address)
		 * @param appURL address of the server.
		 */
		public function VideoPlayer(appURL:String,netConnection:NetConnection)
		{
			super();
			_nc = netConnection;
			_appURL = appURL;
			init();
		}//end constructor
		
		private function init():void
		{
			//_nc = new NetConnection();
			//_nc.client = this;
			_nc.connect(_appURL);
			_nc.addEventListener(NetStatusEvent.NET_STATUS,ncStatus);
			
		}//end init
		
		private function setupNS():void
		{
			_ns = new NetStream(_nc);
			_ns.client = this;
			_ns.addEventListener(NetStatusEvent.NET_STATUS,ns_statusHandler);
			
			setBufferTime();
			setVolume();
		}//end setupNS
		
		private function setVolume():void
		{
			_st = new SoundTransform(_volume,0);
			if(_ns)
			{
				_ns.soundTransform = _st;
			}
		}//end set volume
		
		private function setBufferTime():void
		{
			if(_ns)
			{
				_ns.bufferTime = _bufferTime;	
			}
		}// end bufferTime
		
		//*********************CALL BACKS ************************//
		/**
		 * method used by the media player to detect bandwidth done, Required to have it even if we arent using it
		 */
		public function onBWDone():void
		{
			
		}
		
		/**
		 * 
		 * Method used by media player to reflect certain meta data
		 */
		public function onMetaData(info:Object):void
		{
			_vp.width = info.width;
			_vp.height = info.height;
			_duration = info.duration;
		}
		
		private function ncStatus(event:NetStatusEvent):void
		{
			trace(event.info.code);
			if(event.info.code == "NetConnection.Connect.Success")
			{
				setupNS();
			}
		}//end ncStatus
		
		private function ns_statusHandler(event:NetStatusEvent):void
		{
			trace("NS1------->" + event.info.code);
		}//ns_statusHandler
		
		//************************public methods*******************//
		/**
		 * Method used to play a stream. Requires a stream/video name
		 * 
		 * $param streamName name of the stream or video.
		 */
		public function play(streamName:String):void
		{
			_streamName = streamName;
			
			if(_ns)
			{
				_ns.close();
				
				if(_vp && this.contains(_vp))
				{
					this.removeChild(_vp);
				}//end if
				
				_vp = new Video();
				_vp.attachNetStream(_ns);
	
				this.addChild(_vp);
				
				_ns.play(_streamName);
			}//end if
		}//end play
		
		/**
		 * Method used to stop video player functioning, such as record and play
		 * 
		 */
		public function stop():void
		{
			if(_ns)
			{
				_ns.close();
				_vp.clear();
				
				if(_vp && this.contains(_vp))
				{
					this.removeChild(_vp);
				}
			}//end if
		}//end stop
		
		/**
		 * Method used to start recording a stream
		 * 
		 * @param streamName name of the stream to record to
		 * @param type sets the type of stream, ex. 'live'
		 */
		public function record(streamName:String,type:String):void
		{
			if(_ns)
			{
				var camera:Camera = Camera.getCamera();
				var mic:Microphone = Microphone.getMicrophone();
				
				_ns.close();
				
				if(_vp && this.contains(_vp))
				{
					this.removeChild(_vp);
				}//end if
				
				_vp = new Video();
				_vp.attachCamera(camera);
				this.addChild(_vp);
			
				_ns.attachCamera(camera);
				_ns.attachAudio(mic);
			
				_ns.publish(streamName,type);	
			}
		}//end record
		
		/**
		 * Method that wil toggle pause on and off
		 * 
		 */
		public function togglePause():void
		{
			if(_ns)
			{
				_ns.togglePause();
			}
		}//end togglePause
		
		/**
		 * Method will skip the video to a specified percent of the total time.
		 * 
		 * @param percent percent of the total video time to skip to
		 */
		public function seek(percent:Number):void
		{
			if(_ns)
			{
				_ns.seek(_duration * percent);
			}
		}//end seek
		
		//**********************GETTERS/SETTERS******************//
		
		public function set appURL(url:String):void
		{
			_appURL = url;
		}
		public function get appURL():String
		{
			return _appURL;
		}
		
		public function set streamName(name:String):void
		{
			_streamName = name;
		}
		public function get streamName():String
		{
			return _streamName;
		}
		
		public function set volume(volume:Number):void
		{
			_volume = volume;
			setVolume();
		}
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set bufferTime(time:int):void
		{
			_bufferTime = time;
			setBufferTime();
		}
		public function get bufferTime():int
		{
			return _bufferTime;
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		public function get time():Number
		{
			if(_ns)
			{
				return _ns.time;
			}else{
				return 0;
			}
		}
		
		public function get trackPosition():Number
		{
			
			if(_ns)
			{
				return _ns.time / _duration;
			}else{
				return 0;
			}
		}
		
		public function set netConnection(netConnection):void
		{
			_nc = netConnection;
		}
		public function get netConnection():NetConnection
		{
			return _nc;
		}
	}
}