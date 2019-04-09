<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Ruby Fundamentals](#ruby-fundamentals)
  - [An introduction to Ruby](#an-introduction-to-ruby)
    - [Interactive Shell](#interactive-shell)
    - [Variables, nil, Methods and Scope](#variables-nil-methods-and-scope)
    - [Flow Control, Operators, Comments](#flow-control-operators-comments)
    - [Some Useful Methods](#some-useful-methods)
  - [Classes and Objects](#classes-and-objects)
    - [Creating Classes and Objects](#creating-classes-and-objects)
    - [Instance Variables and Methods](#instance-variables-and-methods)
    - [Accessors and Virtual Attributes](#accessors-and-virtual-attributes)
    - [Initialization and Cleanup](#initialization-and-cleanup)
    - [Inheritance](#inheritance)
    - [Class Methods and Variables](#class-methods-and-variables)
    - [Method Visibility](#method-visibility)
    - [Executable Class bodies and self](#executable-class-bodies-and-self)
    - [Open Classes and Monkey Patching](#open-classes-and-monkey-patching)
    - [Equality](#equality)
  - [Flow Control](#flow-control)
    - [Branching](#branching)
    - [Conditional Initialization](#conditional-initialization)
    - [Flow Control Using and/or](#flow-control-using-andor)
    - [Case Statement](#case-statement)
    - [Looping Constructs](#looping-constructs)
    - [Looping with Iterators and Blocks](#looping-with-iterators-and-blocks)
    - [Controlling Loop Flow](#controlling-loop-flow)
    - [Handling Exceptions](#handling-exceptions)
    - [Raising Exceptions](#raising-exceptions)
    - [Exceptions: ensure and else Clause](#exceptions-ensure-and-else-clause)
    - [Exceptions: Retrying and Rescue](#exceptions-retrying-and-rescue)
    - [Throw and Catch](#throw-and-catch)
    - [Scope](#scope)
  - [Standard Types](#standard-types)
    - [Booleans](#booleans)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Ruby Fundamentals

> Learning Ruby with Pluralsight [course](https://app.pluralsight.com/library/courses/ruby-fundamentals/table-of-contents)

## An introduction to Ruby

### Interactive Shell

- aka REPL.
- Everything in Ruby is an object
- Ruby is dynamically typed, can assign different types to the same variable
- Check variable type by using it's `class` method
- `class` method doesn't just return name of class, returns class itself, which is also an object
- All objects have method `public_methods`, which returns array of public methods available on that object
- One of public methods in `superclass`, use to traverse inheritance hierarchy, eg: String -> Object - > BasicObject
- Numbers are also objects -> consistency having everything be an object lets you write cleaner code
- Can also define new methods in repl
- Method that multiplies two numbers can also accept strings or arrays (multiplication operator implemented for other types)
- Ruby supports "duck typing"
- Special variable `_` stores result of last evaluated expression

```shell
$ irb
2.6.0 :001 > lander_count = 10
 => 10
2.6.0 :002 > lander_count = "sufficient"
 => "sufficient"
2.6.0 :003 >lander_count.class
 => String
2.6.0 :004 > String.class.public_methods.sort
 => [:!, :!=, :!~, :<, :<=, :<=>, :==, :===, :=~, :>, :>=, :__id__, :__send__, :alias_method, :allocate, :ancestors, :attr, :attr_accessor, :attr_reader, :attr_writer, :autoload, :autoload?, :class, :class_eval, :class_exec, :class_variable_defined?, :class_variable_get, :class_variable_set, :class_variables, :clone, :const_defined?, :const_get, :const_missing, :const_set, :constants, :define_method, :define_singleton_method, :deprecate_constant, :display, :dup, :enum_for, :eql?, :equal?, :extend, :freeze, :frozen?, :hash, :include, :include?, :included_modules, :inspect, :instance_eval, :instance_exec, :instance_method, :instance_methods, :instance_of?, :instance_variable_defined?, :instance_variable_get, :instance_variable_set, :instance_variables, :is_a?, :itself, :kind_of?, :method, :method_defined?, :methods, :module_eval, :module_exec, :name, :nesting, :new, :nil?, :object_id, :prepend, :private_class_method, :private_constant, :private_instance_methods, :private_method_defined?, :private_methods, :protected_instance_methods, :protected_method_defined?, :protected_methods, :public_class_method, :public_constant, :public_instance_method, :public_instance_methods, :public_method, :public_method_defined?, :public_methods, :public_send, :remove_class_variable, :remove_instance_variable, :remove_method, :respond_to?, :send, :singleton_class, :singleton_class?, :singleton_method, :singleton_methods, :superclass, :taint, :tainted?, :tap, :then, :to_enum, :to_s, :trust, :undef_method, :untaint, :untrust, :untrusted?, :used_modules, :yield_self]
2.6.0 :006 > String.superclass
 => Object
2.6.0 :007 > 10.class
 => Integer
2.6.0 :009 > -100.abs
 => 100
2.6.0 :010 > def double(val); val * 2; end
 => :double
2.6.0 :011 > double(5)
 => 10
2.6.0 :012 > double("abc")
 => "abcabc"
2.6.0 :013 > double([1, 2, 3])
 => [1, 2, 3, 1, 2, 3]
2.6.0 :014 > double(_)
 => [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3]
```

### Variables, nil, Methods and Scope

To use a variable, don't need to declare it or its type, simply assign a value whenever you need it:

```ruby
lander_count = 10
```

- Variable names start with lower case.
- Idiomatic ruby - use underscore to make it readable (not camelCase)
- To define a variable when don't have a value yet, assign nil: `my_var = nil`
- `nil` is not a primitive, it's a special object to indicate a null variable
- Use variable's `nil` method to check if its nil: `myVar.nil?`
- `?` is not special syntax, it's part of method name
- methods that end in `?` are used for methods that perform true/false test
- `!` for methods that do something unexpected/dangerous, eg: something that modifies object rather than returning modified copy
- `strip` method of String class returns a _new_ string with empty spaces trimmed, but `strip!` _modifies_ the existing string

```shell
2.6.0 :001 > nil.class
 => NilClass
2.6.0 :003 > result.nil?
  => true
```

- Methods normally defined on multiple lines demarcated by keywords `def` and `end`.
- Can return any type or even different types depending on situation.
- Returns result of evaluating last expression, no need for explicit `return` except when used for flow control.
- Indented with 2 spaces
- Whitespace not significant

```ruby
def double(val)
  val * 2
end
```

Brackets around arguments are optional, but usually used when there is argument list:

```ruby
double("abc")
```

Some methods are more like keywords, in that case, common to omit brackets, eg:

```ruby
puts 'Hello!'
```

Methods provide scope for variables, [example](module1/vars.rb)

```ruby
# Outer scope
# This is a local variable - visibility limited to scope in which its created.
# Since it's defined at start of file, will be visible throughout this program.
lander_count = 10

def report
  # Inner scope shadows variable in outer scope
  # If variable defined within a method, then it's only visible within this method
  # This lander_count is a new variable that only exists within scope of method
  # Has no effect on lander_count variable in outer scope
  lander_count = 5
  puts lander_count
end

# Note no brackets to invoke report function because it doesn't take any arguments
report

puts lander_count
# Outputs:
# 5
# 10
```

To create global variable, prefix with `$`, eg:

```ruby
$log_level = "debug"  # visible throughout program
```

Recommend not to use globals!

### Flow Control, Operators, Comments

[Example](module1/control_structs.rb)

Ruby treats statements as expressions as much as possible. `if lander_count > 10` is an expression that evaluates to result of the last expression in the selected branch. Therefore the following are equivalent:

```ruby
lander_count = 11

if lander_count > 10
  puts 'Launching probe'
else
  puts 'Waiting for test probes to return'
end
```

```ruby
lander_count = 11

message = if lander_count > 10
  puts 'Launching probe'
else
  puts 'Waiting for test probes to return'
end

puts message
```

This means assignments can be chained because assignment expression yields value that was assigned:

```ruby
a = b = 10
```

Supports the usual comparison operators (plus few more will be shown later in course):

```
>
>=
<
<=
==
!=
```

Some usual mathematical operators:

```
+
-
*
/
%
** (exponentiation)
```

Logical operators can use symbols or english words (but latter have lower precedence):

```
!
&&
||
not
and
or
```

Bitwise integer operators

```
&  bitwise and
|  bitwise or
^  exclusive or
~  complement
<<  shift left by specified number of bits
>>  shift right by specified number of bits
```

Shorthand assignment operators

```
+=
-=
*=
/=
%=
**=
&=
|=
^=
>>=
<<=
```

**Comments**

Anything following `#` is a comment.

### Some Useful Methods

[IO Example](module1/io.rb)

`print` followed by string will prompt and wait, `gets` gets user input and returns it. `puts` adds newline to string.

```ruby
print "Enter your name:"
name = gets
puts "Your name is " + name
```

To execute command in another process and collect its result...

- Use backticks to specify a command to execute, eg: asking for system time.
- Will be launched in separate process.
- Ruby process will block until it's complete.
- Output of command is returned to Ruby, can be stored in a variable.
- Can also use `%x` instead of backticks: `res = %x(time /t)`
- `system` command is similar, but returns true if command finished with 0 status, false otherwise, returns `nil` if command failed.
- Output of `system` command is piped to standard output

```ruby
puts "Using backticks:"
res = `date`
# res = %x(date)
puts res

puts "Using system:"
res = system "date"
puts res
```

## Classes and Objects

### Creating Classes and Objects

- To create a class, start with `class` keyword and finish with `end` keyword (generally used to finish all blocks of code)
- Class names start with a capital letter, use CamelCase
- Capitalize abbreviations, eg: `XMLParser`, `JSONRequest`
- Use `new` method of class to instantiate an object, no need for brackets if not passing arguments

```ruby
class Spaceship
end
...
ship = Spaceship.new
```

**Objects vs. Variables**

- Most things in Ruby are objects, but variables are NOT
- Variables are labels for objects

Eg: Assign a variable `a` to an instance of String class `"abc"`, then another variable `b`. Will have two different variables, both referring to the same object:

```ruby
a = "abc"
b = a
# Modify a also modifies b
a.upcase!
a
=> "ABC"
b
=> "ABC"
```

Can also verify `a` and `b` refer to same object by checking unique object ID:

```ruby
a.object_id
=> 70293423591060
b.object_id
 => 70293423591060
```

When arguments are passed to a method, same behaviour -> objects are passed by reference.

To create copy of object, use `clone` method from `Object` class. But this is a shallow clone only.

```ruby
b = a.clone
b.object_id
=> 70293418715080 # b is now referencing a new different object than a
```

### Instance Variables and Methods

[Example](module2/instance_vars.rb)

- Classes can have methods and instance methods
- Instance variables denoted with `@`
- Each instance of class will have its own copy of each instance variable
- You can mix class definition with other code in the same file
- By default, instance variables are not visible outside of class, this will fail if written outside of class: `puts ship.destination`
- Instance methods however are public by default, so to access instance var, define instance method that returns it

```ruby
class Spaceship
  def launch(destination)
    # store destination argument in instance variable
    # instance variable is only created here, if this method not called then instance var does not exist
    @destination = destination
    # go towards destination
  end

  def destination
    @destination
  end
end
```

### Accessors and Virtual Attributes

- Tedious to define getters and setters for every instance var
- Use `attr_accessor` to provide read/write accessors for instance var
- `:` indicates _symbol_ (discussed further in this course)
- Use `attr_reader` to provide read-only access to instance var
- Use `attr_writer` to provide write-only access to instance var
- `attr_accessor` combines reader and writer
- Define multiple accessors by specifiying all on line line comma separted

```ruby
class Spaceship
  attr_accessor :destination
  attr_reader :name
  attr_writer :foo
  attr_accessor :var1, :var2
end

ship = Spaceship.new
ship.destination = "Earth" # invoking setter
puts ship.destination # Earth - invoking getter
```

Gotcha when using accessors inside class:

```ruby
class Spaceship
  attr_accessor :destination, :name

  def cancel_launch
    destination = "" # creates local variable, is NOT using accessor method
    self.destination = "" # this will use the accessor
  end
end
```

**Virtual Attributes**

Under the hood, `attr_accessor` adds a pair of methods to class for getting and setting the instance var

```ruby
class Spaceship
  attr_accessor :destination
end
```

Equivalent to

```ruby
class Spaceship
  # getter
  def destination
    @destination
  end

  # setter
  # `=` is part of method name, by convention this signifies its a setter
  def destination=(new_destination)
    @destination = new_destination
  end
end
```

- Rather than using getter/setter to directly manipulate instance var, can pass given value to some other instance var such as `autopilot` in below example.
- This makes destination a `virtual attribute`, class interface still supports getting and setting `destination` but under the hood, there is no such instance var.

```ruby
class Spaceship
  def destination
    @autopilot.destination
  end

  def destination=(new_destination)
    @autopilot.destination = new_destination
  end
end

ship = Spacehip.new
ship.destination = "Earth"
puts ship.destination # outputs Earth
```

### Initialization and Cleanup

[Example](module2/initialize.rb)

- Most objects need some initial state
- Use `initialize` method in class to initialize an object
- Pass corresponding arguments when invoking class `new` method

```ruby
class Spaceship
  def initialize(name, cargo_module_count)
    @name = name
    @cargo_hold = CargoHold.new(cargo_module_count)
    @power_level = 100
  end
end

ship = Spaceship.new("Dreadnought", 4) # invokes initialize("Dreadnought", 4)
```

**Destroying Objects**

- No need because Ruby has a garbage collector
- Mark and Sweep GC runs periodically, cleans up objects that are no longer referenced by program

### Inheritance

[Example](module2/super.rb)

- Class can only inherit from a single class
- Multiple inheritance not supported, but modules (covered later in course) provide an alternative
- All classes inherit from `Object` (provides methods such as `clone`, `public_methods`, etc), which inherits from `BasicObject` (BlankSlate, explicit blank class)
- May want your custom class to inhert from BasicObject, eg: to avoid name collisions with methods in Object class
- When method is called on object, Ruby checks if it exists on that object's class, if not found, traverses hierarchy of class ancestors looking for method match. If found on a super class, calls it. Otherwise, get an error.
- All methods from base class, including `initialilze` are inherited
- In example below, `take_sample` method is overridden
- When overridding, can change number of parameters method takes, all that's required is that method name matches
- Use `super` keyword in child class to invoke method from base class

```ruby
class Probe
  def deploy
    # deploy the probe
  end
  def take_sample
    # do generic sampling
  end
end

class MineralProbe < Probe
  def take_sample
    # Take a mineral sample
  end
end

class AtmosphericProbe < Probe
  def take_sample
    # Take a sample of the atmosphere
  end
end
```

**Inheritance is for reusing functionality, NOT enforcing interfaces. Uses "duck typing"**

In example below, `probe` and `lander` don't need to be part of same inheritance hierarchy (in Java, would require something like a `Dockable` interface). As long as they both have `dock` method, this will work:

```ruby
class Spaceship
  def capture(unit)
    unit.dock # works on anything with dock method
    transport_to_storage(unit)
  end
end

ship.capture(probe) # fine as long as probe has dock method
ship.capture(lander) # fine as long as lander has dock method
```

### Class Methods and Variables

[Example](module2/class_var.rb)

- Class method is called on class instead of object, eg: `new` to instantiate objets
- Useful for functionality that is independent of object state
- To define class method, prefix with `self.`
- To invoke, call it on class rather than object

Eg: Given that every `Spaceship` class will have same number of thrusters:

```ruby
class Spaceship
  def self.thruster_count
    2
  end
end

Spaceship.thruster_count
```

**Class Variables**

- Class methods may have some state that needs to be preserved between calls, for this, use _Class Variables_
- Denoted with `@@`
- Only one copy of class var per class, shared bewteen all objects instantiated from that class
- Defined in class body
- Not visible outside class, need to provide accessors if needed outside class
- Not used often in practice due to quirky behaviour, eg: suppose have different types of Spaceships, each with different thruster counts
- Program below outputs 1 because class vars shared across _all_ classes in hierarchy, so there's only one copy of class var `thruster_count` among all 3 classes

```ruby
class Spaceship
  @@thruster_count = 2
  def self.thruster_count
    @@thruster_count
  end
end

class SpritelySpaceship < Spaceship
  @@thruster_count = 4
end

class EconolineSpaceship < Spaceship
  @@thruster_count = 1
end

puts SpritelySpaceship.thruster_count
# outputs 1 -> surprise!
```

**Class Instance Variables**

- Recommended over class variables
- In example below, `thruster_count` looks like instance variable but defined right in class body, and returned in class instance method
- This makes it a variable defined on the class rather than object
- Parent class and all subclasses each get their own copy of variable (but still just one per class)

```ruby
class Spaceship
  @thruster_count = 2
  def self.thruster_count
    @thruster_count
  end
end

class SpritelySpaceship < Spaceship
  @thruster_count = 4
end

class EconolineSpaceship < Spaceship
  @thruster_count = 1
end

puts SpritelySpaceship.thruster_count # outputs 4
puts EconolineSpaceship.thruster_count # outputs 1
puts Spaceship.thruster_count # outputs 2
```

### Method Visibility

[Example](module2/visibility.rb)

- By default, all methods defined on a class are public
- A method can be private or protected
- In example below, `batten_hatches` method is marked as private
- Visibility not strongly enforced, eg, can use Object `send` method to invoke any private method: `ship.send :batten_hatches`
- Private methods can be called from subclasses, because private method is inherited by subclass along with all other methods
- Private method can be called with an explicit object receiver

```ruby
class Spaceship
  def launch
    batten_hatches
    # do other stuff
  end

  def batten_hatches
    puts "Batten the hatches!"
  end
  private :batten_hatches
end
```

- Can also put `private` declaration before methods, and all methods following will be private, either until end of class or another visibility declaration is encountered.
- Most commonly used syntax

```ruby
class Spaceship
  def launch
    batten_hatches
    # do other stuff
  end

  private

  def batten_hatches
    puts "Batten the hatches!"
  end

  def light_seatbelt_sign
    puts "The seatbelt sign is now on."
  end
end
```

- Can also supply multiple methods to the visibility declaration:

```ruby
class Spaceship
  def launch
    batten_hatches
    # do other stuff
  end

  private

  def batten_hatches
    puts "Batten the hatches!"
  end

  def light_seatbelt_sign
    puts "The seatbelt sign is now on."
  end

  private :batten_hatches, :light_seatbelt_sign
end
```

**Making Class Methods Private**

```ruby
class Spaceship
  def self.disable_engine_containment
    # dangerous - should be private
  end

  # no error but does nothing
  private :disable_engine_containment

  # this is the correct way
  private_class_method :disable_engine_containment
end
```

**Protected Methods**

[Example](module2/protected.rb)

- Protected method can be called on another obect by an object of the same class, or an object with the same ancestor if the method was defined in that ancestor
- Example, want to compare ship's call signs, without making the call sign getter public

```ruby
class Spaceship
  def launch
    batten_hatches
  end

  attr_reader :call_sign
  protected :call_sign

  def initialize
    @call_sign = "Dreadnought"
  end

  def call_sign_matches?(other)
    call_sign == other.call_sign
  end
end

class SpritelySpaceship < Spaceship
  def initialize
    @call_sign = "Fast cruiser "
  end
end

ship = Spaceship.new
fast_ship = SpritelySpaceship.new

puts fast_ship.call_sign_matches?(ship) # false
puts ship.call_sign # trying to invoke protected method directly results in error
# protected method `call_sign' called for #<Spaceship:0x00007fac318d8f08 @call_sign="Dreadnought"
# > (NoMethodError)
```

### Executable Class bodies and self

[Example](module2/exec_class.rb)

- Class bodies are expressions, executed just like other code
- Class declaration is an expression so can assign its result to a variable
- Classes provide context for execution of code

```ruby
def greet(greeting)
  puts greeting + ", captain!"
end

result = class Spaceship
  answer = 7 * 6
  puts "Calculating in class context: " + answer.to_s
  greet("Good morning")
  answer
end

puts "The class calculated: " + result.to_s
puts Spaceship.superclass

# Calculating in class context: 42
# Good morning, captain!
# The class calculated: 42
# Object
```

**self**

- `self` refers to current execution context
- Can use `self` at any point in a program
- Value of `self` changes as program executes
- Inside class, refers to class
- Inside method, refers to object
- Any method called without explicit object reference is called on self

```ruby
class Spaceship
  # self == Spaceship, therefore this adds method to the class:
  def self.thruster_count
    2
  end

  def cancel_launch
    # when ship.cancel_launch is called, self is now the ship object
    self.destination = ""
    # no explicit object reference - seatbelt_sign called on ship object
    seatbelt_sign(:off)
  end
end
```

### Open Classes and Monkey Patching

- Below example is legal Ruby code, `Spaceship` class is defined twice
- Second class declaration is not redefining class, but _re-opening_ it to add another method `launch`
- All objects are able to use new `launch` method, even those instantiated before additional declaration
- However, cannot invoke `ship.launch` before second declaration

```ruby
class Spaceship
  def batten_hatches
    puts "Batten the hatches!"
  end
end

ship = Spaceship.new

class Spaceship
  def launch
    batten_hatches
    puts "Launched!"
  end
end

ship.launch
```

**Monkey Patching**

[Example](module2/monkey.rb)

- Refers to adding/modifying functionality, usually 3rd party functionality, at runtime
- Exploit concept of open classes
- When re-opening a class, can also override an existing method - when Ruby encounters a method definition that already exists, later declaration replaces previous
- If original method was private/protected, redefinition will not preserve visibility restrictions
- Can use monkey patching to modify methods in standard library
- Used to fix bugs in 3rd party libraries, but careful because can be surprising and cause brittleness when upgrading libraries

```ruby
class String
  # add a space after each character
  def space_out
    chars.join(" ")
  end

  def size
    "Won't tell you!"
  end
end

puts "Firefly".space_out
puts "abc".size
# F i r e f l y
# Won't tell you!
```

### Equality

Use equal method to test if two variables are pointing to the same object

```ruby
a=b=1
a.equal?(b)
=> true
b = 2
a.equal?(b)
=> false
```

But could have two different instances of an object representing the same thing? [Example](module2/equality.rb)

```ruby
class Spaceship
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

ship1 = Spaceship.new("Serenity")
ship2 = Spaceship.new("Serenity")

puts ship1.equal?(ship2) # false, even though both ship objects represent the same thing
puts ship1.name == ship2.name # true
```

**How does this work with strings and equality?**

This demonstrates Ruby does have ability to compare two different objects via `==` operator, while maintaining ability to distinguish if they refer to same object or not via `equals?` method:

```ruby
a = "abc"
b = "abc"
a == b
=> true
a.equal?(b)
=> false
```

Solution for custom class example earlier is to provide custom implementation of `==` operator. Default implementation does the same thing as `equals?` method.

```ruby
class Spaceship
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end
end

ship1 = Spaceship.new("Serenity")
ship2 = Spaceship.new("Serenity")

puts ship1.equal?(ship2) # false
puts ship1.name == ship2.name # true
puts ship1 == ship2 # true due to custom override of ==
```

## Flow Control

### Branching

**Conditional Execution with if-else**

```ruby
if can_launch?
  launch
else
  wait
end
```

if/else also works as expression, can assign its result to a variable:

```ruby
message = if lander_cnt > 10 then "Launching" else "Waiting" end
```

`then` keyword is optional, to separate condition from statement. Used when writing if/else on line line, but not for multi-line.

Modified version of if statement doesn't have else clause - good for short statement followed by short conditiion.

```ruby
launch if can_launch?
```

To test multiple conditions, use `elsif` keyword:

```ruby
if fuel_level > 50
  set_fuel_light("green")
elsif fuel_level > 25
  set_fuel_light("yellow")
else
  set_fuel_light("red")
end
```

**True and False**

- Only `false` and `nil` evaluate to false in conditions
- Everything else evaluates to true, eg: true, 0, empty string, empty array etc.

**Conditional Execution with `unless`**

- Opposite of `if`
- `if not condition` === `unless condition`
- can make code more legible
- does support `else` clause but recommend not to use to avoid confusion
- modified version can be used as statement

```ruby
unless fuel_launch < 25
  launch
end

# unless modifier
launch unless fuel_level < 25
```

**Ternary operator ?:**

- More succint than if else
- Result returned same as regular `if`
- Avoid nested ternary operators to avoid confusion

```ruby
can_launch? ? launch : wait
```

### Conditional Initialization

- Recall shortcut assignment operators combining assignment with another operation, eg: `a += 10` === `a = a + 10`
- Two other shortcut assignment operators: `||=`, `&&=`
- And-equals not used much but Or-equals is very common for conditional initialization of variables
- If assignment appears in statement, variable is created and set to nil, even if assignment isn't executed.
- Doesn't work for boolean values because idiom relies on nil being evaluated as false, but false is the other object that also evaluates to false

```ruby
# Call Spaceship.new and assign it to ship variable ONLY if ship variable evaluates to false or doesn't exist
# If ship variable already has a value, then ||= operator does nothing
ship ||= Spaceship.new
# Above can also be accomplished with unless but more verbose:
ship = Spaceship.new unless ship
```

`ship ||= Spaceship.new` === `ship || ship = Spaceship.new`

```ruby
a || a = 10
# NameError (undefined local variable or method `a' for main:Object)
a ||= 10
=> 10
a
=> 10
b = 20 if false
=> nil
b
=> nil
c = c
=> nil
c
=> nil
# unexpected behaviour with booleans
# initialize a flag to true with conditional
flag ||= true
=> true
flag
=> true
# So far so good, now change flag to false
flag = false
=> false
# Now try conditional assignment again, would expect flag to remain false because it already has this value
flag ||= true
=> true
flag
=> true  # WATCH OUT: flag is now true
```

### Flow Control Using and/or

- Two forms of these operators: `||` `&&` `and` `or`
- Superficially similar but important differences...
- `and` and `or` have much lower precedence than `&&` and `||`
- `&&` has higher precedence than `||`
- `and` and `or` have the _same_ precedence
- In absence of brackets, can get unexpected results, recommend using only `&&` and `||` in conditional statements
- `and` and `or` do however have a role in flow control
- Use `and` to chain operations until one of them returns `nil` or `false`, works due to short circuiting -> will not evaluate any more operands than it has to.
- Use `or` to construct series of fallback operations -> If first operation returns `nil` or `false`, try the second one, etc.

`lander.recall` only executed if `Lander.locate(lander_id)` does not return `nil` or `false`:

```ruby
lander = Lander.locate(lander_id) and lander.recall
# equivalent to above but more verbose:
lander = Lander.locate(lander_id)
lander.recall if lander
```

If engine cuts out, try to restart it. If that fails (i.e. assume it returns true if successful, false or nil otherwise), switch to emergency power.

```ruby
if engine.cut_out?
  engine.restart or enable_emergency_power
end
# equivalent to above using unless:
if engine.cut_out?
  enable_emergency_power unless engine.restart
end
```

### Case Statement

- Each `when` clause is evaluated in turn
- There is no fall through
- Can be used as an expression just like `if`
- Uses triple equals `===` to compare values -> can use class for comparison because triple equals used to determine if an object is an instance of that class
- By default `===` operates the same as `==` but can be overridden to do something else
- Use final `else` clause as catch-all to be executed when none of the `when` clauses match
- Can be used without providing an object

```ruby
case distance_to_dock
when "far away"
  lander.maintain_thrust
when "coasting time"
  lander.kill_thrust
when "collision imminent"
  lander.reverse_thrust
end
```

```ruby
# as expression, if no `when` clause matches, will return nil
thrust_power = case distance_to_dock
               when "far away"
                100
              when "coasting time"
                0
              when "collision imminent"
                -100
              end

# more concise version using `then` keyword
thrust_power = case distance_to_dock
               when "far away" then 100
               when "coasting time" then 0
               when "collision imminent" then -100
               end
```

```ruby
# class example
case unit
when Lander
  lander.park
when Probe
  probe.retrieve_sample
  probe.transport_to_storage
else
  activate_alarm("Unidentified unit")
end
```

```ruby
# no object, just specify conditions in each `when` clause
case
when distance_to_dock > 100
  lander.maintain_thrust
when distance_to_dock > 2
  lander.kill_thrust
else
  lander.reverse_thrust
end
```

### Looping Constructs

Explicit use of loops is limited because most common uses are to iterate over a collection or iterate a particular number of times, each of which is better accomplished with iterators

**While**

```ruby
while high_alert?
  sound_system.play_siren_cycle
end
# one liner version using `do` keyword to separate loop condition from loop body
while high_alert? do sound_system.play_siren_cycle end
# modifier form to tack on to statement
sound_system.play_siren_cycle while high_alert?
```

**Until**

`if` has counterpart `unless`, `while` has counterpart `until` to be used with inverated condition.
Condition evaluated at start of loop -> loop body may never execute if condition is initially true.

```ruby
until ship.at_cruising_velocity?
  ship.accelerate
end
# one liner version
until ship.at_cruising_velocity? do ship.accelerate end
# modifier form statement
ship.accelerate until ship.at_cruising_velocity?
```

**begin/end**

- `while` and `until` can be tacked on to begin/end block as modifiers
- begin/end block used to group multiple expressions into a single expression -> yields result of last expression in group
- begin/end block will always execute at least once, even if condition is initially false

```ruby
begin
  lighting.start_flashing
  sound_system.play_siren_cycle
end while high_alert?

begin
  ship.accelerate
  make_fake_engine_noise
end until ship.at_cruising_velocity?
```

**for**

- Not often used, prefer `each` method of iteration.
- for loop is syntactic sugar over `each`

```ruby
puts "Counting down to launch"
for i in [3, 2, 1]
  puts i
end
```

More common use is to iterate over range

```ruby
# print numbers from 1 to 10
for i in (1..10)
  puts i
end
```

### Looping with Iterators and Blocks

- do/end blocks are passed as arguments to a method
- `each` method accepts a block argument (which occurs after regular arguments), can execute the block one or multiple times
- Convention: do/end keywords used for multi-line blocks, curly braces for single-line blocks
- Method that is executing the block can also pass arguments into the block each time its executed
- Block arguments specified between vertical bars at start of block

```ruby
# execute do/end block once for each item in array -> iterator
[1, 2, 3].each do
  puts "This is Sreentiy, please respond"
end

# with arguments
ships = Spaceship.all
ships.each { |ship| puts ship.name }
```

`loop` with block:

```ruby
# infinite loop
loop do
  go_another_light_year
  puts "This is not the edge of the universe"
end
```

**Some Help from Numbers**

```ruby
# Use `upto` method from Integer class to print numbers from 10 to 20 (inclusive):
10.upto(20) { |i| puts i}
# reverse
20.downto(10) { |i| puts i}
# repeats block according to number its called on
3.times { puts "This is Serenity, please respond" }
# loop over range with custom increment
1.step(10, 2) { |i| puts i }
1
3
5
7
9
 => 1
```

### Controlling Loop Flow

- May want to terminate loop early: `break`, `next`, `redo`
- Work in explicit loops like while, and implicit iterators like each

`next` starts next iteration of loop without finishing current iteration

```ruby
# skip sync messages
while message = comms.get_message
  next if message.type == "sync"
  message.process
end
```

`break` exists out of the loop

```ruby
# process messages until a voice type is encountered
while message = comms.get_message
  message.process
  break if message.type == "voice"
end
```

Loops are expressions -> produce value, pass one or more arguments to break which become result of evaluating loop expression:

```ruby
# text variable will be assigned message.text if voice type is encountered
text = while message = comms.get_message
          message.process
          break message.text if message.type == "voice"
       end
```

`redo` repeats teration without re-evaluating loop condition

```ruby
i = 0
while i < 3
  print "Please enter a positive number: "
  input = gets.to_i
  redo if input <= 0 # control flows back to print line
  i += 1
end
```

### Handling Exceptions

- Preferred method for error handling is to raise and handle exceptions
- Encapsulated in Exception class or one of its subclasses
- When exception raised, callstack unwound until appropriate call handler found
- If none found, program terminated

batten_hatches method could raise exceptions, to handle:

```ruby
def launch
  begin
    batten_hatches
  rescue
    puts "Couldn't batten hatches" # comes here if batten_hatches raises exception
    return false # explicit return required to avoid subsequent lines being executed
  end
  light_seatbelt_sign
end
```

But what if `light_seatbelt_sign` could also raise an exception?

Rescue clause can be applied to entire method rather than begin/end block -> put `rescue` clause at end of method definition.

```ruby
def launch
  batten_hatches
  light_seatbelt_sign
  true
rescue
  puts "Exception intercepted"
  false
end
```

When `rescue` appears on a line by itself without specifying what kind of exception to intercept, will handle any exception derived from `StandardError` class.

![exception](doc-images/exception.png 'exception')

To get details from exception object so that rescue can do something less generic with it, give it a name

```ruby
def launch
  batten_hatches
  light_seatbelt_sign
  true
rescue StandardError => e
  puts e.message
  puts e.backtrace # outputs callstack to point where exception was raised
  false
end
```

To handle different types of exceptions differently, provide multiple clauses.
Note that type of exception can be specified without naming the exception object.
Multiple exception clauses evaluated in order, subclasses successfully matched against super classes -> handle more specific exception types first.

```ruby
def launch
  batten_hatches
  light_seatbelt_sign
  true
rescue LigthError
  puts "Lights not working, still launching"
  true
rescue StandardError => e
  puts e.message
  false
end
```

**Exception Class**

Not a good idea to handle generic Exception class -> too broad, will catch for eg `SignalException`, `SyntaxError`. Catching `SignalException` prevents user from terminating program with Ctrol+C or `kill`.

```ruby
# BAD
begin
  ship = Spaceship.new
  ship.launch
rescue Exception => e
  puts e.message
  puts e.backtrace
end
```

### Raising Exceptions

- Need to raise exceptions in your program when something unexpected happens.
- Use `raise` method from `Object` class, or synonym `fail`
- If pass a string as argument to `raise`, a `RuntimeError` will be raised, with `message` property the string passed
- Can specify an exception class to raise
- Can write custom exception class if need to provide more information than simple string message -> derive custom exception class from `StandardError` to ensure it's caught by default

```ruby
def batten_hatches
  # ...
  raise "Doors jammed" # RuntimeError
  # ...
end

def batten_hatches
  # ...
  raise HatchError, "Doors jammed"
  # ...
end
```

**Re-Raising Exceptions**

- `raise` can be called without arguments within a `rescue` clause -> raises exception stored in global variable `$!`
- Refers to last raised exception, in example below, same exception object as `err`
- Supports logging exceptions, then passing them on to other handlers further up the callstack
- Can decide if you want to handle this exception or pass it on to more generic handler

```ruby
rescue HatchError => err
  puts $!.message
  raise
end
```

### Exceptions: ensure and else Clause

- Eg, if file is opened, needs to be closed whether exception was raised or not.
- Use `ensure` for code that always needs to be executed.
- `ensure` clause must be defined _after_ rescue clause(es)
- Do not put `return` statement in `ensure` clause -> causes any exceptions thrown in method to be silently swallowed and return statement would execute instead

```ruby
def batten_hatches
  hatch_file = File.open("hatches.txt")
  #...
  raise HatchError, "Doors jammed" if door.jammed?
  #...
  true
rescue SystemCallError => e
  # handle file errors
  false
ensure
  hatch_file.close if hatch_file
end
```

Before `ensure` clause, but after `rescue` clause(es), can also add `else` clause that's executed if no exceptions were thrown

```ruby
def batten_hatches
  hatch_file = File.open("hatches.txt")
  #...
  raise HatchError, "Doors jammed" if door.jammed?
  #...
  true
rescue SystemCallError => e
  # handle file errors
  false
else
  puts "Well done, no exceptions"
ensure
  hatch_file.close if hatch_file
end
```

### Exceptions: Retrying and Rescue

Do not use exceptions for control flow, but sometimes they will affect it.

Eg: Calling an API server that fails intermittently, would like to retry a few times before propagating exception.

```ruby
def batten_hatches
  hatch_list = API.request("/hatches")
  #...
end
```

Loop based solution is messy:

```ruby
def batten_hatches
  1.upto (3) do |attempt|
    begin
      hatch_list = API.request("/hatches")
      break
    rescue RuntimeError => e
      puts e.message
      if attempt == 3
        puts "Request failed."
        raise # re-raising exception makes it propagate outside this method
      end
    end
  end
end
```

`retry` statement makes this much cleaner.
Keep track of attempts in rescue clause.
`retry` statement used within `rescue` clause -> transfers execution to beginning of begin/end block or beginning of method.

```ruby
def batten_hatches
  hatch_list = API.request("/hatches")
  #...
rescue RuntimeError => e
  attempts ||= 0
  attempts += 1
  if attempts < 3
    puts e.message + ". Retrying request."
    retry # execution goes back to batch_list = API...
  else
    puts "Request failed."
    raise
  end
end
```

**Rescue Modifier**

- Similar to `if` and `while` modifier
- Adding rescue modifier to statement, will catch any exceptions raised by statement that are instances of `StandardError` or subclasses
- If exception is caught, result of expression is result of statement following `rescue`
- Watch out this technique can obfuscate and make debugging difficult because it catches all errors
- Not recommended

```ruby
batten_hatches rescue false # if exception caught, this evaluates to false
```

### Throw and Catch

- Different flow control mechanism than raising exceptions.
- Put some code that throws in a catch block
- `catch` is a method that takes a block as a special argument (just like iterator methods like `each`)
- If `throw` statement is triggerred, corresponding `catch` block is terminated
- Argument to `catch` and first argument to `throw` must match (`:abort` symbol in example below but any arbitrary object could be used)
- Typically used to get out of nested loops
- `catch` returns second argument of `throw` if it was provided or `nil` otherwise, in example below, would be `result.message`
- If `throw` statement not triggerred, then `catch` returns result of last expression in its block, in example below, this is string `"All samples processed"`
- throw/catch works across method calls, in example below, could extract inner loop to a method
- catch calls can be nested
- Don't use often because can result in tangled looking code

```ruby
result = catch :abort do
  probes.each do |probe|
    while sample = probe.get_sample
      result = sample.process
      throw :abort, result.message if result.code != :ok
      puts result.message
      sample.store
    end
  end
  "All samples processed"
end

puts result
```

Example with inner loop extracted to method, still works

```ruby
def handle(sample)
  result = sample.process
  throw :abort, result.message if result.code != :ok
  puts result.message
  sample.store
end

result = catch :abort do
  probes.each do |probe|
    while sample = probe.get_sample
      handle(sample)
    end
  end
  "All samples processed"
end

puts result
```

### Scope

- Classes and methods introduce scope
- Other constructs - `if`, begin/end, DO NOT
- Variables defined in these constructs still available after

```ruby
if true
  a = 10
end
puts a # 10
```

Blocks DO introduce scope, variables defined within will not be visible outside:

```ruby
1.upto(10) { |i| puts i; a = 1 }
puts i # error: undefined variable
puts a # error: undefined variable
```

## Standard Types

### Booleans
