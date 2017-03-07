package com.zp.test2;
public abstract class ExA {  
    static {  
        System.out.println("父类--静态代码块");  
    }  
  
    public ExA() {  
        System.out.println("父类--构造函数"+a);  
    }  
    protected static int a=1;
    {  
    	a=2;
        System.out.println("父类--非静态代码块");  
    }  
  
    public static void main(String[] args) {  
        new ExB().test();;  
//    	ExB.test();
    }  
}  
  
class ExB extends ExA {  
    static {  
        System.out.println("子类--静态代码块"+a);  
    }  
    {  
        System.out.println("子类--非静态代码块");  
    }  
  
    public ExB() {  
        System.out.println("子类--构造函数");  
    } 
    public static void test(){
    	a=3;
    }
}  