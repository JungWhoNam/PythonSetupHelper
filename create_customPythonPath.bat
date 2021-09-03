@echo off

setlocal EnableDelayedExpansion 

@REM iterate through command results 'where python'
@REM saves the results in an array pythonPaths
set pythonPaths=
set numOfPythonPaths=0
for /f %%i in ('where python') do (
	set pythonPaths[!numOfPythonPaths!]=%%i
	set /a numOfPythonPaths+=1
)
echo "There are %numOfPythonPaths% Python PATH environment variables"

@REM iterate through pythonPaths
@REM saves the versions in an array pythonVersions
set pythonVersions=
set numOfPythonVersions=0
for /l %%i in (0,1,%numOfPythonPaths%) do (
	for /f "tokens=*" %%g in ('!pythonPaths[%%i]! --version') do (
		set pythonVersions[%%i]=%%g
		set /a numOfPythonVersions+=1
	)
)
echo "There are %numOfPythonVersions% valid versions"

@REM outputs these results into the text file
set fileName=customPythonPath.txt
echo "Saving the path and version to the file: %fileName%"

@REM first create an empty file (overwrite if already exists)
type NUL > %fileName%

@REM save the path and version to the file
for /l %%i in (0,1,%numOfPythonPaths%) do (
	if defined !pythonVersions[%%i] (
		echo !pythonPaths[%%i]!>>%fileName%
		echo #!pythonVersions[%%i]!>>%fileName%
	)
)
echo "Finished. Check %fileName%"

echo.&pause&goto:eof