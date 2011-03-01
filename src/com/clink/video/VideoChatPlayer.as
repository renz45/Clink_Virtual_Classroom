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
	 * This videoChatPlayer class is used to establish a connection to a media server and stream video.  It has the capability to just stream a video, or to
	 * publish live and recorded video.
	 * 
	 */
	public class VideoChatPlayer extends Sprite
	{
		
		private var _nc:NetConnection;
		private var _ns:NetStream;
		private var _vp:Video;
		private var _st:SoundTransform;
		
		//properties
		private var _streamName:String;
		private var _volume:Number;
		private var _bufferTime:int;
		private var _cameraOn:Boolean;
		private var _micOn:Boolean
		private var _isMute:Boolean;
		
		private var _vpWidth:Number;
		private var _vpHeight:Number;
		/**
		 * Creates a videoChatPlayer object. This method requires a NetConnection for which to connect netStreams through
		 * @param appURL address of the server.
		 */
		public function VideoChatPlayer(netConnection:NetConnection)
		{
			super();
			_nc = netConnection;
			init();
		}//end constructor
		
		private function init():void
		{
			_vpHeight = this.height;
			_vpWidth = this.width;
			
			_isMute = false;
			_volume = 1;
			
			_cameraOn = true;
			_micOn = true;
			
			if(!_nc.connected)
			{
				_nc.addEventListener(NetStatusEvent.NET_STATUS,ncStatus);
			}else{
				setupNS();
			}
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
			if(_isMute)
			{
				_st = new SoundTransform(0);
			}else{
				_st = new SoundTransform(_volume);
			}
			
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
				_ns.attachCamera(null);
				_ns.attachAudio(null);
				
				if(_vp && this.contains(_vp))
				{
					this.removeChild(_vp);
					_vp.attachCamera(null);
					_vp = null;
				}//end if
				
				_vp = new Video();
				_vp.attachNetStream(_ns);
				_vp.width = _vpWidth;
				_vp.height = _vpHeight;
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
				_ns.attachCamera(null);
				_ns.attachAudio(null);
				if(_vp)
				{
					_vp.attachCamera(null);
					_vp.clear();
					_vp = null;
				}
				while(this.numChildren > 0)
				{
					this.removeChildAt(0);
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
				_ns.close();
				_ns.attachCamera(null);
				_ns.attachAudio(null);
				//attach camera if camera is enabled
				if(_cameraOn)
				{
					_ns.attachCamera(Camera.getCamera());
				}else{
					_ns.attachCamera(null);
				}
				
				//attach mic if mic is enabled
				if(_micOn)
				{
					_ns.attachAudio(Microphone.getMicrophone());
				}else{
					_ns.attachAudio(null);
				}
			
				// if there is no mic or camera, don't bother to publish
				if(_micOn || _cameraOn)
				{
					_ns.publish(streamName,type);
				}
			}
		}//end record

		//**********************GETTERS/SETTERS******************//
		
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
		
		public function get time():Number
		{
			if(_ns)
			{
				return _ns.time;
			}else{
				return 0;
			}
		}
		
		public function set netConnection(netConnection:NetConnection):void
		{
			_nc = netConnection;
		}
		public function get netConnection():NetConnection
		{
			return _nc;
		}
		
		public function set isMic(value:Boolean):void
		{
			_micOn = value;
		}
		
		public function get isMic():Boolean
		{
			return _micOn;
		}
		
		public function set isCamera(value:Boolean):void
		{
			_cameraOn = value;
		}
		
		public function get isCamera():Boolean
		{
			return _cameraOn;
		}
		
		public function set isMute(value:Boolean):void
		{
			_isMute = value;
			setVolume();
		}
		
		public function get isMute():Boolean
		{
			return _isMute;
		}
		
		override public function set width(value:Number):void
		{
			_vpWidth = value;
		}
		
		override public function set height(value:Number):void
		{
			_vpHeight = value;
		}
		
		
		
	}
}