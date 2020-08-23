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
  iscake BOOLEAN,#是否是蛋糕
  sweetness INT,#蛋糕甜度
  img_show VARCHAR(200), #商品展示图
  index_img VARCHAR(200), #首页商品展示图
  ptext VARCHAR(128), #商品展示文字
  icolor VARCHAR(50),#首页商品简介颜色
  pbanner VARCHAR(250),#商品详情页banner图
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
(50,"奶油口味"),
(60,"甜点心礼");


-- 插入商品信息
INSERT INTO lecake_product VALUES
(NULL,"花花世界",'[{"price":"336","servings":"2~4人食≈454g","spec":"约12*12*7cm 含5套餐具"}]',"慕斯蛋糕",TRUE,2,"birthday/hhsj_show.jpg","birthday/hhsj_index.jpg","绽放柔情的花花世界","#fff","birthday/hhsj_banner.jpg",'[{"url":"birthday/hhsj_detail01.jpg","detail_text":""},{"url":"birthday/hhsj_detail02.jpg","detail_text":""},{"url":"birthday/hhsj_detail03.jpg","detail_text":""},{"url":"birthday/hhsj_detail04.jpg","detail_text":""},{"url":"birthday/hhsj_detail05.jpg","detail_text":""}]',FALSE,'[{"taste":"慕斯口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用。"}]',"把浓浓爱意融进甜蜜花礼之中|每一口甜蜜都让人倍感宠爱|爱是永不凋零的花|愿美丽芳华永远将她围绕",40),
(NULL,"海盐乳酪芝士",'[{"price":"218","servings":"2~4人食≈454g","spec":"约13*3cm 含5套餐具"},{"price":"336","servings":"5~8人食≈810g","spec":"约17*3cm 含10套餐具"}]',"奶油芝士蛋糕",TRUE,2,"birthday/hyrl_show.jpg","birthday/hyrl_index.jpg","芝士控绕不开的难忘滋味","#000","birthday/hyrl_banner.jpg",'[{"url":"birthday/hyrl_detail01.jpg","detail_text":"<p>充满回忆的味道，总令人难以忘怀。那是西西里岛的风味，充满渔夫自然不造作的热情， 与素未谋面的我，分享渔获，分享喜悦。</p>"},{"url":"birthday/hyrl_detail02.jpg","detail_text":""}]',TRUE,'[{"taste":"芝士口味","warm":"此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"地中海的别样风情让人沉醉，|清凉的风夹杂着丝丝的微咸轻抚脸庞，|使得我产生了研发这款蛋糕的初衷，|用海盐和新西兰上等芝士经过精心调配，|让芝士的天然味道瞬间迸发出来，|给味蕾出奇的惊艳。",30),
(NULL,"巧克力松露·熠彩",'[{"price":"258","servings":"2-4人食≈420g","spec":"约13*13*4cm 含5套餐具"},{"price":"398","servings":"5~8人食≈750g","spec":"约17*17*4cm 含10套餐具"},{"price":"598","servings":"10~12人食≈1240g","spec":"约22*22*4cm 含10套餐具"}]',"巧克力蛋糕",TRUE,2,"birthday/qklsl_show.jpg","birthday/qklsl_index.jpg","巧克力爱好者的福音","#000","birthday/qklsl_banner01.jpg|birthday/qklsl_banner02.jpg",'[{"url":"birthday/qklsl_detail01.jpg","detail_text":""},{"url":"birthday/qklsl_detail02.jpg","detail_text":""},{"url":"birthday/qklsl_detail03.jpg","detail_text":""},{"url":"birthday/qklsl_detail04.jpg","detail_text":""},{"url":"birthday/qklsl_detail05.jpg","detail_text":""}]',FALSE,'[{"taste":"巧克力口味","warm":"本产品使用了白兰地进行调味，此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"线条的交织，色彩的碰撞|描绘着一场舌尖浪漫|柔滑巧克力甘纳许|搭配绵密巧克力戚风|浓郁丝滑，入口即化|满满醇香在口中弥漫开来",20),
(NULL,"经典原味千层",'[{"price":"198","servings":"2-4人食≈420g","spec":"约14*3cm 含5套餐具"},{"price":"298","servings":"5~8人食≈750g","spec":"约21*3cm 含10套餐具"}]',"千层蛋糕",TRUE,1,"birthday/ywqc_show.jpg","birthday/ywqc_index.jpg","轻盈饼皮夹裹细腻奶油 层次丰富","#000","birthday/ywqc_banner.jpg",'[{"url":"birthday/ywqc_detail01.jpg","detail_text":"<p>纵然外界纷纷扰扰</p><p>心亦如赤子般纯粹</p><p>皎洁明亮 不染尘埃</p><p>静守心中的美好</p>"},{"url":"birthday/ywqc_detail02.jpg","detail_text":""}]',TRUE,'[{"taste":"奶油口味","warm":"此产品实物因尺寸规格而异，本页面商品展示图为5-8人食"}]',"香气在空气中蔓延|层层饼皮 夹裹奶油的甜蜜|丰富而立体 美妙又融合|令人意犹未尽",50),
(NULL,"玫瑰雪域芝士",'[{"price":"218","servings":"2-4人食≈520g","spec":"约13*3*4cm 含5套餐具"},{"price":"336","servings":"5~8人食≈900g","spec":"约17*17*4cm 含10套餐具"}]',"牛乳芝士蛋糕",TRUE,2,"birthday/xyzs_show.jpg","birthday/xyzs_index.jpg","懂得营造浪漫氛围的蛋糕","#000","birthday/xyzs_banner.jpg",'[{"url":"birthday/xyzs_detail01.jpg","detail_text":"<p>一片玫瑰的海洋，映衬着少男少女那纯净的心境。这么多朵玫瑰花，总像有数不清的芬芳思念，诉不尽的感恩眷恋，所有声音都在轻声呢喃着誓约长久。</p>"},{"url":"birthday/xyzs_detail02.jpg","detail_text":""}]',TRUE,'[{"taste":"芝士口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用，此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"玫瑰是美丽爱情的象征|而一朵纯白的玫瑰则映衬出少男少女纯净的感情|花是爱恋，花是祝福，花是立下的爱之誓言|这款蛋糕延续了雪域牛乳芝士系列的浓郁香醇的口感|回味绵长恰如爱情的滋味|充满法式浪漫和柔情",30),
(NULL,"茶草京都",'[{"price":"218","servings":"2-4人食≈418g","spec":"约13*3*4cm 含5套餐具"},{"price":"336","servings":"5~8人食≈900g","spec":"约17*17*4cm 含10套餐具"},{"price":"506","servings":"10~12人食≈1330g","spec":"约22*22*4cm 含15套餐具"},{"price":"840","servings":"15~20人食≈2500g","spec":"约31*31*4cm 含20套餐具"}]',"慕斯蛋糕",TRUE,2,"birthday/ccjd_show.jpg","birthday/ccjd_index.jpg","抹茶控京都寻味 草色茶香自悠然","#fff","birthday/ccjd_banner.jpg",'[{"url":"birthday/ccjd_detail01.jpg","detail_text":"<p>清新抹茶唤醒京都遐想</p><p>香甜白巧融入柔滑芝士</p><p>丰富口感的交织</p><p>给味蕾一场奇妙体验</p><p>仿佛置身抹茶的国度</p>"},{"url":"birthday/ccjd_detail02.jpg","detail_text":""},{"url":"birthday/ccjd_detail03.jpg","detail_text":"<p>抹茶的色香味皆美</p><p>浓浓的新绿中</p> <p>细腻清新 茶韵悠然</p>"}]',TRUE,'[{"taste":"慕斯口味","warm":"*此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"京都的颜色|是茶草清新的绿|闭上眼 细细感受其中的韵味|抹茶香气馥郁悠长 百转千回|品一抹绿意 忆往日京都|带来全新味蕾体验",40),
(NULL,"闲蛋皇",'[{"price":"258","servings":"2-4人食≈515g","spec":"约13*3*4cm 含5套餐具"},{"price":"398","servings":"5~8人食≈900g","spec":"约17*17*4cm 含10套餐具"}]',"芝士慕斯蛋糕",TRUE,2,"birthday/xdh_show.jpg","birthday/xdh_index.jpg","热度持续飙升 人气咸蛋黄蛋糕","#fff","birthday/xdh_banner.jpg",'[{"url":"birthday/xdh_detail01.jpg","detail_text":"<p>当咸蛋黄遇上蛋糕</p><p>浓醇牛奶与柔滑芝士慕斯融合</p><p>嚼得到的沙绵蛋黄粒</p><p>软绵细腻，浓滑咸香</p><p>带来不一样的美妙口感</p>"},{"url":"birthday/xdh_detail02.gif","detail_text":""},{"url":"birthday/xdh_detail03.jpg","detail_text":"<p>浓厚咸蛋黄酱</p> <p>带着流沙的质感</p><p>细致绵密，浓郁咸香</p>"}]',TRUE,'[{"taste":"奶油口味","warm":"*本产品使用了配制酒进行调味，此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"可咸可甜是我的信仰|悠哉躺着是我的追求|想像我一样|闲得有滋有味？|还等什么呐|快来接“朕”回家！",50),
(NULL,"锦鲤送福",'[{"price":"298","servings":"2-4人食≈515g","spec":"约13*3*4cm 含5套餐具"}]',"牛乳芝士蛋糕",TRUE,2,"birthday/jlsf_show.jpg","birthday/jlsf_index.jpg","经典雪域迎“锦鲤” 口口浓醇好运","#fff","birthday/jlsf_banner.jpg",'[{"url":"birthday/jlsf_detail01.jpg","detail_text":""},{"url":"birthday/jlsf_detail02.gif","detail_text":""},{"url":"birthday/jlsf_detail03.jpg","detail_text":""},{"url":"birthday/jlsf_detail04.jpg","detail_text":""},{"url":"birthday/jlsf_detail05.jpg","detail_text":""}]',FALSE,'[{"taste":"","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用，蛋糕表面锦鲤图案为装饰纸插卡，不可食用，商品以实物为准。"}]',"贴福字，承袭过年的传统习俗|锦鲤，象征吉祥富贵|经典的雪域牛乳芝士|满载好彩头|只愿开年时刻|博得喜笑颜开满堂彩",10),
(NULL,"壁咚！阿华田",'[{"price":"258","servings":"2-4人食≈515g","spec":"约13*5cm 含5套餐具"}]',"巧克力蛋糕",TRUE,2,"birthday/aht_show.jpg","birthday/aht_index.jpg","浓郁麦芽可可 绵软与甜脆的碰撞","#fff","birthday/aht_banner.jpg",'[{"url":"birthday/aht_detail01.jpg","detail_text":"<p>一起来壁咚阿华田</p><p>浓郁的麦芽可可滋味</p><p>与曼妙的慕斯跳起舌尖华尔兹</p><p>阿华田酷脆“噼啪”咀嚼</p><p>在口中绽放一场场奇妙烟花</p>"},{"url":"birthday/aht_detail02.gif","detail_text":""},{"url":"birthday/aht_detail03.jpg","detail_text":""}]',FALSE,'[{"taste":"巧克力口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用。"}]',"充满浓郁麦芽香的阿华田|带来馥郁而纯正的浓厚口感|醇香柔滑的阿华田慕斯、阿华田夹心|与烤榛子碎、阿华田脆碰撞|缔造出层次分明的丰富体验",20),
(NULL,"提拉米苏·写意",'[{"price":"298","servings":"2-4人食≈515g","spec":"约13*5cm 含5套餐具"},{"price":"458","servings":"5-8人食≈910g","spec":"约20*5cm 含10套餐具"}]',"芝士慕斯蛋糕",TRUE,2,"birthday/tlms_show.jpg","birthday/tlms_index.jpg","80%的雪域老友也爱这一款","#000","birthday/tlms_banner.jpg",'[{"url":"birthday/tlms_detail01.jpg","detail_text":""},{"url":"birthday/tlms_detail02.jpg","detail_text":"<p>点与线</p><p>自由而奔放</p><p>即兴的思考与感悟</p><p>细品出一份抽象的唯美</p><p>令人芳心暗许</p><p>无言之中感受美味的力量</p>"},{"url":"birthday/tlms_detail03.jpg","detail_text":""},{"url":"birthday/tlms_detail04.jpg","detail_text":"<p>进口的黑巧克力</p> <p>通过精致的工艺</p> <p>释放出浓浓香醇</p> <p>每一口都倍感幸福</p>"}]',FALSE,'[{"taste":"巧克力口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用。本产品使用了白兰地、葡萄酒进行调味。此产品实物因尺寸规格而异，本页面商品展示图为2-4人食。"}]',"甄选意大利马斯卡布尼芝士|咖啡风味手指饼丰富层次|为清爽奶油增添神秘口感|巧克力和咖啡的香浓错落有致|巴旦木蛋糕坯的绵软与脆底的松脆恰到好处|细腻之中咔兹一下|带来难忘的触动",20),
(NULL,"雪域牛乳芝士",'[{"price":"218","servings":"2-4人食≈515g","spec":"约13*5cm 含5套餐具"},{"price":"336","servings":"5-8人食≈910g","spec":"约20*5cm 含10套餐具"}]',"牛乳芝士蛋糕",TRUE,2,"birthday/nrzs_show.jpg","birthday/nrzs_index.jpg","经典之作 热销多年","#fff","birthday/nrzs_banner.jpg",'[{"url":"birthday/nrzs_detail01.jpg","detail_text":"<p>超人气的雪域牛乳芝士蛋糕，细腻绵长，口感丰富，犹如纯洁精灵的化身，毫不吝啬地将所有美好呈现在眼前。</p>"},{"url":"birthday/nrzs_detail02.jpg","detail_text":""},{"url":"birthday/nrzs_detail03.jpg","detail_text":"<p>选用进口白巧克力</p><p>精湛工艺将白巧克力擦出</p><p>如初雪般的轻柔</p><p>触碰舌尖即化</p><p>甜蜜动人</p>"}]',FALSE,'[{"taste":"芝士口味","warm":"蛋糕中出现的细小黑色颗粒为香草籽，此为香草荚未碾磨均匀带入的颗粒，可放心食用，此产品实物因尺寸规格而异，本页面商品展示图为5-8人食。"}]',"阿尔卑斯山的雪|简单但有种永恒的美|特浓牛乳和新西兰上等芝士用独特的工艺|令芝士的香气完全散发出来|蛋糕的口感也更加浓郁香滑、入口即溶|上等食材的精心配比，让这款蛋糕回味无穷",30),
(NULL,"盒子蛋糕·四拼端盒",'[{"price":"168","spec":"四拼端盒"},{"price":"42","spec":"草莓优格"},{"price":"42","spec":"巧克力松露"},{"price":"42","spec":"一盒奶茶"},{"price":"42","spec":"提拉米苏"}]',NULL,FALSE,1,"dessert/hzdg_show.jpg",NULL,"随时随地，自在享甜无“腹”担",NULL,"dessert/hzdg_banner01.jpg|dessert/hzdg_banner02.jpg|desserthzdg_banner03.jpg|dessert/hzdg_banner04.jpg|dessert/hzdg_banner05.jpg|dessert/hzdg_banner06.jpg","dessert/hzdg_detail01.jpg|hzdg_detail02.jpg|hzdg_detail03.jpg",TRUE,"<p>适合季节：所有</p> <p>适合人群：大众</p> <p>保鲜条件：请置于0-4℃环境下冷藏；冷冻</p> <p>保质期 ：冷藏保质期2天（未开盒）；冷冻保质期30天</p> <p>食用方法：收货后冷藏保存2-3小时口感更佳，开盒后请尽快食用！</p> <p>*新老包装更替，随机发货，请以收到实物为准。</p>","这一次，我们把蛋糕|装进「盒子」里|加入甜蜜“小心机”|——赤藓糖醇、高膳食纤维|随时随地，手捧这一盒|让你自在享甜无“腹”担！",60),
(NULL,"柚柚波波流心巴斯克",'[{"price":"218","spec":"2~4人食≈440g"}]',NULL,FALSE,1,"dessert/sbk_show.jpg",NULL,"流心“柚”惑！收藏夏日治愈の味",NULL,"dessert/sbk_banner.jpg","dessert/sbk_detail01.jpg|sbk_detail02.jpg",TRUE,"<p>适合季节：所有</p> <p>适合人群：大众</p> <p>保鲜条件：请置于0-4℃环境下冷藏；冷冻</p> <p>保质期 ：冷藏保质期2天（未开盒）；冷冻保质期30天</p> <p>食用方法：收货后冷藏保存2-3小时口感更佳，开盒后请尽快食用！</p> <p>*商品以实物为准。</p>","谁能抵挡得住|来自柚子的清新诱惑？|浓郁嫩滑的巴斯克流心|混合柚子的沁爽酸甜|Q弹脆波波惊喜加入|这是我为你收藏的夏天の味道",60),
(NULL,"鎏光幻月礼盒",'[{"price":"336","spec":"1盒(6个装)≈300g"}]',NULL,FALSE,NULL,"dessert/lghy_show.jpg",NULL,"幻彩花灯 鎏光熠熠 一起炫团圆",NULL,"dessert/lghy_banner.jpg","dessert/lghy_detail01.jpg|lghy_detail02.gif|lghy_detail03.jpg|lghy_detail04.jpg",TRUE,"<p>适合节日：中秋</p> <p>适合人群：大众</p> <p>储存条件：常温</p> <p>保质期  ：60天</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买</p> <p>*商品以实物为准。</p>","甄选6款经典味道|结合鎏光炫彩元素|经典传承与现代创新结合|重塑东方传统韵味|礼遇佳节，赏味中秋|一起“炫”团圆",60),
(NULL,"朗月团圆礼盒",'[{"price":"218","spec":"1盒(4个装)≈200g"}]',NULL,FALSE,NULL,"dessert/lyty_show.jpg",NULL,"炫彩满月 诠释团圆“美”意",NULL,"dessert/lyty_banner.jpg","dessert/lyty_detail01.jpg|lyty_detail02.jpg|lyty_detail03.jpg",TRUE,"<p>适合节日：中秋</p> <p>适合人群：大众</p> <p>储存条件：常温</p> <p>保质期  ：60天</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买</p> <p>*商品以实物为准。</p>","4款经典传统味道|碰撞时尚炫彩元素|经典传承与现代美学结合|重塑东方传统韵味|这份团圆美意，请笑纳",60),
(NULL,"喵叽叽云顶小花曲奇礼盒（巧克力味）",'[{"price":"158","spec":"280g≈280g"},{"price":"238","spec":"560g≈560g"}]',NULL,FALSE,1,"dessert/qqqkl_show.jpg",NULL,NULL,NULL,"dessert/qqqkl_banner.jpg",'[{"url":"dessert/qqqkl_detail01.jpg","detail_text":"<p>轻尝一口</p><p>便深深入迷</p><p>触动了心底的温柔</p><p>巧克力的馥郁香浓融化在口中</p><p>灿烂明媚全然心上</p>"},{"url":"dessert/qqqkl_detail02.jpg","detail_text":""},{"url":"dessert/qqqkl_detail03.jpg","detail_text":""}]',FALSE,"<p>适合人群：大众</p> <p>适合季节：所有</p> <p>保鲜条件：常温保存</p> <p>保质期：2个月</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买。</p> <p>*商品以实物为准。</p>","甄选进口食材，精心烘焙制作|加入进口黑巧克力与可可粉|经过上千次的反复尝试|呈现别具一格的小花造型|层层叠叠，只为这一口酥香的绽放|dessert/qq_detail02.jpg",60),
(NULL,"喵叽叽云顶小花曲奇礼盒·元气双拼（原味+巧克力味）",'[{"price":"158","spec":"280g≈280g"},{"price":"238","spec":"560g≈560g"}]',NULL,FALSE,1,"dessert/qqsp_show.jpg",NULL,"征服朋友圈的办公室零食",NULL,"dessert/qqsp_banner.jpg",'[{"url":"dessert/qqsp_detail01.jpg","detail_text":"<p>黄油与巧克力</p><p>组成“香浓”好搭档</p><p>一口一口，浓郁香醇</p><p>带来元气满满好心情</p><p>仿佛回到年少时的烂漫时光</p>"},{"url":"dessert/qqsp_detail02.jpg","detail_text":""},{"url":"dessert/qqsp_detail03.jpg","detail_text":""},{"url":"dessert/qqsp_detail04.jpg","detail_text":""}]',FALSE,"<p>适合人群：大众</p> <p>适合季节：所有</p> <p>保鲜条件：常温保存</p> <p>保质期：2个月</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买。</p> <p>*商品以实物为准。</p>","甄选进口食材，精心烘焙制作|加入进口黑巧克力与可可粉|经过上千次的反复尝试|呈现别具一格的小花造型|层层叠叠，只为这一口酥香的绽放|dessert/qq_detail02.jpg",60),
(NULL,"喵叽叽云顶小花曲奇礼盒(原味)",'[{"price":"158","spec":"280g≈280g"},{"price":"238","spec":"560g≈560g"}]',NULL,FALSE,1,"dessert/qqyw_show.jpg",NULL,"卖到疯狂的秒杀款",NULL,"dessert/qqyw_banner.jpg",'[{"url":"dessert/qqyw_detail01.jpg","detail_text":"<p>酥酥的原味小花曲奇</p><p>前来挑逗你的味蕾</p><p>唇齿间弥漫着</p><p>醇厚浓郁的黄油香</p><p>仿佛是吃下了一口大好时光</p>"},{"url":"dessert/qqyw_detail02.jpg","detail_text":""},{"url":"dessert/qqyw_detail03.jpg","detail_text":""}]',FALSE,"<p>适合人群：大众</p> <p>适合季节：所有</p> <p>保鲜条件：常温保存</p> <p>保质期：2个月</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买。</p> <p>*商品以实物为准。</p>","甄选进口食材，精心烘焙制作|加入进口黑巧克力与可可粉|经过上千次的反复尝试|呈现别具一格的小花造型|层层叠叠，只为这一口酥香的绽放|dessert/qq_detail02.jpg",60),
(NULL,"乐熊熊曲奇礼盒",'[{"price":"128","spec":"1盒≈190g"}]',NULL,FALSE,2,"dessert/lxx_show.jpg",NULL,"曲奇界心宠 童趣无限",NULL,"dessert/lxx_banner.jpg",'[{"url":"dessert/lxx_detail01.jpg","detail_text":"<p>像巧克力一样有趣，像蔓越莓一样灵动</p><p>像核桃一样有信念，像草莓一样有默契</p><p>与乐熊熊相遇</p><p>美梦正走进你心里</p>"},{"url":"dessert/lxx_detail02.jpg","detail_text":""},{"url":"dessert/lxx_detail03.jpg","detail_text":"<p>黄油像凝结的阳光</p> <p>醇香细腻 入口即化</p> <p>释放出柔滑清爽的本真滋味</p>"}]',FALSE,"<p>适合人群：大众</p> <p>适合季节：所有</p> <p>保鲜条件：常温保存</p> <p>保质期：2个月</p> <p>温馨提示：如对上述食材有过敏经历者，请谨慎购买。</p> <p>*商品以实物为准。</p>","一块曲奇就是一个小世界|超越一切语言|带给内心无比的温馨|从选材到造型|皆充满童真童趣|愿每个人在浓香的味道中|拥抱惬意的小时光",60),

(NULL,"个性字母透明挎包",'[{"price":"68","spec":"五款主题 随机一款"}]',NULL,FALSE,NULL,"dessert/kb_show.jpg",NULL,"清凉又撩人 百搭潮品",NULL,"dessert/kb_banner.jpg",'[{"url":"dessert/kb_detail01.jpg","detail_text":"<p>哪怕空气中下着雨又怎样</p><p>透明的PVC挎包始终时髦</p><p>无论身处何地</p><p>你都是你 没有标签</p><p>只有纯然的个性</p>"},{"url":"dessert/kb_detail02.jpg","detail_text":""}]',FALSE,NULL,NULL,60);
