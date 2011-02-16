package
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class Final_Project_Clink extends Sprite
	{
		private var _nc:NetConnection;
		private var _serverUserID:int;
		
		private var _appURL:String;
		private var _username:String;
		
		private var _userBasedSO:Manager_remoteUserSharedObject;
		private var _commonSO:Manager_remoteCommonSharedObject;
		
		public function Final_Project_Clink()
		{
			_appURL = "rtmp://localhost/Clink_ServerSideApp";
			_username = "Adam";
			
			testInit();
		}
		
		private function testInit():void
		{
			_nc = new NetConnection();
			_nc.client = this;
			_nc.connect(_appURL,_username);
			_nc.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
		}
		
		public function setUserId(value:*):void
		{
			trace("Your user ID is:  "+value);
			_serverUserID = value;
			
			//common
			
			var commonSOTemplate:Object = {file:"my_house.jpg",currentLayer:1,layerList:{1:"fred",2:"ashley",3:"teacher"}};
			_commonSO = new Manager_remoteCommonSharedObject("commonSO",commonSOTemplate,_nc);
			
			//userBasedSO
		/*	var userSOTemplate:Object = {name:"Adam", gender:"Male", age:26, dog:"Adley", mousePos:{x:234,y:876}};
			
			_userBasedSO = new Manager_remoteUserSharedObject(_nc,_serverUserID,"UserBasedSO",userSOTemplate);
			
			_userBasedSO.addEventListener(SharedObjectEvent.CONNECTED,onConnected);
			_userBasedSO.addEventListener(SharedObjectEvent.CHANGED,onChange);*/
			
		}
		
		private function onConnected(e:SharedObjectEvent):void
		{
			var sampleProp:Object = _userBasedSO.getProperty("mousePos");
			_userBasedSO.setProperty("dog", "zack");
		}
		
		private function onChange(e:SharedObjectEvent):void
		{
			
		}
		
		
		/////////////////////////////////////////////////////////
		public function onBWDone():void
		{
			
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			trace(e.info.code);
			if(e.info.code == "NetConnection.Connect.Success")
			{
				//setUpApplication();
			}
			
			if(e.info.code == "NetConnection.Connect.Failed")
			{
				trace("connection failed!!");
			}
		}
	}
}