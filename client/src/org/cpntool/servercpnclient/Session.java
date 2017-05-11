package org.cpntool.servercpnclient;

import java.io.IOException;
import java.net.SocketException;
import java.net.UnknownHostException;

import org.cpntools.commscpn.java.*;

public class Session {

	private JavaCPN server = null;

	JavaCPN getServer () {
		return server;
	}
	
	// start a session with the server
	public boolean start(int serverport) {

		String received;
		boolean connected = true;

		server = new JavaCPN();

		System.out.println("Connecting to server on port " + serverport);

		// connection to the server
		try {
			server.connect("localhost", serverport);
		} catch (UnknownHostException e) {
			System.err.println("Unknown host");
			connected = false;
		} catch (IOException e) {
			System.err.println("IO Exception");
			connected = false;
		} 

		// server will return version number in response to connect
		
		if (connected) {
		try {
			received = EncodeDecode.decodeString(server.receive());
			System.out.println("Server version number: " + received);
		} catch (SocketException e) {
			System.err.println("Socket Exception");
			connected = false;
		}
		}
		
		return connected;
	}

	// evaluate without awaiting a result
	public void evaluate(String str) {
		String received;

		try {
			System.out.print("Sending  : " + str);
			server.send(EncodeDecode.encode(str));
			received = EncodeDecode.decodeString(server.receive());
			System.out.println("Received : " + received);
		} catch (SocketException e) {

			System.err.println("evaluate - Socket Exception");

		}
	}

	// evaluate and await a result send back from the server
	public String evaluateWait(String str) {
		String received = null;
	
		try {
			server.send(EncodeDecode.encode(str));
			// read the internal ok from the server
			received = EncodeDecode.decodeString(server.receive());
			System.out.println("Received : " + received);
			// read the results expected to be sent back from the server
			received = EncodeDecode.decodeString(server.receive());
		} catch (SocketException e) {

			System.err.println("evaluatewait - Socket Exception");

		}

		return received;
	}

	// terminate the session and server
	public void terminate() {
		try {
			server.disconnect();
		} catch (IOException e) {
			System.err.println("IO Exception");
		}

	}
}
