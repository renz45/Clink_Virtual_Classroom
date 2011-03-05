package com.clink.main
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.events.UserListItemEvent;
	import com.clink.factories.Factory_prettyBox;
	import com.clink.factories.Factory_triangle;
	import com.clink.managers.Manager_remoteCommonSharedObject;
	import com.clink.managers.Manager_remoteUserSharedObject;
	import com.clink.ui.LayoutBox;
	import com.clink.ui.ScrollList;
	import com.clink.ui.SortingScrollList;
	import com.clink.ui.UserListButton;
	import com.clink.ui.UserListItem;
	import com.clink.utils.DrawingUtils;
	import com.clink.valueObjects.VO_Settings;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Orientation3D;
	
	import org.osmf.net.StreamingURLResource;
	import org.osmf.proxies.ListenerProxyElement;
	
	public class UserList extends Sprite
	{
		private var _configInfo:VO_Settings;
		private var _userSO:Manager_remoteUserSharedObject;
		
		private var _btnLB:LayoutBox;
		private var _mainLB:LayoutBox;
		private var _awayBtn:UserListButton;
		
		private var _originalX:Number;
		private var _originalY:Number;
		private var _breakOutBtn:Sprite;
		private var _userScrollList:SortingScrollList;
		
		private var _usernameList:Array;
		private var _listItemList:Array;
		
		private var _isHandRaised:Boolean;
		private var _isThumbUp:Boolean;
		private var _isThumbDown:Boolean;
		private var _isLaughing:Boolean;
		private var _isAway:Boolean;
		
		public function UserList(configInfo:VO_Settings, userSO:Manager_remoteUserSharedObject)
		{
			super();
			
			_configInfo = configInfo;
			_userSO = userSO;
			init();
		}
		
		private function init():void
		{
			UserListItem.init();
			
			_isHandRaised = false;
			_isThumbUp = false;
			_isThumbDown = false;
			_isLaughing = false;
			_isAway = false;
			
			_listItemList = [];
			
			_originalX = this.x;
			_originalY = this.y;
			
			UserListButton.init(_configInfo.userListButton_upStateColor,_configInfo.userListButton_downStateColor,_configInfo.userListButton_overStateColor);
			UserListButton.isGradient = _configInfo.userListButton_isGradient;
			
			
			//add event listners to the sharedObject
			_userSO.addEventListener(SharedObjectEvent.CHANGED,onSoChanged);
			_userSO.addEventListener(SharedObjectEvent.CLIENT_CHANGED,onSoChanged);
			_userSO.addEventListener(SharedObjectEvent.CONNECTED,onSoConnected);
			_userSO.addEventListener(SharedObjectEvent.DELETED,onSoDelete);
			
			drawUI();
		}
		
		private function drawUI():void
		{
			
			//draw bg
			var bg:Sprite = Factory_prettyBox.drawPrettyBox(232,206,uint(DrawingUtils.fixColorCode(_configInfo.userList_backgroundColor)),0,_configInfo.userList_backgroundIsGradient);
			this.addChild(bg);
			
			//draw header handle
			var header:Sprite = Factory_prettyBox.drawPrettyBox(232,16, uint(DrawingUtils.fixColorCode(_configInfo.userList_headerColor)),0,_configInfo.userList_headerIsGradient);
			this.addChild(header);
			
			//draw arrow button for panel breakout
			_breakOutBtn = new Sprite();
			_breakOutBtn.graphics.beginFill(uint(DrawingUtils.fixColorCode(_configInfo.userList_headerArrowColor)));
			_breakOutBtn.graphics.drawRect(0,0,7,4);
			_breakOutBtn.graphics.endFill();
			var arrowHead:Sprite = Factory_triangle.drawEqTriangle(11,5,uint(DrawingUtils.fixColorCode(_configInfo.userList_headerArrowColor)),"left",false);
			arrowHead.x = -2;
			arrowHead.y = 2;
			_breakOutBtn.addChild(arrowHead);
			
			_breakOutBtn.x = 10;
			_breakOutBtn.y = 6;
			header.addChild(_breakOutBtn);
			
			_breakOutBtn.buttonMode = true;
			_breakOutBtn.mouseChildren = false;
			_breakOutBtn.addEventListener(MouseEvent.CLICK,unDockPanel);
			
			//add and position main layout box
			_mainLB = new LayoutBox(false,6);
			_mainLB.x = 6;
			_mainLB.y = header.height+6;
			this.addChild(_mainLB);
			
			//user scroll list;
			_userScrollList = new SortingScrollList(186,177,_configInfo.userList_scrollListBackgroundColor);
			_mainLB.addChild(_userScrollList);
			
			
			
			//btn group
			_btnLB = new LayoutBox();
			
			//raiseHandButton
			var rhb:UserListButton = new UserListButton(28,28,true);
			rhb.upIcon = _configInfo.raiseHandBtn_upIcon;
			rhb.downIcon = _configInfo.raiseHandBtn_downIcon;
			rhb.overIcon = _configInfo.raiseHandBtn_overIcon;
			rhb.enableToggle();
			rhb.message = _configInfo.raiseHandBtn_toolTip;
			rhb.addEventListener(MouseEvent.CLICK,onRaiseHand);
			_btnLB.addChild(rhb);
			
			//thumbUpButton
			var tu:UserListButton = new UserListButton(28,28,true);
			tu.upIcon = _configInfo.thumbUpBtn_upIcon;
			tu.downIcon = _configInfo.thumbUpBtn_downIcon;
			tu.overIcon = _configInfo.thumbUpBtn_overIcon;
			tu.message = _configInfo.thumbUpBtn_toolTip;
			tu.addEventListener(MouseEvent.CLICK,onThumbUp);
			_btnLB.addChild(tu);
			
			//thumbDownButton
			var td:UserListButton = new UserListButton(28,28,true);
			td.upIcon = _configInfo.thumbDownBtn_upIcon;
			td.downIcon = _configInfo.thumbDownBtn_downIcon;
			td.overIcon = _configInfo.thumbDownBtn_overIcon;
			td.message = _configInfo.thumbDownBtn_toolTip;
			td.addEventListener(MouseEvent.CLICK,onThumbDown);
			_btnLB.addChild(td);
			
			//laughingButton
			var la:UserListButton = new UserListButton(28,28,true);
			la.upIcon = _configInfo.laughBtn_upIcon;
			la.downIcon = _configInfo.laughBtn_downIcon;
			la.overIcon = _configInfo.laughBtn_overIcon;
			la.message = _configInfo.laughBtn_toolTip;
			la.addEventListener(MouseEvent.CLICK,onLaugh);
			_btnLB.addChild(la);
			
			//awayButton
			_awayBtn = new UserListButton(28,28,true);
			_awayBtn.upIcon = _configInfo.awayBtn_upIcon;
			_awayBtn.downIcon = _configInfo.awayBtn_downIcon;
			_awayBtn.overIcon = _configInfo.awayBtn_overIcon;
			_awayBtn.message = _configInfo.awayBtn_toolTip;
			_awayBtn.addEventListener(MouseEvent.CLICK,onAway);
			_awayBtn.enableToggle();
			_btnLB.addChild(_awayBtn);
			
			_mainLB.addChild(_btnLB);
			
		}
		
		private function populateList(slot:int):void
		{
			var username:String = _userSO.getProperty("username",slot) as String;
			var permission:String = _userSO.getProperty("userPermission",slot) as String
			
			//remove the slot.toString() back to only username after testing is complete
			var uli:UserListItem = new UserListItem(username +slot.toString(),_configInfo,_userSO,_configInfo.userPermission,slot,true);
			
			//create the label using the username and slot number so we always have a unique label
			_userScrollList.addListItem(uli,username + slot.toString());
			
			_userScrollList.update();
		}
		
		private function findItem(slot:int):UserListItem
		{
			for each(var obj:Object in _userScrollList.items)
			{
				if(obj["item"].userID == slot)
				{
					return obj["item"];
					break;
				}
			}
			
			for each(var item:UserListItem in _userScrollList.topItems)
			{
				if(item.userID == slot)
				{
					return item;
					break;
				}
			}
			
			return null;
		}
		
		private function removeFromSort(slot:String):void
		{
			for(var i:int = 0; i < _userScrollList.items.length; i++)
			{
				if(_userScrollList.items[i]["item"].userID == slot)
				{
					_userScrollList.removeListItem(_userScrollList.items[i]["item"],_userScrollList.items[i]["label"]);
					break;
				}
			}
			_userScrollList.update();
		}
		
		private function removeFromTop(slot:String):void
		{
			for each(var k:UserListItem in _userScrollList.topItems)
			{
				if(k.userID == int(slot))
				{
					_userScrollList.removeTopItem(k);
				}
			}
			_userScrollList.update();
		}
		
		private function raiseHandOrganize(slot:String):void
		{
			var handRaisedItem:UserListItem = findItem(int(slot))
			handRaisedItem.raiseHandEnable();
			removeFromSort(slot);
			
			_userScrollList.addTopItem(handRaisedItem);
			_userScrollList.update();
		}
		
		//////////////////////////CallBacks////////////////////////////
		
		//thumbDown button pressed
		private function onLaugh(e:MouseEvent):void
		{
			_isAway = false;
			_awayBtn.up();
			
			if(_isLaughing == false)
			{
				_userSO.setProperty("isLaughing",true);
			}
		}
		
		//thumbDown button pressed
		private function onThumbDown(e:MouseEvent):void
		{
			_isAway = false;
			_awayBtn.up();
			
			if(_isThumbDown == false)
			{
				_userSO.setProperty("isThumbDown",true);
			}
		}
		
		//thumbUp button pressed
		private function onThumbUp(e:MouseEvent):void
		{
			_isAway = false;
			_awayBtn.up();
			
			if(_isThumbUp == false)
			{
				_userSO.setProperty("isThumbUp",true);
			}
		}
		
		//raised hand button pressed
		private function onRaiseHand(e:MouseEvent):void
		{
			_isAway = false;
			_awayBtn.up();
			
			if(_isHandRaised)
			{
				_userSO.setProperty("isHandRaised",false);
				_isHandRaised = false;
			}else{
				_userSO.setProperty("isHandRaised",true);
				_isHandRaised = true;
			}
			
		}
		
		private function onAway(e:MouseEvent):void
		{
			if(_isAway)
			{
				_userSO.setProperty("isAway",false);
				_isAway = false;
			}else{
				_userSO.setProperty("isAway",true);
				_isAway = true;
			}
			
		}
		
		//header arrow button is clicked
		private function unDockPanel(e:MouseEvent):void
		{
			
		}
		
		private function onSoChanged(e:SharedObjectEvent):void
		{
			
			switch(e.propertyName)
			{
				case "connected":
					
					if(e.propertyValue == true && e.sharedObjectSlot != (_configInfo.userID).toString())
					{
						if(_userSO.sharedObject.data[e.sharedObjectSlot]["isHandRaised"])
						{
							raiseHandOrganize(e.sharedObjectSlot);
						}else{
							populateList(int(e.sharedObjectSlot));
						}
						
					}
					break;
				case "isHandRaised":
					if(e.propertyValue)
					{//true
						raiseHandOrganize(e.sharedObjectSlot);
						
					}else{//false
						var handDownItem:UserListItem;
						
						removeFromTop(e.sharedObjectSlot);
						
						populateList(int(e.sharedObjectSlot));
						
						findItem(int(e.sharedObjectSlot)).raiseHandDisable();
						_userScrollList.update();
					}
					break;
				case "isThumbUp":
					if(e.propertyValue)
					{//true
						_isThumbUp = true;
						findItem(int(e.sharedObjectSlot)).thumbUp(int(e.sharedObjectSlot));
					}else{//false
						_isThumbUp = false;
					}
					break;
				case "isThumbDown":
					if(e.propertyValue)
					{//true
						_isThumbDown = true;
						findItem(int(e.sharedObjectSlot)).thumbDown(int(e.sharedObjectSlot));
					}else{//false
						_isThumbDown = false;
					}
					break;
				case "isLaughing":
					if(e.propertyValue)
					{//true
						_isLaughing = true;
						findItem(int(e.sharedObjectSlot)).laugh(int(e.sharedObjectSlot));
					}else{//false
						_isLaughing = false;
					}
					break;
				case "isAway":
					if(e.propertyValue)
					{//true
						findItem(int(e.sharedObjectSlot)).awayEnable();
					}else{//false
						findItem(int(e.sharedObjectSlot)).awayDisable();
					}
					break;
				case "isTalking":
					
					findItem(int(e.sharedObjectSlot)).talking();
					
					break;
			}
		}
		
		
		private function onSoConnected(e:SharedObjectEvent):void
		{	
			var data:Object = _userSO.sharedObject.data;
			for(var k:String in data)
			{
				//add to the list
				populateList(int(k));
				
				//check if any have their hands raised
				if(data[k]["isHandRaised"] == true)
				{
					raiseHandOrganize(k);
					
				}
			}
			_userSO.setProperty("connected",true);
		}
		
		private function onSoDelete(e:SharedObjectEvent):void
		{	
			removeFromSort(e.sharedObjectSlot);
			removeFromTop(e.sharedObjectSlot);
		}
	}
}