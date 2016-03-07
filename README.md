<<<<<<< HEAD
# Towers of Hanoi
ECE151 Spring 2016 Towers of Hanoi implementation in MIPS Assembly language
### Team Name: Aardvark; Members: Andy Jeong, Gordon Macshane, Brenda So

####Abstract
This project aims to present a MIPS Assembly Language implmentation of Towers of Hanoi (https://en.wikipedia.org/wiki/Tower_of_Hanoi) 
This code was originally planned to be used universally, whereby inputs for the number of disks and poles are entered without any restrictions; however, due to time limitations, this only allows for N = 3 (disks) and P = 3 (poles) as input at this moment.


#### Instructions
##### To run on a MIPS simulator:
Start either MARS(R) or QtSpim(R) MIPS simulator program.
Load and initialize the following file:
    
    hanoi_tower.asm
	
##### Algorithm
The algorithm for a 3-disk, 3-pole Towers of Hanoi is as follows:
   
    Let source = pole 1, spare = pole 2, destination = pole 3
    Move the topmost (smallest) disk from pole 1 to pole 3
    Move the 2nd larger disk from pole 1 to pole 3
    Move the smallest disk from pole 3 to pole 2
    Move the largest disk to pole 3
    Move the smallest to pole 1
    Move the 2nd larger disk to pole 3
    Move the smallest disk to pole 3
    
##### General recursion algorithm
    For n > 1, 
    hanoi(n-1, source, spare, destination)
    hanoi(n-1, spare, destination, source)
##### In C,
    #include <stdio.h>
    void towersOfHanoi(int n, char source, char destination, char spare)
    {
        if (n == 1)
        {
            printf("Move disk 1 from %c to %c\n", source, destination);
            return;
        }
        towersOfHanoi(n-1, source, spare, destination);
        printf("Move disk %d from %c to %c\n", n, source, destination);
        towerOfHanoi(n-1, spare, destination, source);
    }
    int main()
    {
        int n = 4; // Number of disks
        towersOfHanoi(n, 'Source', 'Destination', 'Spare');
        return 0;
    }
##### In Java,
	public class towersOfHanoi {
    public static void moves(int n, boolean left) {
        if (n == 0) return;
        moves(n-1, !left);
        if (left) StdOut.println(n + " left");
        else      StdOut.println(n + " right");
        moves(n-1, !left);
    }

    public static void main(String[] args) {
        int N = Integer.parseInt(args[0]);
        moves(N, true);
    }
    }
    
    Source: http://introcs.cs.princeton.edu/java/23recursion/TowersOfHanoi.java.html
=======
# Towers of Hanoi
ECE151 Spring 2016 Towers of Hanoi implementation in MIPS Assembly language
### Team Name: Aardvark; Members: Andy Jeong, Gordon Macshane, Brenda So

####Abstract
This project aims to present a MIPS Assembly Language implmentation of Towers of Hanoi (https://en.wikipedia.org/wiki/Tower_of_Hanoi) 
This code was originally planned to be used universally, whereby inputs for the number of disks and poles are entered without any restrictions; however, due to time limitations, this only allows for N = 3 (disks) and P = 3 (poles) as input at this moment.


#### Instructions
##### To run on a MIPS simulator:
Start either MARS(R) or QtSpim(R) MIPS simulator program.
Load and initialize the following file:
    
    hanoi_tower.asm
	
##### Algorithm
The algorithm for a 3-disk, 3-pole Towers of Hanoi is as follows:
   
    Let source = pole 1, spare = pole 2, destination = pole 3
    Move the topmost (smallest) disk from pole 1 to pole 3
    Move the 2nd larger disk from pole 1 to pole 3
    Move the smallest disk from pole 3 to pole 2
    Move the largest disk to pole 3
    Move the smallest to pole 1
    Move the 2nd larger disk to pole 3
    Move the smallest disk to pole 3
    
##### General recursion algorithm
    For n > 1, 
    hanoi(n-1, source, spare, destination)
    hanoi(n-1, spare, destination, source)
##### In C,
    #include <stdio.h>
    void towersOfHanoi(int n, char source, char destination, char spare)
    {
        if (n == 1)
        {
            printf("Move disk 1 from %c to %c\n", source, destination);
            return;
        }
        towersOfHanoi(n-1, source, spare, destination);
        printf("Move disk %d from %c to %c\n", n, source, destination);
        towerOfHanoi(n-1, spare, destination, source);
    }
    int main()
    {
        int n = 4; // Number of disks
        towersOfHanoi(n, 'Source', 'Destination', 'Spare');
        return 0;
    }
##### In Java,
	public class towersOfHanoi {
    public static void moves(int n, boolean left) {
        if (n == 0) return;
        moves(n-1, !left);
        if (left) StdOut.println(n + " left");
        else      StdOut.println(n + " right");
        moves(n-1, !left);
    }

    public static void main(String[] args) {
        int N = Integer.parseInt(args[0]);
        moves(N, true);
    }
    }
    
    Source: http://introcs.cs.princeton.edu/java/23recursion/TowersOfHanoi.java.html
>>>>>>> origin/master
