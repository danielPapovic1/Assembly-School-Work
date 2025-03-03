import java.io.*;
class CalcParserUser {
    public static void main(String[] args){
	try {
	File inputFile = new File ("calc.input");
        CalcParser parser= new CalcParser(new CalcScanner(new FileInputStream(inputFile)));
        Integer result= (Integer)parser.parse().value;
	 System.out.println("result is "+ result);
        } catch (Exception e) {
	  e.printStackTrace();
        }
    }   
}