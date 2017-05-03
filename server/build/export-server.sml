(* ---
   FILE: export-server.sml

   DESCRIPTION: Implements facilities for exporting the COAST server 
                image without killing the SML runtime engine.

   CREATED: 24/04/2014               
   
   CHANGELOG:
  --- *)

(* Exports an image to a file.
 * filename: The name of the file where the image should be saved.
 * startFun: The function to be invoked when starting the saved image.*)
fun exportImage (filename, startFun) =
    (case Posix.Process.fork() of
         SOME x => () (* Parent *)
       | NONE =>      (* Child - dies after exportFN*)
             SMLofNJ.exportFn (filename, startFun));

exportImage(buildpath^"bin/cpnserver", CPNServer);
