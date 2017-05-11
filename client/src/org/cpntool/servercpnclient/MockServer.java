package org.cpntool.servercpnclient;

public class MockServer implements ICPNServer {

	private int pressure = 0;
	private int torque = 0;
	
	public MockServer (int port, String host) {
		super();
	}
	
	public boolean connect() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public void disconnect() {
		// TODO Auto-generated method stub

	}

	@Override
	public void shutdown() {
		// TODO Auto-generated method stub

	}

	@Override
	public void startSimulation() {
		// TODO Auto-generated method stub

	}

	@Override
	public String stopSimulation() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void resetSimulation() {
		// TODO Auto-generated method stub

	}

	@Override
	public int getPressure() {
		if (pressure > 500) {
			pressure = 0;
		} else pressure++;
		
		return pressure;
	}

	@Override
	public int getTorque() {
		if (torque > 500) {
			torque = 0;
		} else torque++;

		return torque;
	}

}
