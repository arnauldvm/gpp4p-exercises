@CALL ..\setenv.bat

@IF NOT EXIST target MKDIR target
@IF NOT EXIST target\classes MKDIR target\classes
javac -classpath target/classes -d target/classes src/com/kodewerk/profile/*.java
