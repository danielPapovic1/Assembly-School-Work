#!/usr/bin/env bash

# Clean up any previously generated files
rm *.class A4.java A4.output

# Generate the scanner from A4.lex using JLex
java JLex.Main A4.lex

# Generate the parser (translator) from A4.cup using JavaCUP
java java_cup.Main -parser A4Parser -symbols A4Symbol < A4.cup

# Compile the generated files along with the driver
javac A4.lex.java A4Parser.java A4Symbol.java A4User.java

# Run the driver to produce the translated Java program (A4.java)
java A4User

# Compile the generated Java program
javac A4.java

# Run the translated Java program
java A4

# Display the output file
cat A4.output