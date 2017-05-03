package org.cpntool.servercpnclient;

import java.net.SocketException;

import org.cpntools.commscpn.java.*;

public class ClientProgress {

	final private static String SIMSTOP = "SIMSTOP";
	final private static String PRGVAL = "PRGVAL";

	public static void main(String[] args) {

		/* start the session with the server */
		Session session = new Session();
		session.start(Integer.parseInt(args[0]));

		/* setup the configuration to be simulated */
		Config config = new Config(2, 2);
		session.evaluate(config.getConfigStr());

		/* initialise progress reporting */
		session.evaluate("InitProgress ();\n");
		
		/* run the simulation and indicate when finished */

		session.evaluate("CPN'Replications.nreplications 10;\n; ConnManagementLayer.send(\"client\",\"SIMSTOP\",stringEncode);\n");
		
		/* read progress reports during simulation */
		JavaCPN server = session.getServer();

		String received = "";

		try {

			do {
				received = EncodeDecode.decodeString(server.receive());
				System.out.println("Progress : " + received);
			} while (received.compareTo(SIMSTOP) != 0);
		} catch (SocketException e) {
			System.err.println("Socket Exception");
		};

		/* read the performance results */
		String str = session.evaluateWait(
				"ConnManagementLayer.send(\"client\",Real.toString (RTT_client_1.avrg ()),stringEncode);\n");
		System.out.println("Received result: " + str);

		session.terminate();
	}
}
