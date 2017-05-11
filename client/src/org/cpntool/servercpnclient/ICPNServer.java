package org.cpntool.servercpnclient;

public interface ICPNServer {

	// connect to the server
	public boolean connect();
	
	public void disconnect();

	// shutdown server
	public void shutdown();

	public void startSimulation();
	
	public String stopSimulation();

	public void resetSimulation();

	public int getPressure();
	
	public int getTorque();

}
