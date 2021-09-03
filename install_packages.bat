@echo off

set fileName=customPythonPath.txt
set reqFileName=requirements.txt

if not exist %filename% (
	echo "Please run create_customPythonPath.bat first"
	pause
	exit
)

if not exist %reqFileName% (
	echo "Please download and place %reqFileName% in this folder"
	pause
	exit
)

@REM read the first line of the text file.
set /p pythonPath=<%fileName%
if not exist %pythonPath% (
	echo "The first line of %fileName% is not a valid path: %pythonPath%"
	pause
	exit
)

echo "Installing packages for %pythonPath%"
%pythonPath% -m pip install -r %reqFileName%

echo.&pause&goto:eof