# Run Into fetaure problems?
With programs crying about missing programs of the form

/1PAPA/FEAT400ABKRS
/1PAPA/FEAT400SCHKZ

you need to activate the feature  in PE03, feature name is the last 5 characters
so for above it's ABKRS and SCHKZ

Cause, bad client copy.


```
Category               ABAP Programming Error
Runtime Errors         LOAD_PROGRAM_NOT_FOUND
Except.                CX_SY_PROGRAM_NOT_FOUND
ABAP Program           SAPLHRP3
Application Component  PA-PA
Date and Time          21.08.2018 16:03:39



 Short Text
     Program "/1PAPA/FEAT400ABKRS" not found.



 What happened?
     There are several possibilities:

     or
     Error in the SAP kernel

     The current ABAP program "SAPLHRP3" had to be terminated because the ABAP
     processor detected a system error.



 Error analysis
     An exception has occurred which is explained in more detail below. The
     exception is assigned to class 'CX_SY_PROGRAM_NOT_FOUND' and was not caught in
      procedure
     "HR_FEATURE_BACKFIELD" "(FUNCTION)", nor was it propagated by a RAISING clause.
     Since the caller of the procedure could not have anticipated this
     exception, the current program was terminated.
     The reason for the exception is:
     On account of a branch in the program (CALL FUNCTION/DIALOG, external
     PERFORM, SUBMIT) or a transaction call, another ABAP/4 program
      ("/1PAPA/FEAT400ABKRS")
     should be be loaded.

     Program "/1PAPA/FEAT400ABKRS" is not in the library however.

     Possible causes:
     a) Wrong program name specified in an external PERFORM or SUBMIT or,
     when defining a new transaction, a new dialog module or a new function
     module. Note in particular that the program name must be written in
     uppercase.
     b) Transport error
```