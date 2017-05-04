

package org.cpntool.servercpnclient;

public class Client  {
 

    public static void main (String[] args){

    	/* start the session with the server */
    	Session session = new Session();    	
    	session.start(Integer.parseInt(args[0]));
    	
    	/* start a simulation */
    	session.evaluate("CPN'Replications.run();\n");
    	
    	/* terminate the session with the server */
    	session.terminate();
    }
}


