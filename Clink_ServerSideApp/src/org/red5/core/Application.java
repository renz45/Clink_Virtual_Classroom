package org.red5.core;

/*
 * This is some simple server side code for Red5. I'm only keeping track of the usersSO server side, this is because
 * I need to keep track of users when they connect or disconnect. By removing a user from the usersSO it will trigger
 * a delete code on the sync event. I can then take this delete code and remove the other slots in various SOs that 
 * represent userIDs. 
 * 
 * 
 * Modified by Adam Rensel for the virtual classroom Clink
 * 
 */

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.red5.io.amf3.ByteArray;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.so.ISharedObject;
import org.red5.server.so.SharedObject;

import com.sun.tools.javac.code.Attribute.Array;


public class Application extends ApplicationAdapter {

	private ISharedObject _soUsers;
	
	private ArrayList<String> SONameList;
	private IScope _scope;
	
	public boolean appStart(IScope scope) {

		_scope = scope;
		SONameList = new ArrayList<String>();
		
		return true;
	}
	
	public String createUserBasedSO(ByteArray template, String userID, String SOName)
	{
		String msg = "";
		
		System.out.println("********************starting the SO creation process*********************");
		
		//test to see if the SO name given is in the current SONameList, if it's not than a new SO is created
		if(SONameList.contains(SOName) == false)
		{
			System.out.println("********************creating a new SO for " + userID + " with the name of "+ SOName +"*********************");
			SONameList.add(SONameList.size(), SOName);
			
			createSharedObject(_scope, SOName, false);
			
			//building return msg, this indicates a new sharedObject was created.
			msg = "Shared Object created with name: " + SOName + " ";
		}
		
		//pull up the named SO and give it a temporary variable
		System.out.println("********************loading template for user: " + userID + " into the SO -> "+ SOName +"*********************");
		ISharedObject SO = getSharedObject(_scope, SOName);
		
		//create a new blank object 'soTemplate' read the AMF byteArray into the new object.
		Object soTemplate = template.readObject();	
		//set the new object to a slot represented by the userID
		SO.setAttribute(userID, soTemplate);
		
		//upadte the return msg
		msg += " Slot: "+ userID + " was created in the sharedObject: "+ SOName;
		
		return msg;
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
    	
    	//create non-persistent shared object usersSO	
    	createSharedObject(scope, "usersSO", false);
    	_soUsers = getSharedObject(scope, "usersSO", false);
    	
    	
    	//parms is coming from the constructor, there should only be one from the client and it should be a string
    	//ex.  _nc.connect("rtmp://129.168.1.2/app","myUserName");
    	String username = params[0].toString();
    	String uid = conn.getClient().getId();
    	
    	//checks to see if the user already exists in the _soUsers, if they don't than they are added.
    	//This prevents this bottom code from running every time a client side SO connects to the server.
    	if(!_soUsers.hasAttribute(uid))
    	{
	    	//these System.out.println() are used as trace statements that output to the console.
	    	System.out.println("*********userId: "+uid+" with a username of:"+username+" has connected to Red5*********");
	    	
	    	//java way of creating a structure similar to an assoc array, contains information for the _soUsers
	    	//this hash map holds all the information needed for a user.
	    	HashMap<String, String> usersParamsList = new HashMap<String, String>();
	    	usersParamsList.put("userPermission", "student");
	    	usersParamsList.put("username", username);
	    	usersParamsList.put("isHidden", "false");
	    	usersParamsList.put("isMute", "false");
	    	usersParamsList.put("isPresenter", "false");
	    	usersParamsList.put("isHandRaised", "false");
	    	usersParamsList.put("isThumbUp", "false");
	    	usersParamsList.put("isThumbDown", "false");
	    	usersParamsList.put("isLaughing", "false");
	    	usersParamsList.put("isAway", "false");
	    	usersParamsList.put("isTalking", "false");
	    	usersParamsList.put("isCameraOn", "false");
	    	usersParamsList.put("isMicOn", "false");
	    	usersParamsList.put("monitorVideo", username + uid);
	    	usersParamsList.put("userId", uid);
	    	//moderator boots from the class
	    	usersParamsList.put("disconnect", "false");
	    	
	    	//you have to go into the server and manually delete this object before you compile or the client will
	    	//get connection errors for what seems like no reason (this is only true for persistent objects)
	
	    	//using the userID as the slot name, we store the list of values to that slot with setAttribute()
	    	//This is similar to setProperty() in AS3
	    	_soUsers.setAttribute(uid, usersParamsList);
	
	    	System.out.println("*********sending the client with userId of: "+uid+ " and username: "+username+" the userId assigned by the server*********");
	    	
	    	//this calls a method-setUserId on the client side when the client connects and gives the client the userId assigned by the server
	    	ServiceUtils.invokeOnConnection(conn, "setUserId", new Object[]{uid});
    	}
		return true;
	}

	/** {@inheritDoc} */
    @Override
	public void disconnect(IConnection conn, IScope scope) {
		super.disconnect(conn, scope);
		
		//TODO Loop throught the SONameList and remove users who disconnect.
		
		//pulls the user id from the connection who disconnected
		String uid = conn.getClient().getId();
		
		//removes the user from the sharedObject and notifies the clients. Triggers a sync event delete code
		_soUsers.removeAttribute(uid);
		
		System.out.println("*********user: "+uid+" has disconnected from Red5*********");
		
		System.out.println("*********Names within the SO"+_soUsers.getAttributeNames()+"*********");
		
		//if there are no more users connected than close the SO (Only really needed for persistent SOs)
		if(_soUsers.getAttributeNames().isEmpty())
		{
			System.out.println("*********closing the SO*********");
			_soUsers.close();
		}
	}

}
