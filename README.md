<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

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
