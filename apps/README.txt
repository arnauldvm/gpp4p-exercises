Create here our setnev.sh or setenv.bat, adding java to the PATh environment variable

For example, setenv.bat:

@SET "JAVA_HOME=C:\javadev\tools\java\sdk\1.7.0_40"
@SET "PATH=%JAVA_HOME%\bin;%PATH%"

/!\ Make sure your JVM is 32 bits

