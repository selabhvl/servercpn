package org.cpntool.servercpnclient;

public class Server implements ICPNServer {

	final static String START_SIMULATION_CMD = "STARTSIMULATION();\n";
	final static String RESET_SIMULATION_CMD = "RESETSIMULATION();\n";
	
	final static String GET_PRESSURE_MSG = "GETPRESSURE();\n";
	final static String GET_TORQUE_MSG = "GETTORQUE();\n";
	
	final static String STOP_SIMULATION_MSG = "STOP_SIMULATION();\n";
	final static String STOP_SIMULATION_RESP = "STOPPED_SIMULATION";
	
	private int port;
	private String host;
	Session session;
	
	public Server(int port, String host) {
		this.port = port;
		this.host = host;
	}

	// connect to the server
	public boolean connect() {
    	this.session = new Session();    	
    	return session.start(port);
	}
	
	// TODO: we should distinguish between disconnet and shutdown
	// disconnect from the server
	public void disconnect() {
    	session.terminate();
	}

	// shutdown server
	public void shutdown() {
		session.terminate();
	}

	public void startSimulation() {
		session.evaluate(START_SIMULATION_CMD);
	}

	public String stopSimulation() {
		return session.evaluateWait(STOP_SIMULATION_MSG);
	}

	public void resetSimulation() {
		session.evaluate(RESET_SIMULATION_CMD);
	}

	// get a value pressure  - -1 is the simulation is stopped
	private int getValue(String value) {
		String response = session.evaluateWait(value);
		
		if (response.equals(STOP_SIMULATION_RESP)) {
			return -1;
		} else 
		{
			return Integer.parseInt(response);
		}
	}
	
	public int getPressure() {
		return getValue(GET_PRESSURE_MSG);
	}
	
	// get torque -1 is simulation stopped
	public int getTorque() {
		return getValue(GET_TORQUE_MSG);
	}

}
