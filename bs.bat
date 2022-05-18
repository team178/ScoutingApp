::  BS (Build Script)
::  Yes, a very creative name
::  A build script to make running, debugging, and building
::  this project easier.

@echo off

:: Checking if dart and flutter are installed and accessable via command line
where /q dart || ECHO Could not find dart. Check to make sure it's installed and accessable via the command line. && EXIT /B
where /q flutter || ECHO Could not find flutter. Check to make sure it's installed and accessable via the command line. && EXIT /B

set action=%1
set target=%2

set ARGS=
shift
:loop1
if "%1"=="" goto after_loop
set ARGS=%ARGS% %2
shift
goto loop1

:after_loop

if "%action%" == "run" (
    if "%target%" == "server" (
        dart pub get
        dart run lib/server.dart%ARGS%
        exit 0
    )
    if "%target%" == "app" (
        flutter pub get
        flutter run%ARGS%
        exit 0
    )
    echo Invalid target
    echo Usage: ./bs run <app|server> [args]
    exit 1
)
if "%action%" == "build" (
    if "%target%" == "server" (
        dart pub get
        dart compile exe lib/server.dart
        if not exist "build/server" (mkdir "build/server" 2>nul)
        move /y "lib/server.exe" "build/server" 2>nul
        echo Build complete. 'lib/server.exe' moved to 'build/server'. 
        exit 0
    )
    if "%target%" == "app" (
        flutter pub get
        flutter build apk
        exit 0
    )
    echo Invalid target
    echo Usage: ./bs build <app|server>
    exit 1
)
echo Invalid action
echo Usage: ./bs <run|build> <app|server> [args]
exit 1