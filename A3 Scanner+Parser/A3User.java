import java.io.*;

class A3User {
    public static void main(String[] args) throws Exception {
        // Open the input file "A3.tiny"
        File inputFile = new File("A3.tiny");
        
        // Create a parser by passing an instance of the scanner (which reads from inputFile)
        A3Parser parser = new A3Parser(new A3Scanner(new FileInputStream(inputFile)));
        
        // Parse the input file and get the result (the method count)
        Integer result = (Integer) parser.parse().value;
        
        // Write the output to "A3.output"
        FileWriter fw = new FileWriter(new File("A3.output"));
        fw.write("Number of methods: " + result.intValue());
        fw.close();
    }
}
