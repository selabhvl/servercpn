package org.cpntool.servercpnclient;

public class SimpleClient {

	public static void main(String[] args) {
		Server server = new Server(Integer.parseInt(args[0]),"localhost");
		
		if (server.connect()) {
			
			server.startSimulation();
			
			int i = 0;
			boolean stopped = false;
			
			while ((!stopped) && (i<5)) {
			
				int pressure = server.getPressure();
				System.out.println("Pressure : " + pressure);
				
				int torque = server.getTorque();
				System.out.println("Torque : " + torque);
				
				if (pressure < 0 || torque <0) {
					stopped = true;
				}
				
				// consider using Thread.sleep here in order not to poll too often
				i++;
			}
			
			if (!stopped) {
				server.stopSimulation();
			}
			
			System.out.print("Shutdown ... ");
			server.shutdown();
			System.out.println("done ");
		}
	}
}