package org.cpntool.servercpnclient;

public class Server {

	private int port;
	private String host;
	Session session;
	
	public Server(int port, String host) {
		this.port = port;
		this.host = host;
	}

	// connect to the server
	public boolean connect() {
    	Session session = new Session();    	
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
		
	}

	public void stopSimulation() {

	}

	public void resetSimulation() {

	}

	// get pressure
	public void getPressure() {

	}

	// get torque
	public void getTorque() {

	}

}
