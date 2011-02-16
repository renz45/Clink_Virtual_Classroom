package com.clink.managers
{
	import com.clink.events.SharedObjectEvent;
	import com.clink.utils.VarUtils;
	
	import flash.display.Sprite;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import flashx.textLayout.formats.FormatValue;
	
	import org.osmf.composition.SerialElement;
	
	[Event(name="connected", type="com.clink.events.SharedObjectEvent")]
	[Event(name="changed", type="com.clink.events.SharedObjectEvent")]
	[Event(name="clientChanged", type="com.clink.events.SharedObjectEvent")]
	[Event(name="deleted", type="com.clink.events.SharedObjectEvent")]
	
	public class Manager_remoteUserSharedObject extends Sprite
	{
		
		private var _nc:NetConnection;
		private var _SO:SharedObject;
		
		private var _SOTemplate:Object;
		private var _userID:int;
		private var _SOName:String;
		private var _cachedSOData:Object;
		private var _isPersistent:Boolean;
		
		/**
		 * This class manages remoteUserSharedObjects. This communicates with the Red5 server in order to dynamically create sharedObjects.
		 * These sharedObjects have slots based off of user IDs. These types of sharedObjects are used for things which only the user or 
		 * maybe one other person will be changing their slot. 
		 * 
		 * This would be perfect for something like a drawing whiteboard where all clients are watching every user in order to draw what 
		 * they draw, but each client only changes it's own slot, represented as it's user ID.
		 *
		 * @param nc:NetConnection NetConnection which has already been connected to the server
		 * @param userID:int UserID assigned by the server when the user connects for the first time
		 * @param SOName:String Name of the SO being created
		 * @param SOTemplate:Object This is the template that the SO structure will be based on. the template is a standard object ex. {name:"adam",gender:"male"}
		 */
		public function Manager_remoteUserSharedObject(nc:NetConnection, userID:int, SOName:String, SOTemplate:Object, isPersistent:Boolean = false)
		{
			
			_nc = nc;
			_userID = userID;
			_SOName = SOName;
			_SOTemplate = SOTemplate;
			_isPersistent = isPersistent;
				
			make();
			
		}
		
		//response function which handles the return value from the 'createUserBasedSO' function on the Red5 server
		private function soCreationResponder(msg:String):void
		{
			//output from the server, return msg
			trace(msg);
			
			//connect to the SO after it's created on the server side
			_SO = SharedObject.getRemote(_SOName,_nc.uri,false);
			_SO.addEventListener(SyncEvent.SYNC,OnSync);
			_SO.client = this;
			_SO.connect(_nc);
		}
		
		private function make():void
		{
			//create a new byteArray and write the template object to the byteArray
			var TemplateAMF:ByteArray = new ByteArray();
			TemplateAMF.writeObject(_SOTemplate);
			
			//set up the responder function to handle any function returns
			var r:Responder = new Responder(soCreationResponder);
			
			//the userID needs to be a string on the server side
			var userID:String = _userID.toString();
			
			//call the function 'createUserBasedSO' on the Red5 server
			_nc.call("createUserBasedSO", r, TemplateAMF, userID, _SOName, _isPersistent);
		}
		
		//sharedObject sync event callback
		private function OnSync(e:SyncEvent):void
		{
			for each(var i:Object in e.changeList)
			{
				//create a new userSharedObjectEvent to be used in the switch statements below
				var evt:SharedObjectEvent;
				switch(i.code)
				{
					//when another client changes the so
					case "change":	
						
						//I'm caching the SharedObject at certain points in order to make a comparison when a key is changed. This way I can
						//dispatch an event with the exact slot, property, and value instead of only having a slot to work with. I'm hoping this
						//makes certain aspects of code more efficiant later on, and it's much easier to work with. I'm hoping this doesn't impact
						//memory so much that it really slows down the program.
						
						//update the _cachedSOData if the slot doesn't exist in the cache
						if(!(i.name in _cachedSOData))
						{
							_cachedSOData = VarUtils.copyObject(_SO.data);
						}
						
						//designating evt as a CHANGED event
						evt = new SharedObjectEvent(SharedObjectEvent.CHANGED);
						
						//loop through the sharedObject slot - i.name and compare the values to the values in the cached SO. If the values don't match we are going
						//to assume the value is the changed value and create a custom event with properties for slot, attributeName, and attributeValue
						//we then want to update the cached sharedObject
						var data:Object =  _SO.data[i.name];
						for(var prop:String in data)
						{
							//VarUtils.compareObjects is a compare method I made to compare objects. This comparison should work no matter the datatype
							if(!VarUtils.compareObjects(data[prop], _cachedSOData[i.name][prop]))
							{
								evt.sharedObjectSlot = i.name;
								evt.attributeName = prop;
								evt.attributeValue = data[prop];
								
								_cachedSOData = VarUtils.copyObject(_SO.data);

								this.dispatchEvent(evt);
							}
						}
						
						_cachedSOData = VarUtils.copyObject(_SO.data);
						break;
					
					//when this client changes the SO
					//Instead of dispatching an event here, im dispatching at the setProperty() method instead. I'm doing this because it's easier to
					//figure out what keys and values are being changed instead of having to run more comparisons.
					case "success":
						
						break;
					
					//when SO first connects successfully, dispatch a UserSharedObjectEvent.CONNECTED event
					case "clear":
						_cachedSOData = VarUtils.copyObject(_SO.data);
						
						evt = new SharedObjectEvent(SharedObjectEvent.CONNECTED);
						this.dispatchEvent(evt);
						break;
					
					//when something gets deleted from the SO, dispatch UserSharedObjectEvent.DELETED with the deleted slot name
					case "delete":
						evt = new SharedObjectEvent(SharedObjectEvent.DELETED);
						evt.sharedObjectSlot = i.name;
						this.dispatchEvent(evt);
						break;
				}
			}
		}//end onSync
		
		///////////////////////////GETTERS/SETTERS/////////////////////////////////
		/**
		 * Getter for template object
		 *
		 * @return Object
		 */
		public function get template():Object
		{
			return _SOTemplate;
		}
		
		/**
		 * Getter for usedID 
		 *
		 * @return int
		 */
		public function get userID():int
		{
			return _userID;
		}
		
		/**
		 * Getter for the SharedObject 
		 *
		 * @return sharedObject
		 */
		public function get sharedObject():SharedObject
		{
			return _SO;
		}
		
		/**
		 * Getter for netConnection 
		 *
		 * @return NetConnection
		 */
		public function get netConnection():NetConnection
		{
			return _nc;
		}
		
		/**
		 * Getter for SharedObject Name 
		 *
		 * @return String
		 */
		public function get SOName():String
		{
			return _SOName;
		}
		
		/**
		 * Getter for property list, this returns a string with a list of comma seperated values with datatypes indicated of the properties of this shared object.
		 * ex. "dog[String], name[String], age[int]"
		 *
		 * @return int
		 */
		public function get propertyList():String
		{
			var propList:String = "";
			var count:int = 1;
			
			var objectTotal:int = 0;
			for(var key:String in _SOTemplate)
			{
				objectTotal ++;
			}
			
			for(var prop:String in _SOTemplate)
			{
				propList += prop;
				
				propList += "[" + VarUtils.getDataType(_SOTemplate[prop]) + "]";
				
				if(count < objectTotal)
				{
					propList += ", ";
				}
				count++;
			}
			
			return propList;
			
		}
		
		//////////////////////////PUBLIC METHODS////////////////////////////////
		/**
		 * Gets the value of a property within the sharedObject. The userID is an optional param, if no userID is given than an object is returned where
		 * the keys are the userID's in the object. 
		 *
		 * @param property:String name of the property within the sharedObject to read
		 * @param userID:int (Optional) userID to look at to get the property from
		 * 
		 * @return Object
		 */
		public function getProperty(property:String,userID:int = -1):Object
		{
			var data:Object = _SO.data;
			var userIDStr:String = userID.toString();
			//if a userID was given
			if(userID > -1)
			{
				//if the user ID exists in this object, if not than throw and error
				if(data[userIDStr])
				{
					//checks to make sure the property exists, if not throw an error
					if(data[userIDStr][property])
					{
						return data[userIDStr][property]
					}else{
						throw new Error("This sharedObject doesn't contain a property named " + property);
					}
				}else{
					throw new Error("The user ID: " + userIDStr + " doesn't exist within this sharedObject");
				}
			}else{
				
				var propertyList:Object = {};
				
				for(var k:String in data)
				{
					//checks to make sure the property exists in the object
					if(data[k][property])
					{
						propertyList[k] = data[k][property];
					}else{
						throw new Error("This sharedObject doesn't contain a property named " + property);
					}
				}
				return propertyList;
			}
		}
		
		/**
		 * SetProperty sets a property in the sharedObject to a given value. Since we can't create functions at runtime, I'm passing in properties and values
		 * seperately. I'm forcing a check on datatypes like a normal property so there aren't any errors in the values. 
		 *
		 * @param propertyName:String name of the property within the sharedObject to change
		 * @param propertyValue:* the value changed within the property
		 * 
		 * @return void
		 */
		public function setProperty(propertyName:String,propertyValue:*):void
		{
			var data:Object = _SO.data[_userID];
			var foundProp:Boolean = false;
			
			for(var prop:String in data)
			{
				//loop through and test if the property exists, if it does than set foundProp = true, if not then throw error
				if(prop == propertyName)
				{
					//test the datatype of the property and make sure it matches the datatype of the same property in the template,
					//if the datatypes don't match then throw an error
					//VarUtils.getDataType() is a method I wrote for getting the datatype of an object
					if(VarUtils.getDataType(data[prop]) == VarUtils.getDataType(propertyValue))
					{
						data[prop] = propertyValue;
						_SO.setProperty(_userID.toString(),data);
						_SO.setDirty(_userID.toString());
						
						//dispatch UserSharedObjectEvent.CLIENT_CHANGED with slot, attributeName, and attributeValue variables
						var evt:SharedObjectEvent = new SharedObjectEvent(SharedObjectEvent.CLIENT_CHANGED);
						evt.sharedObjectSlot = _userID.toString();
						evt.attributeName = propertyName;
						evt.attributeValue = propertyValue;
						this.dispatchEvent(evt);
						
					}else{
						throw new Error("The data type for Property: " + propertyName + " does not match the expected datatype of " + VarUtils.getDataType(data[prop]));
					}
					foundProp = true;
				}
				
			}
			
			if(!foundProp)
			{
				throw new Error("Property: " + propertyName + " was not found within this remoteUserSharedObject");
			}
		}
	}
}