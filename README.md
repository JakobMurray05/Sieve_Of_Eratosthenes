# Sieve_Of_Eratosthenes_README

  The Program creates an array of values from 1 to 1024. It finds all prime numbers within the list and finds it using the "Sieve of Eratosthenes". 
    
    What is a prime number? 
        A prime number is a number in which no two numbers other than the number itself and 1 can multiply together to equal the number.
        
    Expamples of primes:
        2, 3, 5, 7, 11, 13, 
        
    Sieve of Eratosthenes:
    ---------------------------------------------------------------------------------------------------------------------------------------------------------------
        The Sieve of Eratosthenes is a way to find all prime numbers by following a pattern and process of elimination of numbers
        
            Let's start with a list: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 
        
        The first number in the array we take into account is 2. 
        We will cross out every other number which is a multiple of 2, starting with 2 as shown below:
          
            Before:  2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 
            After:   2, 3, 0, 5, 0, 7, 0, 9,  0, 11,  0, 13,  0, 15,  0, 17,  0, 19,  0, 21,  0, 23,  0, 25 
         
         The next number is 3 and we follow a similar pattern, this time crossing out the values in which are multiples of 3:
         
            Before:  2, 3, 0, 5, 0, 7, 0, 9,  0, 11,  0, 13,  0, 15,  0, 17,  0, 19,  0, 21,  0, 23,  0, 25
            After:   2, 3, 0, 5, 0, 7, 0, 0,  0, 11,  0, 13,  0,  0,  0, 17,  0, 19,  0,  0,  0, 23,  0, 25
           
         The following number would have been 4, but because it is crossed out, we move on to the next non-crossed-out number, 5:
         
            Before:  2, 3, 0, 5, 0, 7, 0, 0,  0, 11,  0, 13,  0,  0,  0, 17,  0, 19,  0,  0,  0, 23,  0, 25 
            After:   2, 3, 0, 5, 0, 7, 0, 0,  0, 11,  0, 13,  0,  0,  0, 17,  0, 19,  0,  0,  0, 23,  0,  0 
          .
          .
          .
        After the program iterates through every digit, the outcome will contain only prime numbers. 
      ---------------------------------------------------------------------------------------------------------------------------------------------------------------
           
       This program uses Assembly Code, a low-level programming language to communicate with the computer's hardware. Programs such as Java or Python utilize low-level
       programming language behind the scenes. 
       
       This project was created as a bonus to a midterm in my Micro Controller class and taught me just how complex and tedious low-level programming can be. 
       
       In Assembly code, there are no If, When, or For Statements/loops but instead we use something called compare (cmp) which compares two values and depending on          how 
       the values relate you can jump to another method.
       
       For this project, I used a TI MPS430 Microcontroller and programmed the array directly to the microcontroller's RAM space. 


