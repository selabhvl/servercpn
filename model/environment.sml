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
	  val _ = Log.writelog("Environment received: "^msg);
	  val _ = Session.send ("OK");
	  (*
	  val _ = (if (msg = "GETPRESSURE();\n")
		   then Log.writelog "MATCH\n"
		   else ());*)
      in
	  if (msg = STOP_SIMULATION_MSG)
	  then (Log.writelog("Handling Stop Simulation\n");
		Session.send STOP_SIMULATION_RESP; 
		false) (* stop simulation *)
	  else (if (msg = GET_PRESSURE_MSG)
		then (Log.writelog("Handling getPressure\n");
		      Session.send (Int.toString p);
		      true)
		else (if (msg = GET_TORQUE_MSG)
		      then (Log.writelog("Handling getTorque\n");
			    Session.send (Int.toString t);
			    true)
		      else (Log.writelog("Warning: No Match\n");
			    Session.send "0";
			    true)))
      end)
  else true (* continue simulation *)


(*	  case msg of
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
*)
