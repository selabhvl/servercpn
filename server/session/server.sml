(* --- 

 FILE: server.sml

 DESCRIPTION: Main function for the CPN server. 

 CREATED: 24/04/2014

 --- *)

fun CPNServer (_,(port::(logfile::xs))) = 
    (
     let
       val port' = (case (Int.fromString port) of
                       SOME newport => newport
                     | NONE => Session.getDefaultport ())
       val _ = Log.setLogFile logfile
       val _ = Session.run port'
     in
         OS.Process.success
     end handle _ => OS.Process.failure)
  | CPNServer _ = OS.Process.failure;
