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
  - [Numbers](#numbers)
    - [Strings](#strings)
    - [String Operators and Methods](#string-operators-and-methods)
    - [Regular Expressions](#regular-expressions)
    - [Symbols](#symbols)
    - [Arrays](#arrays)
    - [Enumerable](#enumerable)
    - [Hashes](#hashes)
    - [Ranges](#ranges)
    - [Parallel Assignment](#parallel-assignment)
    - [Splat Operator](#splat-operator)
  - [Methods in Depth](#methods-in-depth)
    - [Default Parameter Values](#default-parameter-values)
    - [Variable Length Parameter Lists](#variable-length-parameter-lists)
    - [Keyword Arguments](#keyword-arguments)
    - [Method Aliasing](#method-aliasing)
    - [Operators](#operators)
    - [Method Calls as Messages](#method-calls-as-messages)
    - [method_missing](#methodmissing)
  - [More Ruby Tools: Blocks, Constants, Modules](#more-ruby-tools-blocks-constants-modules)
    - [Blocks](#blocks)
    - [Block Local Variables](#block-local-variables)
    - [Using Blocks](#using-blocks)
    - [From Block to Proc](#from-block-to-proc)
    - [Lambdas](#lambdas)
    - [Using Procs and Lambdas](#using-procs-and-lambdas)
    - [Constants](#constants)
    - [Modules](#modules)

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

- Ruby doesn't have a boolean type
- `true` is instance of `TrueClass`, `false` instance of `FalseClass`, each of which derives from `Object` class
- singleton instances
- boolean can be converted to string, checked for nil (via methods inherited from `Object`)

```ruby
true.to_s # "true"
false.nil? # false
```

## Numbers

- Represented by objects, number is like label for a corresponding object
- Can call methods in integers and floating point objects

**Integer Nubers**

![integer](doc-images/integer.png 'integer')

- Range of numbers represented by `Fixnum` limited by machine word size and Ruby build
- `Bignum` for larger numbers and only limited by available memory
- Conversion between Fixnum and Bignum automatically handled
- Integer iterals can be written as hex (start with 0x, octal start with 0 or 0o, decimal literals start with 0d or no prefix, binary literals start with 0b)
- Can use underscore to separate groups of digits for legibility `100_999`, `0b1010_1111_0110`

```ruby
0xAF    # decimal 175 (hex)
010     # decimal 8 (octal)
0o10    # decimal 8 (octal)
0d175   # decimal 175 (decimal)
0b1010  # decimal 10 (binary)
```

**Floating Point Numbers**

- Represented by `Float` class
- 15 digits of precision
- Map to machine double type
- Literals can have optional exponent `1.234`, `1.0e3`
- Must be at least one digit before and after decimal point - avoid ambiguity with method calls
- Can use underscores same as integers
- Mixing floats and integers results in float

```ruby
2.0 + 30
=> 32.0
```

Objects representing numbers are read only. Functions like `f` below don't make sense in Ruby. Instead should return a new number and assign the result.

Other objects including String and Array are mutable.

```ruby
def f(n)
  n += 100
end

a = 10
f(a)
=> 110
a
=> 10 # `a` was not modified
```

### Strings

- String class contains ~100 methods, lots of different literal forms
- Sequence of characters with associated encoding
- Can be used to represent binary sequences
- String's encoding is defined by encoding of source file its in
- Default is UTF-8 but can be modified with special comment at start of file [Example](module4/encoding.rb)
- `encoding` method outputs encoding of a given string

```ruby
puts "abc".encoding
=> #<Encoding:UTF-8>
```

**String Literals**

When assigning a literal or passing it as argument, new object of class `String` is created.

- single quote: `'Serenity'`, only allows two escape sequences
- if need to include single quote in string, escape with backslash: `'\'Serenity\''`
- include backslash by escaping it with another backslash `'Backslash: \\'`
- instead of single quotes, can use `%q` followed by delimeter. q is for quote, delimeter can be any non alpha-numeric character

```ruby
%q('Serenity', transport)
%q['Serenity', transport]
%q{'Serenity', transport}
%q<'Serenity', transport>
```

**Double Quotes**

- Use of double-quotes supports more escape sequences, eg: `\n` newline, `t` tab, `\"` double quote
- Can insert characters via octal or hec code, eg: `\100` or `x40` results in `@`
- Can insert unicode points with `\u`, eg: `\u20ac`
- Combine multiple code points with curly braces: `\u{20ac a3 a3f}`
- Allow for string interpolation, cleaner than concatenation and better performance, doesn't have to create many new string objects
- Literals can span multiple lines, new lines and indentation will be included in string

```ruby
lander_count = 10
probe_count = 20
puts "Lander count: #{lander_count}"
puts "Total units: #{lander_count + probe_count}"
```

**Heredoc**

- Useful for multi-line string with multiple quotes
- Denoted by `<<` followed by terminator, in example below, it's `EOS`
- String ends when second terminator encountered
- Terminator must be at column 1, unless include `<<-`, then terminator can be indented

```ruby
message = <<EOS
  There's no place I can be
  since I found serenity
EOS

message = <<-EOS
  There's no place I can be
  since I found serenity
  EOS
```

### String Operators and Methods

```ruby
# get character at particular position
"Hello world"[1]
=> "e"
# get substring, first arg is index to start (inclusive), second arg is length
"hello world"[1, 3]
=> "ell"
# check whether substring appears in string
"Hello world"["or"]
=> "or"
"Hello world"["zzz"]
=> nil
# Replace substring with another (only first instance)
a = "Hello Alex"
=> "Hello Alex"
a["Alex"] = "George"
=> "George"
a
=> "Hello George"
# Use multiplication operator to duplicate content of string a multiple of times
"ha " * 3
"ha ha ha "
# Percent operator produces formatted output, eg: numbers with leading zeroes
# First argument is format specifier, second argument is number
# Eg: pad to 5 digits with zeroes
"%05d" % 123
=> "00123"
# Limit total number of digits
"%.8g" % 123.123456789
=> "123.45678"
# Plus operator to concatenate strings (but prefer string interpolation)
"ab" + "cd"
=> "abcd"
# Use chars method to get array of characters in string, useful when string contains unicode
a = "~ 5\u{20ac}"
=> "~ 5€"
a.chars
=> ["~", " ", "5", "€"]
a.codepoints
=> [126, 32, 53, 8364]
a.bytes # note that unicode codepoint uses 3 bytes
=> [126, 32, 53, 226, 130, 172]
# string class has iterators: each_char, each_byte, each_codepoint
# convert case (version with ! modifies string in place, without returns modified string as new object)
a = "hello"
=> "hello"
a.upcase!
=> "HELLO"
a.downcase!
=> "hello"
```

Many methods in standard library return either a new object, or for `!`, the original object they were called on. Useful for method chaining.

```ruby
a = "  this is a sentence  "
# Chain methods to trim trailing whitespace and capitalize first letter
a.strip!.capitalize!
=> "This is a sentence"
# Replace all occurrences of a substring within a string
"<strong><em>Hi!</em></strong>".gsub("<","[").gsub(">", "]")
=> "[strong][em]Hi![/em][/strong]"
# Break up a string into array of substrings based on separator (default space)
"1 2 3".split
=> ["1", "2", "3"]
"1->2->3".split("->")
=> ["1", "2", "3"]
```

### Regular Expressions

- `Regexp` class is one of standard types built into Ruby, [docs](https://docs.ruby-lang.org/en/trunk/Regexp.html)
- [Online Ruby regex tester](https://rubular.com/)
- To construct a regex, pass a string expression to `Regexp` new method
- Can also use regex literals denoted by forward slashes: `/(\d+:\d+)(am|pm)/`
- Can also use `%r` followed by an expression (similar to `%q` for strings): `%r(\d+/\d+)`
- Just like double-quoted strings, regex patterns support interpolation of ruby expressions, escape sequences and unicode

Use `=~` operator to test for a match, regex pattern can appear on right or left of this operator
If match found, operator yields starting position of match within string, otherwise nil

```ruby
/\d+/ =~ "Level 3"
=> 6
"Level 3" =~ /\d+/
=> 6
/\d+/ =~ "Level"
=> nil
```

`!~` checks for lack of a match and yields true/false

```ruby
/\d+/ !~ "Level 3"
=> false
/\d+/ !~ "Level A"
=> true
```

Can also use `match` method, returns more detail about the match in a resulting object.
`match` is part of String and Regexp classes. Returns MatchData object.

```ruby
m = /(\d+):(\d+)/.match("Time is 12:13am")
=> #<MatchData "12:13" 1:"12" 2:"13">
# methods `pre_match` and `post_match` retrieve portions of string before and after the match respectively
m.pre_match
=> "Time is "
# square bracket syntax to get matches, 0 for the whole match, 1, 2, ... for captured subgroups
m[0]
=> "12:13"
m[1]
=> "12"
m[2]
=> "13"
m[3]
=> nil
```

When using `~=` or `match`, some global vars are set:

- `$` is string before match
- `$'` is string after match
- `$&` is entire match
- `$1`, `$2`, etc are submatches

![regexp](doc-images/regexp.png 'regexp')

Use `scan` to match multiple instances of pattern within a string -> returns array of matched substrings.

```ruby
p "Time is 12:13am".scan(/\d+/)
# ["12", "13"]
```

`gsub` is more powerful with regex, can refer to capture groups within replacements, eg: swap first and last name:

```ruby
# \1 and \2 refer to submatches in input string, must be escaped in double-quoted string
puts "Alex Korban".gsub(/([a-zA-Z]+) ([a-zA-Z]+)/, "\\2, \\1")
# Korban, Alex

# single quoted string doesn't need escape
puts "Alex Korban".gsub(/([a-zA-Z]+) ([a-zA-Z]+)/, '\2, \1')

# use blocks for more complex replacements - eg: replace password in log lines with stars
s = "Password: b1a12"
puts s.gsub(/(Password:)\s+(\w+)/) { |match| "#{$1} " + "*" * $2.length }
# Password: *****
```

### Symbols

Used to add attribute accessor methods to classes and to make methods private:

```ruby
attr_accessor :destination
private :batten_hatches
```

- Special kind of object
- Combination of constant and string (sort of like enum in Java)
- Instance of `Symbol` class
- Only created via literals - colon followed by identifier or string literal, eg: `:"abc"`
- String literal can include interpolated code, eg:

```ruby
direction = "west"
:"turn_#{direction}" # :turn_west
```

- Globally unique and immutable
- On first use, object is created behind the scenes
- When referring to same symbol, referring to same object
- Good substitute for strings when strings are used as labels (eg: passing method names to attr_accessor or passing symbol to catch block). Better to use symbol because string literal would create a new string object each time
- Comparing symbols - compare object id's, whereas to compare strings, need to compare contents which is more computationally intensive
- Symbols more efficient - memory use and performance
- Also good for hash keys (covered later)
- Also can be used as function parameter where param can be one of small set of values such as sort order, color from a predefined set, etc.

```ruby
traverse_tree(:depth_first )
```

Convert from string to symbol and vice versa:

```ruby
# to_s method converts symbol to its corresponding string
:abc.to_s
=> "abc"
# to_sym method of string class performs reverse conversion
"abc".to_sym
=> :abc
```

### Arrays

- Instances of `Array` class
- Literal is sequence of comma separated elements wrapped in square brakcets, eg: `[1, 2, 3]`
- Stores references to objects
- Can contain objects of different types, eg: `[1, "Z", Object.new]`
- Careful when cloning arrays due to storage of references
- If need deep clone, have to write custom implementation

**Array Creation**
To create empty array most common is empty array literal rather than `Array.new` which is for more complex initialization

```ruby
arr = []
=> []
# create array with specified number of elements, all initialized to nil
arr = Array.new(3)
=> [nil, nil, nil]
# second arg is default value...
arr = Array.new(3, true)
=> [true, true, true]
# ...however, each element refers to same object
arr = Array.new(3, "abc")
=> ["abc", "abc", "abc"]
arr.first.upcase!
=> "ABC"
arr
=> ["ABC", "ABC", "ABC"] # all of them got converted cause they're referring to same object
# to work around this, use block form of new, then every element will refer to a different object
arr = Array.new(3) { "abc" }
=> ["abc", "abc", "abc"]
arr.last.upcase!
=> "ABC"
arr
=> ["abc", "abc", "ABC"]
# block form of new also useful for constructing multi-dimensional arrays
arr = Array.new(3) { Array.new(3) }
=> [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
# %w creates array of strings from string of space separated words
%w(array of words)
=> ["array", "of", "words"]
# Use backslash to insert literal space (escape sequences same as for single quoted strings)
%w(array\ of words)
=> ["array of", "words"]
# Use %W to get same escape sequences and string interpolation like double quoted strings
%W(1\tarray of #{2+2} words)
=> ["1\tarray", "of", "4", "words"]
# Use %i for array of symbols
%i(up down left right)
=> [:up, :down, :left, :right]
```

**Array Methods**

```ruby
arr = %i(up down left right)
arr.size
=> 4
arr.empty?
=> false
# access any element using 0 based index in square brackets
arr[1]
=> :down
# negative 1 based index to access elements in reverse order
# -1 is index of last element
arr
=> [:up, :down, :left, :right]
arr[-1]
=> :right
# -2 is index of second last element
arr[-2]
=> :left
# slice array using square brackets
arr = [1, 2, 3, 4, 5]
=> [1, 2, 3, 4, 5]
# return slice of array starting at index 1 and ending at index 3 (inclusive)
arr[1..3]
=> [2, 3, 4]
# can use reverse index for either start or end of slice
arr[1..-2]
=> [2, 3, 4]
# start at 4th last element (1 based) and go up to 4th element (0 based)
arr[-4..4]
=> [2, 3, 4, 5]
# use square brackets operator to set elements of array
arr[1] = "string value"
=> "string value"
arr
=> 1, "string value", 3, 4, 5]
# use esquare brackets to replace portions of array
arr[2..3] = [:east, :west]
=> [:east, :west]
arr
=> [1, "string value", :east, :west, 5]
# append elements to array (array grows/shrinks as elements added/removed)
arr << 10
=> [1, "string value", :east, :west, 5, 10]
# join two arrays with + operator
[1, 2] + [3, 4]
=> [1, 2, 3, 4]
# duplicate elements using * operator
[1, 2] * 3
=> [1, 2, 1, 2, 1, 2]
# if string is second arg to * operator, array converted to string with second arg as separator
[1, 2] * ","
=> "1,2"
# use minus operator to delete one or more elements by value
# any elements appearing in first array will be removed from first array
[1, 2, 3, 2, 5] - [2, 5]
=> [1, 3]
```

### Enumerable

- `Enumerable` module is part of array interface
- Modules are a way to package a set of methods and constants
- Enumerable has ~50 methods
- Makes working with collections very powerful

```ruby
# Use `map` method to apply a transformation to each element of a collection, returns transformed array.
# map accepts a block - eg: multiply each element in array by 10
[1, 2, 3].map { |v| v * 10 }
=> [10, 20, 30]
# Use `reduce` method to derive a value from all the elements
[1, 2, 3].reduce(0) { |sum, v| sum + v }
=> 6
# Sort collection
[10, 1, 7].sort
=> [1, 7, 10]
# Select returns portion of collection containing elements which match criteria defined by select's block argument
[1, 2, 3, 4, 5].select { |n| n.even? }
=> [2, 4]
# Iterate over each consecutive block of 2 elements in array
[1, 2, 3, 4, 5].each_cons(2) { |v| p v }
[1, 2]
[2, 3]
[3, 4]
[4, 5]
 => nil
```

### Hashes

- Due to Ruby's dynamic nature, Arrays and Hashes are very versatile, can be used to represent almost any data
- Hash: Ordered collection of key/value pairs represented by hash class
- Keys and values can be arbitrary objects
- Keys must be unique
- Hash literal denoted by curly braches: `h = {}`
- Inside braces, commas separate each k/v pair and arrows point from key to value: `h = {"min" => 0, "max" => 100}`
- Common to use symbols as hash keys, shortcut syntax: `h = {min: 0, max: 100}`
- Think of hash like array but with arbitrary object indexes instead of integers

```ruby
h = {a: "a", b: "b"}
=> {:a=>"a", :b=>"b"}
# access hash elements by key using square brackets operator
h[:a]
=> "a"
# replace value
h[:a] = "z"
=> "z"
h
=> {:a=>"z", :b=>"b"}
# element is added if specify a key that is not already in hash
h[:c] = "v"
=> "v"
h
=> {:a=>"z", :b=>"b", :c=>"v"}
# Using a key that isn't in hash to get an element returns nil
h[:x]
=> nil
# Specify different default value using Hash.new, eg: to have 0 returned instead of nil
# Works same as arrays -> same object reference is returned each time, if want different, use block version of new method
h = Hash.new(0)
=> {}
h[:a]
=> 0
# Iterate over hash elements using `each`, notice `v` consists of both key and value
h = {a: "a", b: "b"}
=> {:a=>"a", :b=>"b"}
h.each { |v| p v }
[:a, "a"]
[:b, "b"]
 => {:a=>"a", :b=>"b"}
# Iterate, separating key and value
h.each { |k, v| puts "Key is #{k}, Value is #{v}" }
Key is a, Value is a
Key is b, Value is b
 => {:a=>"a", :b=>"b"}
# Hashes are ordered, each lists entries in the same order in which they were added to the hash
# Hash class includes Enumerable module -> all methods available to arrays are also available to hashes
```

### Ranges

- Can be created via literal -> two objects separated by two dots: `1..5 # [1, 5]` This is inclusive range, upper boundary included
- Or 3 dots: `1...5 # [1, 5)` Exclusive range, upper boundary excluded
- Includes enumerable module
- To invoke methods on range, enclose in brackets:

```ruby
(1..10).class
=> Range
(1..10).begin
=> 1
(1..10).end
=> 10
# include tests if value is part of range
(1..10).include?(11)
=> false
# map iterates over array representation of range
(1..10).map { |v| v * 2 }
=> [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
# ranges can consist of string values
("aa".."ad").each { |v| puts v }
aa
ab
ac
ad
 => "aa".."ad"
# float range (but can't iterate)
(1.0..5.0)
=> 1.0..5.0
```

- Ranges can be used in case statement
- Similar to class type matching
- Range class has custom implementation of `===` operator that checks whether supplied value is within range

```ruby
puts case sample_reading
     when 0..100 then "below normal"
     when 101..150 then "normal"
     else "excessive"
     end
```

### Parallel Assignment

- Related to standard collection types
- Assign to multiple variables in a single statement

```ruby
# If right side of assignment is comma separated list -> converted to array whose elements are assigned to variables on the left
a, b = 1, 2  # a == 1, b == 2
# If assign comma separated list to single variable, list converted to array
a = 1, 2, 3, 4  # a == [1, 2, 3, 4]
# Right side of parallel assignment can be an actual array - useful when function returns multiple values
# No need to create a temporary array holding results of function, can assign directly like so:
def get_values
  [1, 2, 3, 4]
end
a, b = get_values  # a == 1, b == 2
# If want to assign first and last values but don't care about middle, use `_`
# Unused variable warning is suppressed for `_`
first, _, _, last = get_values  # first == 1, last == 4
```

### Splat Operator

- Can combine parallel assignment with splat operator `*`
- One value on left side of assignment can have splat operator applied to it -> accumulates as many elements as possible in array

```ruby
def get_values
  [1, 2, 3, 4]
end

# If splat is last, gets all values remaining
a, *b = get_values  # a == 1, b == [2, 3, 4]
# If splat is not last, is greedy -> take as much as possible while leaving enough for following variables
a, *b, c = get_values  # a == 1, b == [2, 3], c == 4
```

Splat can appear on right side of assignment -> objects its supplied to are converted to arrays, which have their elements expanded inline.

```ruby
# use range to assign elements from a sequence to variables
a, b, c = *1..3  # a == 1, b == 2, c == 3
# Use array as part of sequence to be assigned
first, _, _, _, last = 1, 2, *[3, 4, 5]  # last == 5
# Above can be simplified by using splat by itself instead of dummy vars
# Splat can appear on both sides of assignment
first, *, last = 1, 2, *[3, 4, 5]  # last == 5
```

Another use for splat operator

```ruby
r = (0..10)
=> 0..10
# Using splat operator on range inside array literal -> range converted to series of elements inserted into array
[1, 2, *r]
=> [1, 2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# Same concept works on hashes
h = {a: "a", b: "b"}
=> {:a=>"a", :b=>"b"}
# Using splat on hash in array literal results in two arrays representing keys and values
[*h]
=> [[:a, "a"], [:b, "b"]]
```

Splat operator works on any class that implements `to_a` method [Example](module4/splat.rb)

## Methods in Depth

### Default Parameter Values

- Cannot define two methods with same name but different parameter lists
- Use default arguments for flexible interfaces not forcing caller to specify everything
- Default values for parameters specified in function definition with `=` and expression
- Expression not limited to simple value, could be another method call or conditional logic
- Default values are calculated when method is called, not when method is defined

```ruby
def produce_spaceshp(type = :freighter, size = :xl)
  # ...
end

def produce_spaceshp(type = :freighter, size = calc_default_size(type))
  # ...
end

def produce_spaceshp(type = :freighter, size = (type == :freighter ? :xl : m))
  # ...
end
```

- Optional parameters don't have to be at the end of parameter list
- If required parameters follow a list of optional, will be correctly assigned
- Can't intermingle optional and required params arbitrarily

```ruby
def produce_spaceship(type = :freighter, size = :xl, engine_count)
  # ...
end

factory.produce_shaceship(4) # sets engine_count to 4
```

### Variable Length Parameter Lists

- Some methods need to take an arbitrary number of args
- Use splat

```ruby
# first argument this is called with gets assigned to days_to_complete
# remainder of arguments get assigned to types array
def produce_fleet(days_to_compete, *types)
  #...
end

produce_fleet(10, :freighter, :freighter, :explorer)
# days_to_complete === 10, types == [:freighter, :freighter, :explorer]
```

- Array argument doesn't have to be last in argument list
- Parameter list wiht splat works the same as list of variables on LHS of parallel assignment
- Can combine with default parameter values
- Optional params should come before array param
- Args passed to method first used to provide values for optional params, and remaining are assigned to array parameter

```ruby
def produce_fleet(days_to_complete = 10, *types)
  #...
end

# Call with no args, then days_to_complete == 10, types == nil
produce_fleet
# Call with args, then days_to_complete == 15, types == [:freighter, :freighter, :explorer]
produce_fleet(15, :freighter, :freighter, :explorer)
# BUT cannot omit first argument because days_to_compete will always get assigned to whatever is passed as first arg
produce_fleet(:freighter, :freighter, :explorer) # days_to_complete == :freighter -> not intended
```

- Splat operator can be used when calling a method.
- Converts argument its applied to into array by calling arguments `to_a` method.
- Elements of array inserted into argument list
- Splat op in method calls is same as when splat used on RHS of parallel assignment

```ruby
ship_types = [:freighter, :freighter, :explorer]
produce_fleet(15, *ship_types)
```

### Keyword Arguments

- When method takes a lot of parameters, can become difficult to read - what does each arg represent? `produce_shaceship(:frieghter, :m, 100, 4)`
- Keyword arguments used to make calling methods more legible -> provide argument name followed by `:`, then value
- When defining a method with keyword args, params must have default values
- Keyword args can be supplied to a method in different order than defined (because can be identified by name)

```ruby
def produce_spaceship(type: freighter, size: xl, fuel_tank_volume: 400, engine_count: 2)
  #...
end
produce_spaceship(type: :frieghter, size: :m, fuel_tank_volume: 100, engine_count 4)
```

Keyword args can co-exist with regular args, as long as the regular parameters are defined first

```ruby
# type is a regular parameter with default value, size and engine_count are keyword args
def produce_spaceship(type = :frieghter, size: :m, engine_count: 2)
  # ...
end
```

- If try to pass keyword args to method where those are not part of its definition, get error
- But adding double splat parameter to end of parameter list in method definition - collects any keyword arguments that aren't part of definition
- Double splat parameter gets assigned hash of the "undefined" keyword args
- Useful for method supporting options

```ruby
def produce_spaceship(type = :freighter, size: :m, **custom_components)
  # standard
  components = {
    engine: :standard,
    seats: :standard,
    subwoofer: none
  }
  # custom
  # merge! will override values with dupe keys
  components.merge!(custom_components)
end

# invoke with custom options for engine and seats
produce_spaceship(:yacht, size: :s, engine: rolls_royce, seats: :leather)
```

Even cleaner, first construct a hash, and then pass to method that has double splat arg:

```ruby
build_params = {size: :s, engine: rolls_royce, seats: :leather}
produce_spaceship(:yacht, build_params)
```

Use double splat operator to have variable its applied to treated as a hash and combined with other keyword args:

```ruby
custom_components = {seats: :leather}
produce_spaceship(:yacht, size: :s, **custom_components)
```

### Method Aliasing

[Example](module5/alias_method.rb)

- Use when overriding a method but need to access old version
- When overriding a base class method, use `super` to call method from base class
- For monkey patching, need to use aliasing
- `alias_method` method is for creating a copy of a method with another name

```ruby
class String
  def space_out
    chars.join(" ")
  end

  # create copy of `size` method named `original_size`
  alias_method "original_size", "size"

  # override size, invoking original_size
  def size
    original_size * 2 - 1
  end
end

puts "abc".space_out # a b c
puts "abc".size # 5
```

### Operators

- Can define custom versions of many operators when writing a class
- Many operators are actually methods with syntactic sugar so using them doesn't look like calling a method
- Logical operators are NOT methods: `&&`, `||`, `not`, `and`, `or`, `?:`
- Assignment operators are NOT methods: `=`, `+=`, `-=`, `*=`, `/=`, `%=`, `**=`, `&=` `|=`, `^=`, `>>=`, `<<=`, `&&=`, `||=`
- All other operators (square brackets, comparison, mathematical, bitwise) are methods - can write your own implementations in a class or override standard implementations.

[Example 1](module5/operators.rb)

Careful with custom operators - can make code cryptic and behave unexpectedly.
Use operator overloading sparingly - only when makes code more readable.

### Method Calls as Messages

- Calling method in Ruby is accomplished by sending message to object
- Object looks up corresponding method, and if found, executes it
- Methods === Message Handlers
- Object method is called on === Receiver
- Object class has a `send` method: `a.send(:size)` - send message as symbol, along with any parameters

![method call message](doc-images/method-call-message.png 'method call message')

Convenient, reduces boilerplate, eg: invoking methods in response to user input:

```ruby
# unweildly case statement
case input
when :up_arrow then ship.tilt_up
when :down_arrow then ship.tilt_down
when :left_arrow then ship.turn_left
when :right_arrow then ship.turn_right
end

# better solution - define hash mapping all potential user input to methods
handlers = {
  up_arrow: :tilt_up,
  down_arrow: :tilt_down,
  left_arrow: :turn_left,
  right_arrow: :turn_right
}
# dispatch call reduced to single statement
ship.send(handlers[input])

# If your class already has a method named `send` for a differnet purpose, use Object class send alias `__send__`
ship.__send__(handlers[input])
```

**Methods Outside Classes**

When a method is called within a class, it's called on `self`, an _implicit receiver_

```ruby
class Spaceship
  def launch
    batten_hatches # called on self, implicit receiver
    # ...
  end
end
```

- What about methods defined outside of class, who is the receiver in that case?
- Every Ruby program has default object `main`
- Outside any other context, self refers to main
- Adding a method, eg `double` outside of a custom class adds it to Object class -> available throughout program
- Calling such a method is called on self, where self is the main object
- No such thing as "free" methods
- Methods such as `puts`, `p`, `raise` - part of Object class because it includes `kernel` module defining these methods

```ruby
2.6.0 :001 > self
 => main
2.6.0 :002 > self.class
 => Object
```

### method_missing

[Example](module5/method_missing.rb)

- Technique for metaprogramming in Riby
- What happens when message sent to object but it can't find corresponding method `ship.xxyyzz`
- Get `NoMethodError`
- When Ruby goes through class hierarchy and doesn't find method, invokes method named `method_missing`
- Default implementation of `method_missing` (defined in BasicObject class) raises `NoMethodError` exception
- Can override `method_missing` with custom implementation
- Caution can make code difficult to debug and cause performance issues with lots of methods routed this way

**Other Metaprogramming Facilities**

- const_missing (counterpart to method_missing but for constants)
- adding and removing methods at runtime
- `inherited` method - executed everytime a subclass of class is created

## More Ruby Tools: Blocks, Constants, Modules

### Blocks

- Piece of code between do/end keywords or curly braces
- Convention: do/end used for multi-line blocks, curly braces used for single line
- Only way to use blocks is to pass them as argument to method
- Some methods can take a block as a special argument that comes after the regular arguments
- Methods can execute block code once or multiple times
- Method can pass arguments into blocks when it executes
- Block arguments specified between vertical bars at start of block

```ruby
[1, 2, 3].each do
  puts "This is Sreentiy, please respond"
end

ships = Spaceship.all
ships.each { |ship| puts ship.name }
```

**Invoking Blocks**

- Write a method that accepts a block as an argument
- Simplest case, use `yield` keyword to execute block at some point in method

```ruby
class Spaceship
  def debug_only
    reutrn nil unless @debug
    return nil unless block_given?
    puts "Running debug code..."
    yield # block executed here
  end
end

# invoke method with no args -> does nothing
ship.debug_only

# invoke method with block -> executes if debug mode is true
ship.debug_only do
  puts "This is debug output"
end
```

If block requires arguments, pass them to `yield`

```ruby
class Spaceship
  def debug_only
    reutrn nil unless @debug
    return nil unless block_given?
    puts "Running debug code..."
    yield @debug_attrs # block executed here with args
  end
end

# invoke method with block -> executes if debug mode is true
ship.debug_only do |attrs|
  puts "Debug attr values: #{attrs.inspect}"
end
```

- Use of yield is similar to method call
- Value of yield is result of executing last expression in block

**Block Arguments**

[Example](module6/block_args.rb)

- Similar to method arguments
- Can have default values
- Can use keyword arguments
- Can use array arguments with splat operator

### Block Local Variables

[Example](module6/block_local_vars.rb)

- What happens when variable in block has same name as variable in outer scope?
- Block arguments shadow same name variables in outer scope
- Variables defined in block body don't shadow outer scope - problem - will overwrite variable
- Block local variables solve this issue: Declare variable as block local in variable argument list - list local vars after `;` in argument list

### Using Blocks

- Blocks are closures (sort of)
- Carry their context with them including local vars, class variables, constants and value of self
- Block executes with all of the above as its context, convenient, don't need to pass in everything as arguments
- If block contains return statement, it's executed in the scope block was defined in - can be an issue, scope may no longer exist by the time block is executing [Example](module6/block_return.rb)
- Memory use: Since blocks carry their context with them, can prevent large objects from being garbage collected because they're still referred to by the block

**Uses for Blocks**

- Factor out common code into methods
- Enable iterator methods - powerful alternative to regular loops
- Help to eliminate boilerplate, such as implementation of ommon idiom: Execute Around

```ruby
# Time how long any arbitrary block of code took to execute
def with_timing
  start = Time.now
  if block_given?
    yield
    puts "Time taken: #{Time.now - start} seconds"
  end
end

def run_operation_1
  sleep(1)
end

def run_operation_2; end

# Run methods in a block passed to wtih_timing method
with_timing do
  run_operation_1
  run_operation_2
end
```

**Transaction Idiom**

Make sure file is closed after being processed, or wrap db queries in a transaction.

```ruby
class Database
  def transaction
    start_transaction
    begin
      yield
    rescue DBError => e
      rollback_transactionl
      log_error e.message
      return
    end
    commit_transaction
  end
end

DB.transaction do
  # update multiple records
end
```

**Block Limitations**

- Can only pass one block into a method
- Blocks can't be passed around between methods
- Passing the same block to sevealmethods isn't DRY

### From Block to Proc

[Example](module6/proc.rb)

Create a proc:

1. Precede block name in method with `&` - converts block to proc

```ruby
def debug_only(param = nil, &block)
  puts "Param class: #{param.class}"
  puts "Block class: #{block.class}" if block_given?  # block variable is instance of type Proc
end
```

2. Pass a block to `Proc.new` or or kernel method `proc` which is an alias

```ruby
p = Proc.new {|_bla| puts "I'm a proc that says #{blah}!"}
p = proc {|_bla| puts "I'm a proc that says #{blah}!"}
```

To execute code stored in proc

```ruby
p.call "yay!"
p.yeild "wow!"
p.("nothing")
p["hello"]
```

When blocks are converted to named object, easy to pass between different methods, refer to them with a variable.

Can use for callbacks, lazy initialization -> store proc in instance variable, and call it later, eg when need to invoke a callback or run initialization.

### Lambdas

- Another way to convert block to an object
- Object class method `lambda` converts a block to a Proc object
- Resulting object is instance of Proc class, but behaves differently

```ruby
lmb = lambda {|bla| "I'm also a proc, and I say #{blah} }

# more convenient syntax: stabby lambda, note parameter is listed outside of block body
# NO SPACE between arrow and parameter list
also_lmb = ->(bla) { "I'm also a proc, and I say #{blah} }
```

**Differences between Procs and Lambdas**

- Generally procs behave similar to blocks - support dropping code into a method, but procs more flexible because they can be named and passed around like regular objects
- Lambdas are like anonymous methods
- Lambdas are strict about their arguments
- `return` and `break` behave differently in procs vs lanbdas
- `next` is the same in blocks, procs and lambdas -> returns control back to caller of block, proc or lambda

**Differences in Argument Handling**

- Passing too few or too many arguments to lambda expression causes exception
- Passing too many arguments to blocks or procs, are discarded. Missing arguments are set to `nil`

**Differences in return and break Handling**

- `return` statement in block or proc executed in scope in which proc was defined, can cause issue if that scope no longer exists, eg: passing proc from one thread to another
- `break` outside loop not allowed in a proc, but is allowed in a regular block
- Recommended: Don't use `return` or `break` in procs. Avoid return statement in blocks
- Lambdas: `break` and `return` return control to caller

### Using Procs and Lambdas

- Check number of arguments proc or lambda expects with `arity` method
- If fixed number of args expected, returns positive integer
- If some args are optional, returns number of non optional args + 1, with a minus sign

```ruby
proc {|a, b|}.arity  # => 2
proc {|a, *b, c|}.arity  # => -3
```

Proc class implements triple equals `===` operator, which executes code stored in the proc, therefore can use procs and lambdas in case statement.

```ruby
weekend = proc {|time| time.saturday? || time.sunday?}
weekday = proc {|time| time.wday < 6}

# Passes Time.now to each proc, if proc returns true, executes corresponding case statement
case Time.now
when weekend then puts "Wake kup at 8:00"
when weekday then puts "Wake up at 7:00"
else puts "No wake up calls outside of time"
end
```

**Symbol to Proc Conversion**

Given a method that takes a regular parameter and a block, if method is invoked with a proc, it will be treated as a regular parameter. To tell the method it should be treated as a block, need to invoke method with `&proc`.

When `&` is used, Ruby will attempt to coerce the passed in object into a proc if it isn't already, by invoking `to_proc` method on object.

```ruby
def debug_only(param = nil, &block)
  puts "Param class: #{param.class}"
  puts "Block class: #{block.class}" if block_given?
end

p = Proc.new {|a| puts "I'm a proc that says #{a}"}

debug_only(p) # param == p
debug_only(&p) # param == nil, block == p
```

Convert array of strings to upper case. Can either pass a block to array `map` method
OR
Shortcut is to pass a symbol with ampersand, telling Ruby to coerce it to a proc. This works because Ruby will invoke `to_proc` method on the symbol. The symbol class to_proc method, returns a proc which takes an argument and sends symbol to it as name of method to call.

```ruby
names = ["flying dutchman", "viking", "vagabond"]
=> ["flying dutchman", "viking", "vagabond"]
upper_names = names.map { |name| name.upcase }
=> ["FLYING DUTCHMAN", "VIKING", "VAGABOND"]
# shortcut
upper_names = names.map(&:upcase)
=> ["FLYING DUTCHMAN", "VIKING", "VAGABOND"]
```

### Constants

- Use rather than symbol when need something that refers to actual value
- Similar to variable - also a reference to an object
- Name starts with upper case, eg: `MAX_SPEED = 1000`, by convention name the whole thing in upper case with words separated by underscore
- Class names are constants (which is why they always start with upper case)
- Constant created by assigning a value to it (same as variable)
- Not strictly enforced, can assign a different object to it although will get warning
- Use `freeze` method to prevent object from being modified, but not used often in practice (causes runtime error exception if try to modify object)
- Once frozen, cannot unfreeze, but can check `frozen?` method
- Even if frozen, can still modify objects it refers to (eg: when freezing array)

```ruby
MAX_SPEED = 100
=> 100
MAX_SPEED = 1000
(irb):5: warning: already initialized constant MAX_SPEED
(irb):4: warning: previous definition of MAX_SPEED was here
=> 1000
TYPES = []
=> []
TYPES << "freighter"
=> ["freighter"]
TYPES.freeze
 => ["freighter"]
# try to add another element after freezing
TYPES << "foo"
Traceback (most recent call last):
        4: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `<main>'
        3: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `load'
        2: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        1: from (irb):9
FrozenError (can't modify frozen Array)
TYPES.frozen?
=> true
TYPES[0].upcase!
=> "FREIGHTER"
TYPES
=> ["FREIGHTER"]
```

**Scope**

- If constant defined outside class or module, accessible throughout program
- If defined inside class or module, can access anywhere inside that class or module
- If need to access it from outside, use scope resolution operator (`::`) along with class name
- Can also use `::` operator to add constants from outside class
- Cannot define constants inside methods

```ruby
class A; MIN_SPEED = 0; end
=> 0
MIN_SPEED
Traceback (most recent call last):
        4: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `<main>'
        3: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/bin/irb:23:in `load'
        2: from /Users/dbaron/.rvm/rubies/ruby-2.6.0/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        1: from (irb):14
NameError (uninitialized constant MIN_SPEED)
Did you mean?  MAX_SPEED
A::MIN_SPEED
=> 0
A::MAX_SPEED = 100
=> 100
```

### Modules

- Similar to classes but cannot be instantiated
- Defined using `module` keyword
- Can contain methods, constants, classes, other modules

```ruby
module SpaceStuff
end
```

**Namespacing**

Used for namespacing - eg: put all api related methods in API module. Need to add all methods at module level - prefix names with `self.`

```ruby
module API
  def self.hatch_list
    # retrieve hatch list
  end
end

# invoke module method the same way as class method
hatches = API.hatch_list
```

If classes are in module, access same way as constants, using scope operator `::`

```ruby
module SpaceStuff
  class Spaceship
  end
end

ship = SpaceStuff::Spaceship.new
```

Modules can be nested for more complex code organization

```ruby
module SpaceStuff
  module API
    def self.hatch_list
      # retrieve hatch list
    end
  end
end

hatches = SpaeStuff::API.hatch_list
```

**Mixins**

- Second purpose of modules is to mix in to classes, adding functionality to them
- eg: enumerable module
- Mixins included in classes
- Class can include multiple modules (aka mixins) -> Ruby's alternative to multiple inheritance
- Mixins usually contain instance methods whereas namespace modules do not

```ruby
module AirControl
  # air pumping, maintenance and regeneration
  def measure_oxygen
    #...
  end
end

class Spaceship
  include AirControl # mixin the AirControl module
  #...
end

ship = Spaceship.new
ship.measure_oxygen # AirControl methods are now available on Spaceship instances
```

Modules slotted into inheritance hierarchy

```ruby
class Spaceship
  include AirControl
  include Docking
  #...
end
```

![mixins](doc-images/mixins.png 'mixins')

- Order in inheritance diagram is significant.
- Modules become most immediate ancestors of class
- Ruby looks up method definitions first in modules, then further up inheritance chain
- If two modules contain method with same name, last one wins (AirControl in example above)
- Simplifies class hierarchy - rather than factoring out common code into a super class, simply place it in a module and include it wherever needed

**Mixing in Class Methods**

Use `extend` instead of `include`

```ruby
module Docking
  def get_docking_params
    # returns params common to all spaceships
  end
end

class Spaceship
  extend Docking
end

# Instance methods from module now available as class method
Spaceship.get_docking_params
```

Cannot inject combination of class and instance methods into a class. Workaround is to wrap class methods in `ClassMethods` module. Then include the main module, and extend the ClassMethods submodule

```ruby
module Docking
  module ClassMethods
    def get_docking_params
      # returns params common to all spaceships
    end
  end
  def dock
    #...
  end
end

class Spaceship
  include Docking
  extend Docking::ClassMethods
end
```

Very common for mixins to include combination of instance and class methods. To avoid having to both `include` and `extend` mixin, define `included` hook in mixin which will run whenever mixin is included in a class

```ruby
module Docking
  module ClassMethods
    def get_docking_params
      # returns params common to all spaceships
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def dock
    #...
  end
end

class Spaceship
  include Docking
end
```

**Instance Variables in Modules**

- Modules can include attribute accessor definitions
- Could have name clash if methods in different modules use the same name -> careful when naming variables

```ruby
module AirControl
  attr_accessor :oxygen_level

  def measure_oxygen
    #...
    self.oxygen_level = measured_value
  end

  def start_pump
    # instance variable created in object this was called on
    @pump_status = :started
  end
end
```
