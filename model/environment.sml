val STOP_SIMULATION_MSG = "STOP_SIMULATION();\n";
val STOP_SIMULATION_RESP = "STOPPED_SIMULATION";

fun STARTSIMULATION () = (CPN'Replications.run();
			  Session.send STOP_SIMULATION_RESP); 

fun RESETSIMULATION () = (); (* NOT IMPLEMENTED YET *)

fun STOP_SIMULATION () = Session.send STOP_SIMULATION_RESP;

fun GETPRESSURE() = Session.send STOP_SIMULATION_RESP;
val GET_PRESSURE_MSG = "GETPRESSURE();\n";

fun GETTORQUE() = Session.send STOP_SIMULATION_RESP;
val GET_TORQUE_MSG = "GETTORQUE();\n";

exception checkEnvExn of string;
fun checkenv (p,t) = 
  if Session.canreceive()
  then
      (let
	  val msg = Session.receive()
	  val _ = Log.writelog("Environment: "^msg);
	  val _ = Session.send ("OK");
	  val _ = (if (msg = "GETPRESSURE();\n")
		   then Log.writelog "MATCH\n"
		   else ());
      in
	  case msg of
	      "STOP_SIMULATION();\n" =>
	      (Log.writelog("Handling getPressure");
	       false)
	   |  "GETPRESSURE();\n" =>
	      (Log.writelog("Handling getPressure");
	       Session.send (Int.toString p);
	       true)
	   |  "GETTORQUE();\n" =>
	      (Log.writelog("Handling getTorque");
	       Session.send (Int.toString t);
	       true)
	   |  _ =>
	      (Log.writelog("checkEnvExn\n");
	       raise checkEnvExn msg)
      end)
  else true (* continue simulation *) 
