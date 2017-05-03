(* --- 

   FILE: session-sig.sml

   DESCRIPTION: Interface for the SML Session module. 

   CREATED: 24/04/2014

   --- *)

signature SESSION = 
sig
    exception sessionendExn;
    exception terminateExn;

    (* --- start a session with the server --- *)
    val startSession : unit -> unit;

    (* --- end a session with the server --- *)
    val endSession : unit -> unit;

    (* --- default port of the server --- *)
    val getDefaultport : unit -> int;

    (* --- send message to the client --- *)
    val send : string -> unit;

    (* --- blocking receive from the client --- *)
    val receive : unit -> string;
 
    (* --- poll for messages from the client --- *)
    val canreceive : unit -> bool;

    (* --- terminate the server --- *)
    val terminate : unit -> unit;

    (* --- execute the server --- *)
    val run : int -> unit;

end;
