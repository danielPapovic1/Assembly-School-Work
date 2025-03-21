import java.io.*;
public class A4 {
static double f2 (double x, double y ) throws IOException {
double z;
z=x*x-y*y;
return z;

}
public static void main(String[] args) throws IOException {
int x;
BufferedReader br_x = new BufferedReader(new FileReader("A41.input"));
x = Integer.parseInt(br_x.readLine());
br_x.close();
int y;
BufferedReader br_y = new BufferedReader(new FileReader("A42.input"));
y = Integer.parseInt(br_y.readLine());
br_y.close();
double z;
z=f2 ( x, y )+f2 ( y, x )+3;
BufferedWriter wr=new BufferedWriter(new FileWriter("A4.output"));
wr.write(String.valueOf(z));
wr.close();

}

}