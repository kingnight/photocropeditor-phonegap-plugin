package com.aisino.plugin;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;


import android.content.Intent;
import android.net.Uri;
import android.util.Log;

public class Dialer extends CordovaPlugin{
	
	private static final String CALL = "call";
	public Dialer() {
    }
	 public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
	    	Log.d("key", "Dialer-########################-gggg");
 	
	        if (action.equals(CALL)) {
	        	String number = null;
				try {
					number = "tel:" + args.getString(0);
		            Intent callIntent = new Intent(Intent.ACTION_CALL, Uri.parse(number)); 
		            this.cordova.getActivity().startActivity(callIntent);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} 
	        }
	        else {
	          callbackContext.error("User did not specify data to encode");
	          return false;
	        }       
	        return true;
	    }
	    
	/* public PluginResult execute(String action, JSONArray args, String callbackId) {
		 Log.d("key", "Dialer-########################-gggg"); 
		 PluginResult.Status status = PluginResult.Status.OK;
		    String result = "";
		    try {
		        if (action.equals("call")) {
		            String number = "tel:" + args.getString(0);
		            Intent callIntent = new Intent(Intent.ACTION_CALL, Uri.parse(number)); 
		            this.cordova.getActivity().startActivity(callIntent);
		        }
		        else {
		            status = PluginResult.Status.INVALID_ACTION;
		        }
		        return new PluginResult(status, result);
		    } catch (JSONException e) {
		        return new PluginResult(PluginResult.Status.JSON_EXCEPTION);
		    }
		}
	*/	
}
