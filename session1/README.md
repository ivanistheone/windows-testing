
Reproducing USB-cannot be removed bug #1818.2
=============================================

Setup:

  - Install kolibir on Win10
  - Bring channel on USB drive
  - Import from USB
  - Process completes successfully

Bug: Source remains locked so drive cannot be removed


Expected: eject USB to work
Actual: cannot remove drive bcs drive is in use


See logs for instrumented veriosn with lots print statements around tasks:


Thread counts change by 7.

