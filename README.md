# LBSwiftWeiBo
微博 -- Swift版本






















##### 微博 -- Swift版本 -- 第一天
1、初始化项目，项目基本设置
2、storyboard 搭建项目基本结构
Storyboard 创建项目结构快而且简单，这里涉及到storyboard reference 可以分离子storyboard，使项目结构清晰而且更加有利于操作
3、创建标签控制器
① 添加子控制器初始化对象创建
② 使用子控制器名称字符串创建，涉及到命名空间的概念(nameSpace)
③ 使用json文件创建(涉及到json文件里数据的获取)
④ 创建标签栏中间按钮的思路：空出中间item区域，使用UIButton添加即可
4、小知识点
① convenience遍历构造函数使用
② 类方法的创建()
`class func lbweibo -> String{}`
③ 按钮方法的监听
`btn.addTarget(self, action: #selector(LBTabBarController.composeBtnClick), for: .touchUpInside)`
④ 处理系统方法异常
* try方式
* try!(用这个比较不安全)
* try?(推荐使用这个来处理系统方法异常的情况)
⑤ `guard else{}`的使用，用好这个项目中就会少很多麻烦问题，
`as`、`as?`、`as!`区分使用原理
* as 一般使用swift转换成oc对象，确定对象的转换
* as? 一般是AnyObject?可选类型转换成我们需要的类型
* as! 一般不适用，不太安全
⑥ 对于可选类型我们一般不适用`!`来进行解包，但是有个例还是可以使用`!`进行解包的，
对于我们确定一定有值的情况下是可以使用的
⑦ 方法的重载<br>
方法名称相同,但是参数不同
* 参数的类型不同 
* 参数的个数不同
⑧ swift构造函数中不需要写返回值，但是oc中本身就自带

