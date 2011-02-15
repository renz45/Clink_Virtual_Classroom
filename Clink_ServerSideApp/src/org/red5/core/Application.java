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
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.ServiceUtils;
import org.red5.server.api.so.ISharedObject;


public class Application extends ApplicationAdapter {
	
	private ArrayList<ISharedObject> userSOList;
	private IScope _scope;
	
	public boolean appStart(IScope scope) {

		System.out.println("Clink - ServerSide App start");
		
		_scope = scope;
		userSOList = new ArrayList<ISharedObject>();
		
		return true;
	}
	
	//creates sharedObjects based on an object template, userID and a sharedObject name
	//This method is called from the client side where the template object is encoded into a byteArray
	public String createUserBasedSO(ByteArray template, String userID, String SOName)
	{
		String msg = "";
		
		System.out.println("********************starting the SO creation process*********************");

		//test if an SharedObject with the name of SOName already exists, if not a new SharedObject is created
		if(!getSharedObjectNames(_scope).contains(SOName))
		{
			System.out.println("********************creating a new SO for " + userID + " with the name of "+ SOName +"*********************");
			
			createSharedObject(_scope, SOName, false);
			
			//push the new shared object into the userSoList, this list is used to keep track of all sharedObjects that use
			//the userID as a slot key. This is used at the disconnect(IConnection conn, IScope scope) to remove slots when
			//a user gets disconnected.
			userSOList.add(userSOList.size(), getSharedObject(_scope, SOName));
			
			//building return msg which gets sent to the response handler client side, this indicates a new sharedObject was created.
			msg = "Shared Object created with name: " + SOName + " and";
		}
		
		//pull up the named SO and give it a temporary variable
		System.out.println("********************loading template for user: " + userID + " into the SO -> "+ SOName +"*********************");
		ISharedObject SO = getSharedObject(_scope, SOName);
		
		//create a new blank object 'soTemplate' then read the AMF byteArray into the new object.
		Object soTemplate = template.readObject();
		
		//set the new object to a slot represented by the userID
		SO.setAttribute(userID, soTemplate);
		
		//update the return msg
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
 
    	//pull out the username from the params, get the userID from the client
		String username = params[0].toString();
		String uid = conn.getClient().getId();
    	System.out.println("*********sending the client with userId of: "+uid+ " and username: "+username+" the userId assigned by the server*********");
    	
    	//this calls a method 'setUserId' on the client side when the client connects and gives the client the userId assigned by the server
    	ServiceUtils.invokeOnConnection(conn, "setUserId", new Object[]{uid});
    	
		return true;
	}

    
	/** {@inheritDoc} */
    @Override
	public void disconnect(IConnection conn, IScope scope) {
		super.disconnect(conn, scope);
		
		//pulls the user id from the connection that was disconnected
		String uid = conn.getClient().getId();
		
		System.out.println("*********Removing the user with ID of "+uid+" from the following SharedObjects:");
		
		//loop through the userSOList and remove all slots represented by the user who disconnected
		int i = 0;
		while(i < userSOList.size())
		{
			System.out.println(userSOList.get(i).getName());
			userSOList.get(i).removeAttribute(uid);
			
			//if there are no users in the SO than close the SO and remove it from the sharedObject list
			if(userSOList.get(i).getAttributeNames().isEmpty())
			{
				System.out.println("closing " + userSOList.get(i).getName()+ " and removing it from the sharedObject List");
				userSOList.get(i).close();
				userSOList.remove(i);
			}

			i++;
		}
		
	}

}
