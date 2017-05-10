(* --- 

   FILE: session.sml

   DESCRIPTION: Implementation of SML Session module. 

   CREATED: 24/04/2014

   --- *)

structure Session (* : SESSION *) = 
struct
    
    val defaultport = 5000;
    val connectionname = "client"

    val VERSION = "0.1";
    val OK = "OK";
    val NOK = "NOK";

    exception sessionendExn;
    exception terminateExn;

    val currentport = ref 0

    fun usestring commands = 
	Compiler.Interact.useStream (TextIO.openString (String.concat commands))

    fun getDefaultport () = defaultport;

    fun client() = connectionname

    fun send message = 
        (Log.writelog ("Sending message :\n"^message^"\n");
	ConnManagementLayer.send (client(),message,stringEncode))


    fun receive message = 
        let
	     val message = ConnManagementLayer.receive(client(),stringDecode)
	     val _ = Log.writelog ("receiving message :\n"^message^"\n")
	 in
	     message
	 end;

    fun canreceive () = 
	(Log.writelog ("Session poll :\n");
	 ConnManagementLayer.canreceive (client()));

    fun startSession () = () 
    fun endSession () = (Log.writelog ("endSession called\n"); raise sessionendExn);

    fun terminate () = (Log.writelog ("terminateSession called\n"); raise terminateExn);

    fun processrequests () = 
        ((let
             (* --- read the next request --- *)
             val request = 
                 ConnManagementLayer.receive (client(),
                                              stringDecode)
                 
             (* --- process the request ---- *)
             val _ = Log.writelog ("Processing request:\n"^request^"\n");
             val _ = ConnManagementLayer.send (client(),OK,stringEncode);
             val _ = usestring ([request]);
         in
             processrequests () 
         end)

        handle exn => 
                ((* --- terminate the server --- *)
               	 Log.writelog ("Exception processing request: "^(exnName exn)^" .\n");
                 Log.writelog ("CPN server terminating.\n"); 
                 ConnManagementLayer.closeConnection (client())))

(*
        handle terminateExn => 
                ((* --- terminate the server --- *)
                 Log.writelog ("CPN server terminated.\n");
                 ConnManagementLayer.closeConnection (client()))
             | sessionendExn =>
                ((* --- terminate the session/connection --- *)
                 Log.writelog ("CPN server session terminated.\n");
                 ConnManagementLayer.closeConnection (client());
                (* DeleteOccGraph ();*)
                 run (!currentport)) 
             | otherexn => 
               (Log.writelog ("Exception raised: "^(exnName otherexn)^" .\n");
                ConnManagementLayer.send (client(),NOK,stringEncode);
                processrequests ()))
                                                                      
*)

    and run port =
        let
            (* --- wait for incoming connection --- *)  
            val _ = Log.writelog 
                        ("The CPN server started on this port: "^Int.toString port^"\n")
                         (*(makestring port)^".\n")      *)
            val _ = print ("SERVERREADY\n")
                
            val _ = (currentport := port);
        
            val _ = ConnManagementLayer.acceptConnection (client(),port);
                
            (* --- establish connection --- *)
            val _ = Log.writelog ("Incoming connection established.\n")

            val _ = ConnManagementLayer.send(client(),VERSION,stringEncode);
        in  
            processrequests ()
        end;
end;
