val STOP_SIMULATION_MSG = "STOP_SIMULATION();\n";
val STOP_SIMULATION_RESP = "STOPPED_SIMULATION";
val GET_PRESSURE_MSG = "GETPRESSURE();\n";
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
	  then (Log.writelog("Handling stop simulation\n");
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

	   (* mock simulator that can be used for testing purposes *)
fun MockSimulator (p,t) =
  let
      val continue = checkenv (p,t)
      val p' = if p > 500 then 1 else p+1
      val t' = if t > 200 then 1 else t+1
  in
      if continue
      then MockSimulator (p',t')
      else ()
  end;

fun STARTSIMULATION () =
  ( Log.writelog ("Running simulation ...");
    (* CPN'Replications.run() *) MockSimulator(1,1);
    Log.writelog ("Done\n");
    Session.send STOP_SIMULATION_RESP); 

fun RESETSIMULATION () = (); (* NOT IMPLEMENTED YET *)

fun STOP_SIMULATION () = Session.send STOP_SIMULATION_RESP;

fun GETPRESSURE() = Session.send STOP_SIMULATION_RESP;


fun GETTORQUE() = Session.send STOP_SIMULATION_RESP;


