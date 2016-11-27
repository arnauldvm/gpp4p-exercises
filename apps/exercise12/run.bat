@IF "%ORG_PATH%"=="" (
	@SET "ORG_PATH=%PATH%"
)
@SET "PATH=%ORG_PATH%"
@CALL ..\setenv.bat
@SET "PATH=%~DP0\..\..\utils;%PATH%"
@SET "THISPROG=%~0"

@IF "%1"=="" (
	@ECHO Missing argument
	@CALL :usage
	@EXIT /B 1
)

@FOR /f "tokens=2 delims==" %%x IN ('WMIC OS Get localdatetime /value') DO @SET ts=%%x
@SET ts=%ts:~0,8%-%ts:~8,6%
@IF NOT EXIST target MKDIR target
@IF NOT EXIST target\profiles MKDIR target\profiles
@SET "prof_file=target/profiles/profile-%ts%.txt"
@SET "out_file=%prof_file%"

@IF "%1"=="r" (
	GOTO ARGS_OK
)

@IF "%1"=="c" (
	@SET "prof_opt=-XX:+PrintCompilation"
	GOTO ARGS_OK
)

@IF "%1"=="X" (
	@SET "prof_opt=-Xprof"
	GOTO ARGS_OK
)

@IF "%1"=="h" (
	@SET "out_file=target/profiles/out-%ts%.txt"

	@SET "prof_opt=-agentlib:hprof=cpu=samples,file=%prof_file%"
	::@SET "prof_opt=-agentlib:hprof=cpu=samples,depth=20,interval=1,file=%prof_file%" :: deeper
	::@SET "prof_opt=-agentlib:hprof=cpu=times,file=%prof_file%" :: Very slow!
	GOTO ARGS_OK
)

@ECHO Wrong argument
@CALL :usage
@EXIT /B 1

:ARGS_OK

@SET "mode_opt=-client" :: force poor optimization for the sake of the exercise
@SET "heap_opt=-Xmx1g" :: make sure there is enough heap event though -client mode is activated

java %mode_opt% %heap_opt% %prof_opt% -classpath target/classes com.kodewerk.profile.CheckIntegerTestHarness | wtee %out_file%

@IF "%1"=="h" (
	tail -40 %prof_file%
)
@ECHO %prof_file%

@GOTO :EOF

:usage
@ECHO Usage: %THISPROG% [ r ^| c ^| X ^| h ]
@ECHO   r: run alone
@ECHO   c: print compilation
@ECHO   X: Xprof profiler
@ECHO   h: hprof profiler
@GOTO :EOF
