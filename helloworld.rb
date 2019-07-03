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