package com.clink.main
{
	import com.clink.base.Base_componentToolTip;
	import com.clink.events.SharedObjectEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.LayoutBox;
	import com.clink.ui.ScrollBar;
	import com.clink.utils.DrawingUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
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
			
			
			var color:uint = 0xff9999;
			
			var lb:LayoutBox = new LayoutBox();
			this.addChild(lb);
			
			ScrollBar.initScrollbars();
			sb = new ScrollBar(400,false);
			this.addChild(sb);
			sb.x = 117;
			sb.y = 100;
			
			//sb.addEventListener(Event.CHANGE,onSbChange);
			
			sb2 = new ScrollBar(100,true);
			
			sb2.x = 100;
			sb2.y = 0;
			sb2.handleSize = 1;
			sb2.value = 1;
			sb2.addEventListener(Event.CHANGE,onSb2Change);
			
			
			this.addChild(Factory_prettyBox.drawPrettyBox(110,100,0xffffff));
			
			_tf = new TextField();
			_tf.autoSize = TextFieldAutoSize.CENTER;
			_tf.wordWrap = true;
			_tf.type = TextFieldType.INPUT;
			this.addChild(_tf);
			//this.setChildIndex(sb2,this.numChildren-1);
			_tf.text = "klasd asd ada kda lad kladkaj akdj ajakd alkdjakla a ad ";
			_tf.addEventListener(Event.CHANGE,onChange);
			
			_tf.y = -Math.round((_tf.height - 100) * sb2.value);
			//test usage for Base_componentToolTip
			/*Base_componentToolTip.initTooltips("#ffff99","#333333",11,400);
			
			var btt:Base_componentToolTip = new Base_componentToolTip();
			btt.message = "This is a sample tool tip for thekljadskl jklad jkadjkad jkla kljad kjl testing test of the sample tester"
			lb.addChild(btt);
			
			lb.x = this.stage.stageWidth - 50;
			lb.y = 10;*/
		
			//test usage for DrawingUtils.drawPrettyBox()
			/*lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,false));
			
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,true,true,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,0,false,true,true));
			
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,10,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,25,color,10,false));
			
			lb.addChild(DrawingUtils.drawPrettyBox(200,100,color,10,true,true,true));
			lb.addChild(DrawingUtils.drawPrettyBox(50,100,color,10,false,true,true)); */
		}
		
		private function onChange(e:Event):void
		{
			var perc:Number = 100/_tf.height;
			if(perc > 1)
			{
				if(sb2.parent == this)
				{
					this.removeChild(sb2);
					
				}
				
				sb2.handleSize = 1;	
			}else{
				
				if(sb2.parent != this)
				{
					this.addChild(sb2);
					sb2.value = 1;
				}
				
				if(perc > .15)
				{
					sb2.handleSize = perc;
				}else{
					sb2.handleSize = .15;
				}
			}
			//_tf.y = -(_tf.height - 100)
			_tf.y = -Math.round((_tf.height - 100) * sb2.value);
			//sb2.value = 1;
			//trace(sb2.value);
			
		}
		
		private function onSbChange(e:Event):void
		{
			
			sb2.handleSize = sb.value;
		}
		
		private function onSb2Change(e:Event):void
		{
			_tf.y = -Math.round((_tf.height - 100) * sb2.value);
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