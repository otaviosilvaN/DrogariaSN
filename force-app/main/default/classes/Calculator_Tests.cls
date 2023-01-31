@isTest
public class Calculator_Tests {

    @testSetup
    static void testSetup(){
        // inserir dados de a e b
        Integer a, b;     
        a = 3;
        b = 2;
    }
    @isTest
    static void additionTest(){
        Integer a = 3;
        Integer b = 2;
        test.StartTest();
        Calculator.addition(a, b);
        test.stopTest();
        system.assert(Calculator.addition(a,b) == 5,'A soma espera o número 5');
        
    }
    @isTest
    static void subtrationTest(){
        Integer a = 3;
        Integer b = 2;
        test.StartTest();
        Calculator.subtraction(a, b);
        test.stopTest();
        system.assert(Calculator.subtraction(a, b) == 1,'A soma espera o número 1');
        
}
    @isTest
    static void multiplyTest(){
        Integer a = 3;
        Integer b = 2;
        test.startTest();
        Calculator.multiply(a, b);
        test.stopTest();
        system.assert(Calculator.multiply(a, b) == 6,'A multiplicação espera o número 6');
    }
    @isTest
    static void divideTest(){
        Integer numerator = 4;
        Integer denominator = 2;
        test.startTest();
        Calculator.divide(numerator, denominator);
        test.stopTest();
        system.assert(Calculator.divide(numerator, denominator) == 2,'A divisão espera o número 2');
    }
    
    static void multiplyNotZero(){
        Integer numerator = 0;
        Integer denominator = 2;
        Test.startTest();
       	List<Boolean> exceptions = new List<Boolean>();
            try{
                Calculator.Multiply(numerator, denominator);
            }catch(Calculator.CalculatorException e){
                if(e.getMessage().equalsIgnoreCase('It doesn\'t make sense to multiply by zero')){
                exceptions.add(true);
            }
            }
        Test.stopTest();
        System.assertNotEquals(null,'Denominator can\'t be equals to zero');
    }
    @isTest
    static void divideDenominatorNotZero(){
        Integer numerator = 2;
        Integer denominator = 0;
        Test.startTest();
       	List<Boolean> exceptions = new List<Boolean>();
            try{
                Calculator.Divide(numerator, denominator);
            }catch(Calculator.CalculatorException e){
                if(e.getMessage().equalsIgnoreCase('you still can\'t divide by zero'){
                exceptions.add(true);
            }
            }
        Test.stopTest();
        System.assertNotEquals(null,'Denominator can\'t be equals to zero');
    }
    static void divideDenominatorNotNegative(){
        Integer numerator = 2;
        Integer denominator = -1;
        Test.startTest();
       	List<Boolean> exceptions = new List<Boolean>();
            try{
                Calculator.Divide(numerator, denominator);
            }catch(Calculator.CalculatorException e){
                if(e.getMessage().equalsIgnoreCase('Division returned a negative value.')){
                exceptions.add(true);
            }
            }
        Test.stopTest();
        System.assertNotEquals(null,'Denominator can\'t be negative to zero');
    }
    static void divideNumeratorNotNegative(){
        Integer numerator = -1;
        Integer denominator = 2;
        Test.startTest();
       	List<Boolean> exceptions = new List<Boolean>();
            try{
                Calculator.Divide(numerator, denominator);
            }catch(Calculator.CalculatorException e){
                if(e.getMessage().equalsIgnoreCase('Division returned a negative value.')){
                exceptions.add(true);
            }
            }
        Test.stopTest();
        System.assertNotEquals(null,'Numerator can\'t be negative to zero');
    }
    
}