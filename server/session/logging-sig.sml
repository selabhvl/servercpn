(* --- 

   FILE: logging-sig.sml

   DESCRIPTION: Interface for the logging module within the 
   SML session module.

   CREATED: 25/04/2014

   --- *)

signature LOG = 
sig

    val resetLogFile : unit -> unit
    val setLogFile : string -> unit
    val writelog : string -> unit
end;
 
