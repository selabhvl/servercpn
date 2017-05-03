package org.cpntool.servercpnclient;

public class Config {

	/*
	 * a configuration currently consists of a the number of controller and the
	 * number of devices - we should introduce classes corresponding to
	 * Controllers and Devices
	 */
	private Integer controllers = 0;
	private Integer devices = 0;

	private final String CONTROLLER_STR = "m340 := [M340 ({id=1,appL=10}),M340 ({id=2,appL=10})];";
	private final String DEVICES_STR = "client := [Client ({id=1,service=messaging,PFreq=10}), Client({id=2,service=messaging,PFreq=5})];\n";

	Config(Integer controllers, Integer devices) {
		this.controllers = controllers;
		this.devices = devices;
	}

	/*
	 * return the configuration string to be submitted to the server - currently
	 * just the hard coded strings are sent - but this could be further refined
	 */
	String getConfigStr() {
		return CONTROLLER_STR + DEVICES_STR + "\n";

	}
}
