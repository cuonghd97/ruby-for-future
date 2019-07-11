## Cài Rails
`gem isntall rails`  
+ Tạo project rails:  
`rails new project`  
+ Chạy rails server:  
`rails server`  
## Các thư mục cơ bản trong rails project:  
+ `app/`: Chứa controllers, models, views, ... cho webapp.  
+ `bin/`: Chứa các script để chạy app và có những script khác để setup, deploy app  
+ `config/`: Cấu hình app như: route, database,...  
+ `db/`: Chứa các database schema, cũng như database migration  
+ `public/`: chứa các static file  
+ `test/`: Unit test  
## Tạo controller
`rails generate controller Welcome index`  
tạo controller có tên là `Welcome`  
controller được lưu trong `app/controllers/welcome_controller.rb` với view tương ứng được lưu trong `app/views/welcome/index.html.erb`  

## Active Record
### Tạo một migration
Migration được lưu trữ trong thư mục `db/migrate` được lưu tên file theo dạng `YYYYMMDDHHMMSS_create_products.rb`. Rails sử dụng timestamp để tính toán migration nào được chạy trước, vậy nếu bạn copy một migration từ 1 app khác, cần chú ý về thứ tự chạy của migration đó  
Tạo một migration `rails generate migration AddFullnameToUsers` lưu ý tên migration viết dưới dạng CamelCase, tùy vào quy ước đặt tên và các tham số thêm vào rails cũng tự tạo được các migration ví dụ:  
`rails generate migration AddPartNumberToProducts part_number:string`  
Migration sẽ được tạo:  
```
class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :part_number, :string
  end
end
```  
Thêm các liên kết cho các model trong rails:  
Ví dụ ta tạo liên kết 1-n cho bảng `user` và bảng `post` mỗi người dùng sẽ đăng được nhiều bài `post`:  
`rails generate migration LinkPostsToUser`  
Sẽ tạo ra migration sau và ta thêm liên kết vào:  
```
class LinkPostToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, foreign_key: true
  end
end
```  

### Tạo model
Ta chạy lệnh sau:  
`rails generate model User`  
> Lưu ý tên model phải đặt là số ít  
Trong đó ta sẽ định nghĩa thêm các trường trong bảng đó:  
```
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :pasword
      t.integer :role

      t.timestamps
    end
  end
end
```  

### Viết migration
`create_table`: mặc định `create_table` tạo một khóa chính tự tăng là id. Bạn cũng có thể đổi tên trường khóa chính với `:primary_key` nếu bạn không cần khóa chính thì thêm `id: false`  
`create_join_table`: phương thức này tạo một HABTM(has and belong table to many) join table. Cách sử dụng điển hình là:  
`create_join_table :posts, :users`  
Sẽ tạo một bảng `posts_users` với 2 cột `post_id` và `user_id` các cột này có thuộc tính mặc định là `null: false` thuộc tính này cũng có thể thay đổi bằng tùy chọn `colmun_options: { null: true }`  

`create_join_table :products, :categories, column_options: { null: true }`  

Tên của bảng join mặc định là tên của 2 tham số ta đưa vào theo thứ tự trong bảng chữ cái, để đặt lại tên bảng ta có tùy chọn sau:  
`create_join_table :products, :categories, table_name: :categorization`  
Như vậy tên bảng sẽ là `categorization`  
Bạn cũng có thể thêm các chỉ số hoặc thêm các cột:  
```

create_join_table :products, :categories do |t|
  t.index :product_id
  t.index :category_id
end
```  
`change_table`:  dùng để thay đổi các bảng đã tồn tại.
Ví dụ:  
```

change_table :products do |t|
  t.remove :description, :name
  t.string :part_number
  t.index :part_number
  t.rename :upccode, :upc_code
end
```  
Ta sẽ xóa cột `description` và `name`, tạo thêm cột `part_number` và thêm index cho cột đó, cuối cùng là đổi tên cột `upccode` thành `upc_code`  
`change_column`:  
`change_column :products, :part_number, :text`  
ta sẽ đổi kiểu dữ liệu của cột `part_number` thành `text` của bảng `products`  
bên cạnh `change_column` còn có phương thức `change_column_null` và `change_column_default` để thay đổi ràng buộc không cho phép null hoặc đặt dữ liệu mặc định cho cột.  
```
change_column_null :products, :name, false
change_column_default :products, :approved, from: true, to: false
```  
#### Một số tùy chọn cho cột
+ `limit` đặt giá trị giới hạn cho các trường có kiểu string/text/binary/integer
+ `precision` đặt độ chính xác cho trường có kiểu decimal
+ `scale` đại diện cho số các chữ số sau dấu `,`
+ `null` cho phép hoặc không cho phép trường đó nhận giá trị null
+ `default` đặt giá trị mặc định cho cột đó, nếu bạn sử dụng giá trị động như `date` giá trị mặc định sẽ là thời gian mà migration đó được tạo
+ `comment` thêm chú thích cho cột
+ `polymorphic` hỗ trợ cho liên kết đa hình

#### foreign_key
`add_foreign_key :posts, :users`  
Sẽ thêm cột `user_id` vào bảng `posts` và liên quan đến cột `id` của bảng `users` nếu tên cột không thể được lấy từ tên bảng, bạn có thể sử dụng tùy chọn `:column` và `:primary_key`  

## Một số change method
+ `add_column`
+ `add_foreign_key`
+ `add_index`
+ `add_reference`
+ `add_timestamps`
+ `change_column_default (must supply a :from and :to option)`
+ `change_column_null`
+ `create_join_table`
+ `create_table`
+ `disable_extension`
+ `drop_join_table`
+ `drop_table (must supply a block)`
+ `enable_extension`
+ `remove_column (must supply a type)`
+ `remove_foreign_key (must supply a second table)`
+ `remove_index`
+ `remove_reference`
+ `remove_timestamps`
+ `rename_column`
+ `rename_index`
+ `rename_table`  

#### phương thức `up` và `down`
Ta cũng có thể dùng phương thức `up` và `down` thay cho phương thức `change`  
Phương thức `up` định nghĩa các thay đổi với schema và `down` hoàn tác lại các thay đổi của phương thức `up`  

## Thực thi các migration
chạy lệnh `rails db:migrate`  
Roll back:  
ta sẽ roll back về lần migration cuối cùng:  
`rails db:rollback`  
Nếu muốn roll back lại một số bước migration:  
`rails db:rollback STEP=3`  
Reset database:  
`rails db:reset`  


# Views

Mỗi controller liên kết với với `views` tại đường dẫn `app/views` chứa các template  
## Template, Partials và Layouts
### Template
`ERB` template các code ruby được viết trong các tags: `<%  %>` và `<%= %>`  
Tag `<% %>` dùng để thực thi code ruby và không trả về giá trị, như vòng lặp, lệnh điều kiện hoặc blocks. Còn tag `<%= %>` dùng để đưa ra giá trị  
Ví dụ:  
```
<h1>Names of all the people</h1>
<% @people.each do |person| %>
  Name: <%= person.name %><br>
<% end %>
```  
> Chú ý các hàm output như `print`, `p`, `puts` không được render trong erb template  
### Partials
Với `partials` bạn có thế chia code từ file template ra thành từng file riêng và sử dụng lại được trong template.  
Để render một `partial` như là một phần của view, bạn sử dụng phương thức `render` trong view:  
`<%= render "menu" %>`  
Sẽ render nội dụng của 1 file có tên `_menu.html.erb` lên view  
> Chú ý: tên của `partial` phải bắt đầu bằng dấu `_`  
Cũng có thể render `partial` từ folder khác:  
`<%= render "shared/menu" %>`  

## Thêm bootstrap vào Rails project
`gem 'bootstrap-sass', '3.4.1'` thêm dòng này vào `Gemfile` phiên bản hiện tại là `3.4.1` có thể tùy chọn phiên bản  
`bundle install` để cái các dependencies còn thiếu  
Tạo một file `custom.scss`: `touch app/assets/stylesheets/custom.scss`  
có nội dung:  
```
@import "bootstrap-sprockets";
@import "bootstrap";
```  
sau đó khởi động lại rails server.  

## Active record callback
Active record cung cấp các hook vào vòng đời của đối tượng này để bạn có thể kiểm soát ứng dụng và dữ liệu của chúng  
Để dùng các callback bạn phải khai báo chúng:  
```

class User < ApplicationRecord
  validates :login, :email, presence: true
 
  before_validation :ensure_login_has_a_value
 
  private
    def ensure_login_has_a_value
      if login.nil?
        self.login = email unless email.blank?
      end
    end
end
```  
Các callback có sẵn:  
Callback create an object:  
+ before_validation
+ after_validation
+ before_save
+ around_save
+ before_create
+ around_create
+ after_create
+ after_save
+ after_commit/after_rollback

Callback update an object:  
+ before_validation
+ after_validation
+ before_save
+ around_save
+ before_update
+ around_update
+ after_update
+ after_save
+ after_commit/after_rollback

Callback destroy an object:  
+ before_destroy
+ around_destroy
+ after_destroy
+ after_commit/after_rollback  

`after_initialize` và `after_find`:  
`after_initialize` sẽ được gọi khi một đối tượng Active Record được tạo. Nó cũng được dùng để tránh ghi đè trực tiếp phương thức khởi tạo Active Record.
`after_find` được gọi khi một Active Record load một bản ghi từ database.  
```
class User < ApplicationRecord
  after_initialize do |user|
    puts "You have initialized an object!"
  end
 
  after_find do |user|
    puts "You have found an object!"
  end
end
 
>> User.new
You have initialized an object!
=> #<User id: nil>
 
>> User.first
You have found an object!
You have initialized an object!
=> #<User id: 1>
```  

### Relation callback
```

class User < ApplicationRecord
  has_many :articles, dependent: :destroy
end
 
class Article < ApplicationRecord
  after_destroy :log_destroy_action
 
  def log_destroy_action
    puts 'Article destroyed'
  end
end
 
>> user = User.first
=> #<User id: 1>
>> user.articles.create!
=> #<Article id: 1, user_id: 1>
>> user.destroy
Article destroyed
=> #<User id: 1>
```  
