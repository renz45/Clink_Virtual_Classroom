package com.clink.main
{
	import com.clink.base.Base_componentToolTip;
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.misc.Keys;
	import com.clink.misc.MacMouseWheelHandler;
	import com.clink.ui.LayoutBox;
	import com.clink.ui.ScrollBar;
	import com.clink.ui.ScrollBox;
	import com.clink.ui.ScrollList;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class ClinkMain extends Sprite
	{
		private var _nc:NetConnection;
		private var _serverUserID:int;
		
		private var _appURL:String;
		private var _username:String;
		
		private var _userBasedSO:Manager_remoteUserSharedObject;
		private var _commonSO:Manager_remoteCommonSharedObject;
		
		//test
		private var sb:ScrollBar;
		private var sb2:ScrollBar;
		private var _tf:TextField;
		private var _tf2:TextField;
		private var _sl:ScrollList;
		private var _sBox:ScrollBox;
		
		public function ClinkMain()
		{
			super();
			
			_appURL = "rtmp://localhost/Clink_ServerSideApp";
			_username = "Adam";
			
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void
		{
			testInit();
		}
		
		private function testInit():void
		{
			_nc = new NetConnection();
			_nc.client = this;
			_nc.connect(_appURL,_username);
			_nc.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
			
			ScrollBar.initScrollBars();
			Keys.init(this.stage);
			
			//fixes the mac mouse wheel scrolling issue
			MacMouseWheelHandler.init(this.stage);
			
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			_sl = new ScrollList(100,200,"#ffffff");
			this.addChild(_sl);
			_sl.x = 400;
			_sl.y = 130;
			
			for(var i:int = 1; i < 5; i++)
			{
				var b:Sprite = Factory_prettyBox.drawPrettyBox(70,25,0xaa3333);
				_sl.addListItem(b);
			}
			
			var btn:Sprite = Factory_prettyBox.drawPrettyBox(70,30,0x3333aa);
			this.addChild(btn);
			btn.x = 320;
			btn.y = 140;
			btn.addEventListener(MouseEvent.CLICK,testBtnClick);
			
			var btn2:Sprite = Factory_prettyBox.drawPrettyBox(70,30,0x3333aa);
			this.addChild(btn2);
			btn2.x = 320;
			btn2.y = 190;
			btn2.addEventListener(MouseEvent.CLICK,testBtn2Click);
			
			_tf2 = new TextField();
			_tf2.autoSize = TextFieldAutoSize.LEFT;
			_tf2.width = 70;
			_tf2.wordWrap = true;
			_tf2.type = TextFieldType.INPUT;
			_sl.addListItem(_tf2);
			_sl.value = 1;
			_tf2.text = "This is a text field! type in me";
			_tf2.addEventListener(Event.CHANGE,onTf2Change);
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			
			_sBox = new ScrollBox(100,100,"#ffcccc");
			this.addChild(_sBox);
			_sBox.y = 170;
			_sBox.x = 20;
			
			_sBox.addItem(Factory_prettyBox.drawPrettyBox(300,300,0x7777ff));

			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			
			//test usage for Base_componentToolTip
			Base_componentToolTip.initTooltips("#ffff99","#333333",11,400);
			
			var btt:Base_componentToolTip = new Base_componentToolTip();
			btt.message = "This is a sample tool tip for thekljadskl jklad jkadjkad jkla kljad kjl testing test of the sample tester"
			this.addChild(btt);
			btt.x = 900;
			
			btt.addChild(Factory_prettyBox.drawPrettyBox(100,100,0x333333));
			
		
			//test usage for DrawingUtils.drawPrettyBox()
			/*lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,false));
			
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,true,true,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,false,true,true));
			
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,10,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,10,false));
			
			lb.addChild(DrawingUtils.drawPrettyBox(200,100,color,10,true,true,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,100,color,10,false,true,true));*/
		}
		
		private function testBtnClick(e:MouseEvent):void
		{
			_sl.addListItem(Factory_prettyBox.drawPrettyBox(70,25,0xaa3333));
		}
		
		private function testBtn2Click(e:MouseEvent):void
		{
			_sl.removeListItem(0);
		}
		
		private function onTf2Change(e:Event):void
		{
			_sl.update();
		}
		
		private function onSbChange(e:Event):void
		{
			
			sb2.handleSize = sb.value;
		}
		
		public function setUserId(value:*):void
		{
			trace("Your user ID is:  "+value);
			_serverUserID = value;
			
			//common
			
			/*	var commonSOTemplate:Object = {file:"my_house.jpg",currentLayer:1,layerList:{1:"fred",2:"ashley",3:"teacher"}};
			_commonSO = new Manager_remoteCommonSharedObject("commonSO",commonSOTemplate,_nc);
			
			_commonSO.addEventListener(SharedObjectEvent.CONNECTED,onConnected);
			_commonSO.addEventListener(SharedObjectEvent.CHANGED,onChange);*/
			
			//userBasedSO
			/*	var userSOTemplate:Object = {name:"Adam", gender:"Male", age:26, dog:"Adley", mousePos:{x:234,y:876}};
			
			_userBasedSO = new Manager_remoteUserSharedObject(_nc,_serverUserID,"UserBasedSO",userSOTemplate);
			
			_userBasedSO.addEventListener(SharedObjectEvent.CONNECTED,onConnected);
			_userBasedSO.addEventListener(SharedObjectEvent.CHANGED,onChange);*/
			
		}
		
		/*private function onConnected(e:SharedObjectEvent):void
		{
		//var sampleProp:Object = _userBasedSO.getProperty("mousePos");
		//_userBasedSO.setProperty("dog", "zack");
		
		_commonSO.setProperty("file","myCooki.gif");
		}
		
		private function onChange(e:SharedObjectEvent):void
		{
		_commonSO.setProperty("currentLayer",4);
		}*/
		
		
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