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

