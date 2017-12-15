# LBSwiftWeiBo
#### 微博 -- Swift版本

##### 微博 -- Swift版本 -- 第三天<br>
1、ViewModel是对model的封装，存储属性一般放在model，其他属性处理放在ViewModel里面


##### 微博 -- Swift版本 -- 第二天<br>
1、添加访客视图<br>
2、导航栏设置、titleView弹出框实现<br>
3、pod 的使用：首先安装pod，在项目根目录中pod init初始化，在profile文件中添加我们需要的框架名称，pod install即可<br>
4、Swift网络请求封装<br>
5、成为微博开发者，根据微博url获取code，再根据code获取access_token，根据access_token等信息获取用户个人信息<br>
6、对于获取到的用户信息进行归档、解档处理<br>
7、单利、计算属性的使用，??、guard else{}的使用<br>
8、欢迎页头像动画实现、欢迎页和主页之间切换<br>



##### 微博 -- Swift版本 -- 第一天<br>
1、初始化项目，项目基本设置<br>
2、storyboard 搭建项目基本结构<br>
Storyboard 创建项目结构快而且简单，这里涉及到storyboard reference 可以分离子storyboard，使项目结构清晰而且更加有利于操作<br>
3、创建标签控制器<br>
① 添加子控制器初始化对象创建<br>
② 使用子控制器名称字符串创建，涉及到命名空间的概念(nameSpace)<br>
③ 使用json文件创建(涉及到json文件里数据的获取)<br>
④ 创建标签栏中间按钮的思路：空出中间item区域，使用UIButton添加即可<br>
4、小知识点<br>
① convenience遍历构造函数使用<br>
② 类方法的创建<br>
`class func lbweibo -> String{}`<br>
③ 按钮方法的监听<br>
`btn.addTarget(self, action: #selector(LBTabBarController.composeBtnClick), for: .touchUpInside)`<br>
④ 处理系统方法异常<br>
  * try方式<br>
  * try!(用这个比较不安全)<br>
  * try?(推荐使用这个来处理系统方法异常的情况)<br>
  
⑤ `guard else{}`的使用，用好这个项目中就会少很多麻烦问题，
`as`、`as?`、`as!`区分使用原理<br>
  * as 一般使用swift转换成oc对象，确定对象的转换<br>
  * as? 一般是AnyObject?可选类型转换成我们需要的类型<br>
  * as! 一般不适用，不太安全
  
⑥ 对于可选类型我们一般不适用`!`来进行解包，但是有个例还是可以使用`!`进行解包的，<br>
对于我们确定一定有值的情况下是可以使用的<br>
⑦ 方法的重载<br>
方法名称相同,但是参数不同<br>
  * 参数的类型不同 <br>
  * 参数的个数不同<br>
  
⑧ swift构造函数中不需要写返回值，但是oc中本身就自带<br>

