// SOP-C#-精簡版

// 學習資源：https://www.w3schools.com/cs

// C# Method Overloading (方法重載 => 同名方法, 不同參數個數 or 同名方法, 不同參數類型, 均屬)

  int MyMethod(int x);
  float MyMethod(float x);
  double MyMethod(double x, double y);

  //Instead of defining two methods that should do the same thing, it is better to overload one. 
  static int PlusMethod(int x, int y)
  {
    return x+y;
  }

  static double PlusMethod(double x, double y)
  {
    return x+y;
  }

// C# - What is OOP? 物件導向

  // Object-oriented programming has several advantages over procedural programming:

  //   OOP is faster and easier to execute
  //   OOP provides a clear structure for the programs
  //   OOP helps to keep the C# code DRY "Don't Repeat Yourself", and makes the code easier to maintain, modify and debug
  //   OOP makes it possible to create full reusable applications with less code and shorter development time

  // So, a class is a template for objects, and an object is an instance of a class.
  // When the individual objects are created, they inherit all the variables and methods from the class.

  // 類別是物件的結構, 物件是類別的實體
  // 物件產生後, 它會繼承類別內的所有變數及方法

  // 慣例(非強制/但大家都會遵循)：
  // 1. 類別內的變數, 視為它的屬性
  // 2. start with an uppercase first letter when naming classes. (類別首字大寫.)
  // 3. Also, it is common that the name of the C# file and the class matches (類別檔名和類別名稱相符.)

  class Car
  {
    string color = "red";
  }

  Car myCar = new Car();
  myCar.color;

//C# Multiple Classes and Objects

  //Multiple Objects
  class Car
  {
    string color = "red";
    static void Main(string[] args)
    {
      Car myCar1 = new Car();
      Car myCar2 = new Car();
      Console.WriteLine(myCar1.color);
      Console.WriteLine(myCar2.color);
    }
  }

  //Using Multiple Classes(比較好的寫法, 把類別分開寫)
  //prog2.cs
  class Car
  {
    public string color = "red"; //要加上 public, 其他類別才能存取.
  }

  //prog.cs
  class Program
  {
    static void Main(string[] args)
    {
      Car myCar3 = new Car();
      Console.WriteLine(myCar3.color);
    }
  }

//C# Class Members(類別成員 = Fields屬性 + Methods函式 均算在內)
  class MyClass
  {
    string color = "red";
    int maxSpeed = 200;
    public void fullThrottle() //油門全開
    {
      Console.WriteLine("The car is going as fast as it can.");
    }
  }

  //static method 及 public method 的差異
    //static method 不用新增物件, 即可使用. 例: Console.WriteLine("...");
    //public method 必須有物件, 才能使用. 例: Car myCar = new Car(); Console.WriteLine(myCar.color);

//C# Constructors(建構子)
  //it is called when an object of a class is created. (類別)
  //It can be used to set initial values for fields:

