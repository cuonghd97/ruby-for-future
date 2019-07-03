# 4 Khái niệm cơ bản của hướng đối tượng(Ngôn ngữ ví dụ Ruby)  
+ Trừu tượng
+ Đa hình
+ Đóng gói
+ Thừa kế
Định nghĩa một đối tượng:  
```
class Foo
end

bar = Foo.new
```  
### Phương thức khởi tạo
Phương thức này được gọi tự động khi tạo một đối tượng
Ví dụ:  
```
class Foo
    def initialize
        puts "Initialize!"
    end
end
Foo.new
```  
Các thuộc tính của một đối tượng là các biến, hay còn được gọi là các biến instance. Mỗi đối tượng đều có thuộc tính riêng nó  
```
class Person
    def initialize name
        @name = name
    end
    
    def get_name
        @name
    end
end

p1 = Person.new "cuong"
p2 = Person.new "duc"

puts p1.get_name // cuong
puts p2.get_name // duc
```  
### Các phương thức 
Là các hàm được định nghĩa bên trong 1 lớp  
```
class Person
    def initialize name
        @name = name
    end

    def get_name
        @name
    end
end
per = Person.new
```
Có 2 cách gọi phương thức:  
+ Cách 1 phổ biến nhất.  
`puts per.get_name`
+ Cách 2:  
`puts per.send :get_name`  

```
class Circle
    
    @@PI = 3.141592
 
    def initialize
        @radius = 0
    end
 
    def set_radius radius
        @radius = radius
    end
 
    def area
        @radius * @radius * @@PI
    end
 
end
 
 
c = Circle.new
c.set_radius 5
puts c.area
```  
Trong đó biến `@@PI` là biến class tức là biến dùng chung cho tất cả các phương thức trong đối tượng  

### Quyền truy cập
Có 3 loại quyền truy cập khác nhau trong Ruby: public, protected, private  
+ public
```
class Foo
    def method1
        puts "method1 called"
    end
    public
        def method2
            puts "method2 called"
        end

        def method3
            puts "method3 called"
            method1
            self.method1
        end
end

bar = Foo.new

bar.method1
bar.method2
bar.method3
```  
Các phương thức mặc định là public, ta cũng có thể chỉ định phương thức nào là public bằng từ khóa `public`  

+ private
```
class Some

    def initialize
        method1
        # self.method1
    end

    private

     def method1
         puts "private method1 called"
     end

end


s = Some.new
```  
Để chỉ định phương thức `private` ta dùng từ khóa private. Các phương thức `private` chỉ có thể được gọi trong phần định nghĩa lớp nhưng không được sử dụng từ khóa `self`  

+ Protected
```
class Some
     
    def initialize
        method1
        self.method1
    end
 
    protected
     
     def method1
         puts "protected method1 called" 
     end
            
end
 
 
s = Some.new
```  
Tương tự như private. Nhưng `protected` khác `private` ở chỗ là có thể truy cập được với từ khóa `self`  

## THỪA KẾ
Là tính năng cho phép định nghĩa các lớp dựa trên các lớp đã có. Lớp thừa kế từ một lớp khác được gọi là lớp dẫn xuất, lớp được lớp khác thừa kế gọi là lớp cơ sở. Lớp dẫn xuất thừa hưởng các thành phần của lớp cơ sở và có thể thêm các thành phần của riêng chúng  
```
class Foo
    def initialize
        puts "Foo created"
    end
end

class Bar < Foo
    def initialize
        super
        puts "Bar created"
    end
end

Foo.new
Bar.new
```
Một lớp có thể có nhiều lớp cơ sở. Mỗi lớp trong ruby đều có phương thức `ancestors`, phương thức này trả về danh sách các lớp cơ sở của nó.  
```
class Being
end

class Living < Being
end

class Mammal < Living
end

class Human < Mammal
end


p Human.ancestors
```  
Cả 3 loại public, protected, private đều được truyền lại cho lớp con :)  
### Phương thức super
```
class Base
    
    def show x=0, y=0
        p "Base class, x: #{x}, y: #{y}"
    end
end
 
class Derived < Base
 
    def show x, y
        super
        super x
        super x, y
        super()
    end
end
 
 
d = Derived.new
d.show 3, 3
```  
Gọi super trong phương thức show ở lớp con sẽ gọi đến phương thức show ở lớp cha. Nếu phương thức cha có nhận tham số mà chúng ta không truyền vào ở phương thức super thì phương thức này sẽ tự động nhận tham số của phương thức con, tức là các tham số truyền vào phương thức con sẽ tự động truyền vào trong lời gọi của phương thức super luôn. Hoặc chúng ta có thể gọi super() để không truyền một tham số nào cả.  

### Truy xuất thuộc tính
Tất cả các thuộc tính trong ruby đều là private, thực tế ta sẽ định nghĩa thêm 2 phương thức `getter` và `setter` mục đích là để truy xuất dữ liệu và chỉnh sửa chúng  
```
class Book
   attr_accessor :title, :pages
end
b1 = Book.new
b1.title = "Hidden motives"
b1.pages = 255
p "The book #{b1.title} has #{b1.pages} pages"
```  
Phương thức `attr_accessor` sẽ tạo luôn cả 2 phương thức `getter` và `setter`  

### Overload operator
```
class Circle
    
    attr_accessor :radius
     
    def initialize r
        @radius = r
    end
 
    def +(other)
        Circle.new @radius + other.radius
    end
     
    def to_s
        "Circle with radius: #{@radius}"
    end
end
 
 
c1 = Circle.new 5
c2 = Circle.new 6
c3 = c1 + c2
 
p c3
```  
Overload operator có thể dùng chung cho nhiều kiểu dữ liệu khác nhau, giống như chúng ta có nhiều phương thức và mỗi phương thức nhận nhiều tham số khác nhau vậy  

Lớp `Circle` có toán tử:  
```
def +(other)
    Circle.new @radius + other.radius
end
```  
### Phương thức class
Trong ruby có 2 loại phương thức là phương thức `class` và phương thức `instance`  
Phương thức instance là phương thức riêng của từng đối tượng, trong khi phương thức class là phương thức dùng chung  
```
class Circle
     
    def initialize x
        @r = x
    end
    
    def self.info
       "This is a Circle class"
    end
     
    def area
        @r * @r * 3.141592
    end
 
end
 
 
p Circle.info
c = Circle.new 3
p c.area
```  
Phương thức instace không có từ khóa sefl vào trước tên phương thức, còn phương thức class có thêm từ khóa sefl  
Để gọi phương thức instance thì chúng ta phải tạo một đối tượng rồi gọi từ tên đối tượng đó, còn phương thức class ta gọi thẳng từ tên lớp  
Chúng ta có 3 cách tạo ra phương thức class:  
```
class Wood
    def self.info
        "this is wood class"
    end
end

class Brick
    class << self
        def info
            "this is brick class"
        end
    end
end

class Rock
end

def Rock.info
    "this is rock class"
end

p Wood.info
p Brick.info
p Rock.info
```  

## Đa hình
Là tính năng cho phép chúng ta thực thi toán tử hay phương thức với nhiều kiểu dữ liệu khác nhau. Nói một cách tổng quát thì đa hình là tính năng cho phép định nghĩa lại các phương thức ở lớp con  
```
class Animal
    def make_noise
        "some noise"
    end

    def sleep
        puts "#{self.class.name} is sleep ping"
    end
end

class Dog < Animal
    def make_noise
        "woof!"
    end
end

class Cat < Animal
    def make_noise
        "Meow!"
    end
end

[Animal.new, Dog.new, Cat.new].each do |animal|
    puts animal.make_noise
    animal.sleep
end
```  

## Module
Một module là một tập các phương thức, hằng số, lớp do đó module gần giống lớp chỉ khác là không thể tạo các đối tượng và không thể thừa kế  
để gọi module ta dùng từ khóa include  
để định nghĩa một module ta dùng cặp từ khóa module..end, tên module được đặt sau từ khóa module  
```
module Forest
  
    class Rock ; end
    class Tree ; end
    class Animal ; end   
     
end
```  
để truy xuất một đối tượng ta dùng toán tử  `::`  
`Forest::Tree.new`  
Ruby hỗ trợ đa kế thừa thông qua module:  
```
module Device
    def switch_on ; puts "on" end   
    def switch_off ; puts "off" end
end
 
module Volume
    def volume_up ; puts "volume up" end   
    def vodule_down ; puts "volume down" end
end
 
module Pluggable
    def plug_in ; puts "plug in" end   
    def plug_out ; puts "plug out" end
end
 
class CellPhone
    include Device, Volume, Pluggable
    
    def ring
        puts "ringing"
    end   
end
 
cph = CellPhone.new
cph.switch_on
cph.volume_up
cph.ring
```  

## Exception
```
x = 35
y = 0
begin
    z = x/y
    puts z
rescue => e
    puts "error #{e}"
end
```  
Còn có từ khóa `ensure` giống `final` trong python  