SET NAMES UTF8;
-- 如果有数据库slr，丢弃
DROP DATABASE IF EXISTS lecake;
-- 创建数据库lecake
CREATE DATABASE lecake CHARSET=UTF8;
USE lecake;

-- 用户信息表
CREATE TABLE lecake_user(
  uid INT PRIMARY KEY AUTO_INCREMENT, # 用户id
  phoneNum VARCHAR(11) NOT NULL UNIQUE, #用户手机号
  upwd VARCHAR(16) NOT NULL,  #用户密码
  gender TINYINT,  #性别1或0
  birthday DATE, #生日
  avatar VARCHAR(128) DEFAULT "http://127.0.0.1:3000/public/img/user/avatar.png"
);

-- 商品口味表
CREATE TABLE lecake_product_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,  # 分类ID
  fname VARCHAR(15) NOT NULL #口味名称
);

-- 商品信息表
CREATE TABLE lecake_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,  #商品ID
  pname VARCHAR(100) NOT NULL, #商品名
  pspecs TEXT(1000),     #商品规格,为JSON字符串
  cake VARCHAR(20),    #蛋糕种类
  sweetness INT,#蛋糕甜度
  img_show VARCHAR(200), #商品展示图
  index_img VARCHAR(200), #首页商品展示图
  ptext VARCHAR(128), #商品展示文字
  icolor VARCHAR(50),#首页商品简介颜色
  pdetail TEXT(1000),#商品详情，为JSON字符串
  isimg BOOLEAN, #商品详情使用哪种布局
  pedible TEXT(1000),#商品食用信息，
  pro_text TEXT(1000),#商品信息，
  f_id INT, #商品家族编号
  FOREIGN KEY(f_id) REFERENCES lecake_product_family(fid) 
);

-- 首页轮播
CREATE TABLE lecake_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  curl VARCHAR(128),
  btext VARCHAR(128),
  stext VARCHAR(128),
  textcolor VARCHAR(50)
);

-- 插入轮播图
INSERT INTO lecake_index_carousel VALUES
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner01.jpg',"夏日花花世界","人气“花”样蛋糕  限时最高立减137元",NULL),
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner02.jpg',"「橙」意十足  甜蜜满分","买蛋糕+66元  盒子蛋糕0畅享","#fff"),
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner03.jpg',"玩味中秋  一起「炫」团圆","限时早鸟专享  赠喵叽叽曲奇礼盒",NULL),
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner04.jpg',"「盒」我一起 「纤」气十足","随心所欲  轻松享甜无「腹」担","#ff3601"),
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner05.jpg',"囤甜啦！Get夏日治愈の味","甜点随心享 限时立减90元","#d09300"),
(NULL,'http://127.0.0.1:3000/public/img/carousel/banner06.jpg',"嗨Fun生日趴 今天你最大","多款人气蛋糕 加大来袭","#f75467");


-- 插入商品分类信息
INSERT INTO lecake_product_family VALUES
(10,"雪域口味"),
(20,"巧克力味"),
(30,"芝士口味"),
(40,"慕斯口味"),
(50,"奶油口味");


-- 插入商品信息
INSERT INTO lecake_product VALUES
(NULL,"花花世界",'[{"price":"336","servings":"2~4人食≈454g","spec":"约12*12*7cm 含5套餐具"}]',"慕斯蛋糕",2,"birthday/hhsj_show.jpg","birthday/hhsj_index.jpg","绽放柔情的花花世界","#fff",'[{"url":"birthday/hhsj_detail01.jpg","detail_text":""},{"url":"birthday/hhsj_detail02.jpg","detail_text":""},{"url":"birthday/hhsj_detail03.jpg","detail_text":""},{"url":"birthday/hhsj_detail04.jpg","detail_text":""},{"url":"birthday/hhsj_detail05.jpg","detail_text":""}]',FALSE,'[{"taste":"慕斯口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用。"}]',"把浓浓爱意融进甜蜜花礼之中|每一口甜蜜都让人倍感宠爱|爱是永不凋零的花|愿美丽芳华永远将她围绕",40);