# FortranPythonParallelIOTest
A test environment to examine different approaches to remote process calls (RPC)/messaging between fortran and python.

# Runtime prerequisites
Make sure you create 2 named pipes in the directory of the project, to form the communication channels needed. Write access to the directory is also needed to support the locking mechaniosm.
  mkfifo fortrandata
  mkfifo pythondata
  
