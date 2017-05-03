

package org.cpntool.servercpnclient;

public class Client  {
 

    public static void main (String[] args){

    	/* start the session with the server */
    	Session session = new Session();    	
    	session.start(Integer.parseInt(args[0]));
    	
    	/* setup the configuration to be simulated */
    	Config config = new Config(2,2);
    	session.evaluate(config.getConfigStr());
    	
    	/* run the simulation and get a results */
    	session.evaluate("CPN'Replications.nreplications 10;\n");
    	
    	String str = session.evaluateWait("ConnManagementLayer.send(\"client\",Real.toString (RTT_client_1.avrg ()),stringEncode);\n");
    	System.out.println("Received result: " + str);
    	
    	session.terminate();
    }
}


