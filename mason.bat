@echo off
rem This file was created by pub v3.3.3.
rem Package: mason_cli
rem Version: 0.1.0-dev.53
rem Executable: mason
rem Script: mason
if exist "C:\Users\disas\AppData\Local\Pub\Cache\global_packages\mason_cli\bin\mason.dart-3.3.3.snapshot"                                                                                                                                                                       (
  call dart "C:\Users\disas\AppData\Local\Pub\Cache\global_packages\mason_cli\bin\mason.dart-3.3.3.snapshot"                                                                                                                                                                       %*
  rem The VM exits with code 253 if the snapshot version is out-of-date.
  rem If it is, we need to delete it and run "pub global" manually.
  if not errorlevel 253 (
    goto error
  )
  call dart pub global run mason_cli:mason %*
) else (
  call dart pub global run mason_cli:mason %*
)
goto eof
:error
exit /b %errorlevel%
:eof
