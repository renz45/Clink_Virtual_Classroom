package org.red5.core;

/*
 * This is the server side code for clink the virtual classroom. I'm creating userID based sharedObjects on the server
 * side and keeping track of them. When a user leaves/disconnects their slots are removed from all userID based sharedObjects.
 * 
 * 
 * by Adam Rensel for the virtual classroom Clink
 * 
 */

import java.util.ArrayList;

import org.red5.io.amf3.ByteArray;
import org.red5.io.utils.ObjectMap;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.so.ISharedObject;


public class Application extends ApplicationAdapter {
	
	private ArrayList<ISharedObject> _userSOList;
	private ArrayList<ISharedObject> _commonSOList;
	private ArrayList<String> _connectedUserList;
	private IScope _scope;
	
	public boolean appStart(IScope scope) {

		System.out.println("[Clink][AppStart] Clink - ServerSide App start");
		
		_scope = scope;
		_userSOList = new ArrayList<ISharedObject>();
		_commonSOList = new ArrayList<ISharedObject>();
		_connectedUserList = new ArrayList<String>();
		
		return true;
	}
	
	//creates sharedObjects based on an object template, userID and a sharedObject name
	//This method is called from the client side where the template object is encoded into a byteArray
	public String createUserBasedSO(ByteArray template, String userID, String SOName, Boolean isPersistent)
	{
		String msg = "";
		
		System.out.println("[Clink Server][User Base SO] starting the user based SO creation process");

		//test if an SharedObject with the name of SOName already exists, if not a new SharedObject is created
		if(!getSharedObjectNames(_scope).contains(SOName))
		{
			System.out.println("[Clink Server][User Base SO] creating a new userID based SO for " + userID + " with the name of "+ SOName);
			
			createSharedObject(_scope, SOName, isPersistent);
			
			//push the new shared object into the userSoList, this list is used to keep track of all sharedObjects that use
			//the userID as a slot key. This is used at the disconnect(IConnection conn, IScope scope) to remove slots when
			//a user gets disconnected.
			_userSOList.add(_userSOList.size(), getSharedObject(_scope, SOName));
			
			//building return msg which gets sent to the response handler client side, this indicates a new sharedObject was created.
			msg = "user based Shared Object created with name: " + SOName + " and";
		}
		
		//pull up the named SO and give it a temporary variable
		System.out.println("[Clink Server][User Base SO] loading template for user: " + userID + " into the user based SO -> "+ SOName);
		ISharedObject SO = getSharedObject(_scope, SOName);
		
		//create a new blank object 'soTemplate' then read the AMF byteArray into the new object.
		Object soTemplate = template.readObject();
		
		//set the new object to a slot represented by the userID
		SO.setAttribute(userID, soTemplate);
		
		//update the return msg
		msg += " Slot: "+ userID + " was created in the user based sharedObject: "+ SOName;
		
		return msg;
	}//end createUserBasedSO
	
	@SuppressWarnings("unchecked")
	public String createCommonSO(ByteArray template, String SOName, Boolean isPersistent)
	{
		String msg = "";
		
		System.out.println("[Clink Server][Common SO] starting the Common SO creation process");

		//test if an SharedObject with the name of SOName already exists, if not a new SharedObject is created
		if(!getSharedObjectNames(_scope).contains(SOName))
		{
			System.out.println("[Clink Server][Common SO] creating a new common SO with the name of "+ SOName);
			
			createSharedObject(_scope, SOName, isPersistent);
			
			ISharedObject SO = getSharedObject(_scope, SOName);
			_commonSOList.add(_commonSOList.size(), SO);
		
			//pull up the named SO and give it a temporary variable
			System.out.println("[Clink Server][Common SO] loading template into thecommon SO -> "+ SOName);
			
			
			//create a new blank object 'soTemplate' then read the AMF byteArray into the new object, cast that object as an ObjectMap so we can work with it
			ObjectMap<String, Object> soTemplate = (ObjectMap<String, Object>)template.readObject();
			
			//pull out the keys of the object map and store them as an array
			Object[] keyList = soTemplate.keySet().toArray();
			
			//loop through key list and build a common SO where the slots are the property names
			for(int i = 0; i < keyList.length; i++)
			{	
				SO.setAttribute(keyList[i].toString(), soTemplate.get(keyList[i]));
			}
			
	
			//update the return msg
			msg += "common sharedObject: "+ SOName + " was created";
		}else{
			System.out.println("[Clink Server][Common SO] A common shared Object with the name "+SOName+" already exists and is ready to connect");
			msg = "Common sharedObject with name: " + SOName + " already exists, it's ready to read/change";
		}
		return msg;
	}//end createCommonSO
	
	//changed a common sharedObjects value for given propertyName to given propertyValue
	public String updateCommonSO(String propertyName, Object propertyValue, String SOName)
	{
		System.out.println(" ");
		System.out.println("[Clink][UpdateCommonSO] changing the property: "+propertyName + " to the value:" + propertyValue);
		
		ISharedObject SO = getSharedObject(_scope, SOName);
		SO.setAttribute(propertyName, propertyValue);
		
		return "Property: '" + propertyName + "' Changed to value: " + propertyValue + " in Common SharedObject " + SOName ;
	}
	
	/** {@inheritDoc} */
    @Override
	public boolean connect(IConnection conn, IScope scope, Object[] params) {
    	//reject the user if no username is given
    	if(params ==null || params.length ==0)
    	{
    		rejectClient("No username given");
    	}
    	
    	//call the original method of the parent class
    	if(!super.connect(conn, scope, params))
    	{
    		return false;
    	}
    	
    	System.out.println(" ");
 
    	//pull out the username from the params, get the userID from the client
		String username = params[0].toString();
		String uid = conn.getClient().getId();
		
		//add user id to the connectedUserList to keep track of users serverside
		_connectedUserList.add(uid);
		
    	System.out.println("[Clink Server][Connect] sending the client with userId of: "+uid+ " and username: "+username+" the userId assigned by the server");
    	
    	//this calls a method 'setUserId' on the client side when the client connects and gives the client the userId assigned by the server
    	ServiceUtils.invokeOnConnection(conn, "setUserId", new Object[]{uid});
    	
    	System.out.println("[Clink Server][Connect] There are " + _connectedUserList.size() +" users now connected to the server");
    	
		return true;
	}

    
	/** {@inheritDoc} */
    @Override
	public void disconnect(IConnection conn, IScope scope) {
		super.disconnect(conn, scope);
		
		System.out.println(" ");
		
		//pulls the user id from the connection that was disconnected
		String uid = conn.getClient().getId();
		System.out.println("[Clink Server][Disconnect] User with ID:" + uid + " has disconnected from the server");
		
		//loop through _connectedUserList and remove the user id who disconnected
		int k = 0;
		while(k < _connectedUserList.size())
		{
			if(_connectedUserList.get(k) == uid)
			{
				_connectedUserList.remove(k);
			}
			
			k++;
		}
		if(_userSOList.size() > 0)
		{
			System.out.println("[Clink Server][Disconnect] Removing the user with ID of "+uid+" from the following SharedObjects:");
		}
		//loop through the userSOList and remove all slots represented by the user who disconnected
		int i = 0;
		
		while(i < _userSOList.size())
		{
			System.out.println("[Clink Server][Disconnect] "+_userSOList.get(i).getName());
			_userSOList.get(i).removeAttribute(uid);
			
			//if there are no users in the SO than close the SO and remove it from the sharedObject list
			if(_userSOList.get(i).getAttributeNames().isEmpty())
			{
				System.out.println("[Clink Server][Disconnect] closing " + _userSOList.get(i).getName()+ " and removing it from the sharedObject List");
				_userSOList.get(i).close();
				_userSOList.remove(i);
			}
			i++;
		}
		
		/*if the _connectedUserList array is empty, this indicates that there are no long any users who are connected. If no users are connected
		 * then we want to close all sharedObjects in the _commonSOList, and remove them from the list */
		System.out.println("[Clink Server][Disconnect] There are " + _connectedUserList.size() +" users connected to the server");
		if(_connectedUserList.size() == 0)
		{
			
			System.out.println("[Clink Server][Disconnect] Closing and removing the following common sharedObjects from the _commonSOList:");
			int j = 0;
			while(j < _commonSOList.size())
			{
				System.out.println("[Clink Server][Disconnect] "+_commonSOList.get(j).getName());
				_commonSOList.get(j).close();
				_commonSOList.remove(j);
				
				j++;
			}
		}
		
		
	}

}
