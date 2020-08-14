# Stadium-management-system---体育馆场地管理系统-1.0

## 项目说明

该项目为体育馆场地管理系统1.0版本，使用Javaee+Jsp+Mysql，数据库连接工具c3p0，数据库操作工具Commons，用监听器完成定时任务，过滤器实现安全跳转。 

## 项目演示地址
http://121.36.38.15:8080/GMS/

http://121.36.38.15:8080/GMS/admin

管理员账号密码：
admin
123456

## 项目详细说明介绍
https://blog.csdn.net/weixin_43786818/article/details/107980802

## 2.0版本地址
https://github.com/Suarge/gms-2.0

---

## 项目截图
>前台用户部分

![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/1.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/1.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/3.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/4.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/5.png)

>后台管理员部分

![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/6.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/7.png)
![image](https://github.com/Suarge/gms-1.0/blob/master/readme_photo/8.png)

## 功能
用户部分：
* 登录、注册、修改密码、注销登录
* 首页各种加载、场馆类型展示、通知信息展示、场馆详情展示
* 模糊查询订单
* 打印订单

管理员部分：
* 登录、注销
* 总览
* 场地管理
* 预约查询
* 通知发布
* 情况分析

## 技术栈
* Javaee---过滤器、监听器、servlet
* Jsp
* Mysql + c3p0 + commons数据库操作工具
* apache的poi文件导出api


## 安装
### 1、下载项目到本地
```xml
git clone https://github.com/Suarge/gms-1.0.git
```
### 2. 导入项目
该项目之前是用eclipes编写的，导入到idea里还是可以使用，但是需要修改目录结构，这里请自己百度修改

### 3.设置c3p0连接数据库
将`gms.sql`中的sql文件运行，并修改对应的配置文件

### 4.启动项目
* 因为前端是ajax访问的，所以日期不对的话下面的场馆表格是不会加载的，gms.sql的日期是2020-8-13，你有两种办法解决这个问题
  1. 通过修改GMX_index.jsp里面的日期即可，具体位置在js代码的第一个部分，注释掉获取当天日期的函数，手动设置三个参数，
    var nowday = "2020-8-13";
	  var nextday = "2020-8-14";
	  var nextnextday = "2020-8-15";
  2. 项目中有一个cpp文件，该文件打开后可以根据你设置的日期，生成sql语句，前台只显示3天的数据，但是由于管理员部分的数据分析需要，默认会生成4天的sql，比如今天是2020-11-13，那你在cpp文件中将变量设置为 prdate = 12 提前一天
* 这样操作后你就可以成功运行了

## 最后
有问题的话可以邮件联系：1274334685@qq.com
