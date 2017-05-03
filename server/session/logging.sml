(* --- 

   FILE: logging.sml

   DESCRIPTION: Implements server side logging.

   CREATED: 24/04/2014

   --- *)

structure Log : LOG = 
struct

     val logfile_default = ref "/tmp/CPNServer.log"
     val logfile         = ref "/tmp/CPNServer.log"

     fun resetLogFile () = logfile := !logfile_default

     fun setLogFile new = logfile := new

     fun gettime () = Date.toString (Date.fromTimeLocal (SMLTime.now ()))

     fun writelog CPN'message =  
	 let
             val CPN'file = TextIO.openAppend (!logfile)
		 handle Win32TextPrimIO =>
			(TextIO.closeOut (TextIO.openOut (!logfile));
			 TextIO.openAppend (!logfile))
			
             val _ = TextIO.output (CPN'file,((gettime ())^": "^CPN'message))
	 in
             TextIO.closeOut CPN'file
	 end;
end;

