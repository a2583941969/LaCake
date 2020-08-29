<template>
  <div class="detail">
    <div v-if="pro_blurb">
      <!-- banner区域 -->
      <van-swipe :autoplay="3000">
        <van-swipe-item v-for="(image, index) in pro_blurb.pbanner" :key="index">
          <img v-lazy="'http://127.0.0.1:3000/public/img/details/'+image" />
        </van-swipe-item>
      </van-swipe>
      <!-- 商品信息 -->
      <div class="product-info">
        <div class="top">
          <h2>{{pro_blurb.pname}}</h2>
          <div>
            <p>
              <small>￥</small>
              <strong>{{price}}</strong>
            </p>
          </div>
          <a href="javascrpt:;">
            <i></i>
          </a>
        </div>
        <!-- 开通会员 -->
        <a href="javascript:;">
          <div class="aha_entrance">
            <h3>aha会员尊享多重礼遇</h3>
            <h4 class="desc_text">开通仅¥99 预计可省¥358</h4>
            <strong class="right">￥99开通</strong>
          </div>
        </a>
        <!-- 商品规格 -->
        <div class="spec_selected">
          <h3 @click="onClickButton">已选规格: {{servings}}</h3>
          <div>
            <p>奶油芝士蛋糕</p>
            <p>
              甜度
              <i></i>
            </p>
          </div>
        </div>
        <!-- 赠品 -->
        <div class="promotion">
          <div>
            <div>
              <p>
                <b>赠品</b>
                <span>周末庆生专享 赠盒子蛋糕</span>
              </p>
              <p>
                <b>限时加购</b>
                <span>+66元享盒子蛋糕组合</span>
              </p>
              <i></i>
            </div>
          </div>
        </div>
        <!-- 评论专区 -->
        <div class="goods_comments">
          <p>
            <a href="javascript:;">暂无更多评论</a>
          </p>
        </div>
        <!-- 详情介绍 -->
      </div>
      <!-- 商品详情介绍 -->
      <div class="goods-desc">
        <!-- 图片区域 -->
        <div class="imgDesc_wrap" v-if="!pro_blurb.isimg">
          <div v-for="(img,i) of pro_blurb.pdetail" :key="i">
            <img
              v-lazy="'http://127.0.0.1:3000/public/img/details/'+img"
              v-if="img.url==undefined"
              alt
            />
            <img v-lazy="'http://127.0.0.1:3000/public/img/details/'+img.url" v-else alt />
          </div>
        </div>
        <div class="goodDesc" v-else>
          <div class="desc_col">
            <h2>找寻心中的美味</h2>
            <div>
              <img
                v-lazy="'http://127.0.0.1:3000/public/img/details/'+pro_blurb.pdetail[0].url"
                alt
              />
            </div>
            <div v-html="pro_blurb.pdetail[0].detail_text"></div>
          </div>
          <div class="desc_col">
            <h2>严选食材</h2>
            <div>
              <img
                v-lazy="'http://127.0.0.1:3000/public/img/details/'+pro_blurb.pdetail[1].url"
                alt
              />
            </div>
          </div>
          <div class="desc_col_if" v-if=" pro_blurb.pdetail.length>2 ">
            <div>
              <img
                v-lazy="'http://127.0.0.1:3000/public/img/details/'+pro_blurb.pdetail[2].url"
                alt
              />
            </div>
            <div
              v-html="pro_blurb.pdetail[2].detail_text"
              v-if="pro_blurb.pdetail[2].detail_text!=''"
            ></div>
          </div>
          <div class="desc_col_if" v-if="pro_blurb.f_id!==60">
            <div>
              <p>用心发打而成的美味奶油</p>
              <p>口感绵密，精致细腻</p>
              <p>这份雪白</p>
              <p>让你有如获至宝的幸福感</p>
            </div>
            <div>
              <img src="http://127.0.0.1:3000/public/img/details/birthday/cream.jpg" alt />
            </div>
          </div>
          <div class="desc_col_if" v-if="pro_blurb.f_id!==60">
            <div>
              <img src="http://127.0.0.1:3000/public/img/details/birthday/cheese.jpg" alt />
            </div>
            <div>
              <p>选用上等芝士</p>
              <p>激发本真风味</p>
              <p>浓郁香滑</p>
              <p>入口即溶</p>
            </div>
          </div>
        </div>
        <div class="desc_col">
          <h2>关于食用</h2>
          <div class="text_wrap" v-if="pro_blurb.f_id==60" v-html="pro_blurb.pedible"></div>
          <div class="text_wrap" v-else>
            <p>口味：{{pro_blurb.pedible[0].taste}}</p>
            <p>适合人群：大众</p>
            <p>保鲜条件：冷藏0-4摄氏度</p>
            <p>食用方法：请收到蛋糕后2-3小时内食用</p>
            <p class="orange">温馨提示：{{pro_blurb.pedible[0].warm}}</p>
          </div>
        </div>
        <div class="desc_col">
          <h2>{{pro_blurb.pname}}</h2>
          <p v-for="(item,i) of pro_blurb.pro_text" :key="i">{{item}}</p>
          <img src="http://127.0.0.1:3000/public/img/details/birthday/details.jpg" alt />
        </div>
      </div>
    </div>
    <!-- 其他商品推荐 -->
    <div class="recommend">
      <h2>
        <span>猜你喜欢</span>
      </h2>
      <div>
        <pro-show
          @sad="valuepid"
          v-for="(pro,i) of products"
          :key="i"
          :url="pro.img_show"
          :pname="pro.pname"
          :ptext="pro.ptext"
          :pid="pro.pid"
          :price="pro.pspecs[0].price"
          :bool="bool"
        ></pro-show>
      </div>
    </div>
    <!-- 底部导航栏 -->
    <van-goods-action>
      <van-goods-action-icon v-for="(url,i) of icons" :key="i" :icon="url.img" :to="url.url" />
      <van-goods-action-button type="danger" text="加入购物车" @click="onClickButton" />
    </van-goods-action>
    <van-popup v-model="shopShow" closeable position="bottom">
      <div class="spec">
        <p>建议食用人数</p>
        <div class="price">
          <p class="price_left">{{spec}}</p>
          <p class="price_right">
            <span>￥{{price}}</span>
          </p>
        </div>
        <div class="goods_switch" @click="changeSpec">
          <a
            href="javascript:;"
            v-for="(item,i) of pro_blurb.pspecs"
            :key="i"
            :class="i==0?'active':''"
            :data-price="item.price"
            :data-spec="item.spec"
            :data-servings="item.servings"
          >{{item.servings}}</a>
        </div>
      </div>
      <div class="btn">
        <button @click="goShopcart">立即购买</button>
        <button @click="addCart">加入购物车</button>
      </div>
    </van-popup>
  </div>
</template>

<script>
import proShow from "../components/proShow.vue";
import { mapMutations } from "vuex";
export default {
  components: {
    proShow,
  },
  data() {
    return {
      pro_blurb: "",
      // 底部导航栏的变量
      icons: [
        {
          img: require("../assets/tabBar/index.png"),
          url: "/",
        },
        {
          img: require("../assets/tabBar/kefu.png"),
          url: "/",
        },
        {
          img: require("../assets/tabBar/shopcart.png"),
          url: "/shopcart",
        },
      ],
      // 保存商品信息的数组
      products: [],
      // 弹出层变量
      shopShow: false,
      pid: "",
      bool: false,
      // 价格
      price: "",
      // 规格
      spec: "",
      servings: "",
    };
  },
  methods: {
    ...mapMutations(["set_shopcart"]),
    onClickButton() {
      this.shopShow = true;
    },
    goShopcart(){
      this.$router.push('/shopcart')
    },
    addCart() {
      this.shopShow = false;
      // 将商品保存在一个对象里
      let pro = {
        pid: this.pro_blurb.pid,
        pname: this.pro_blurb.pname,
        price: this.price,
        img: "http://127.0.0.1:3000/public/img/details/" + this.pro_blurb.img_show,
        ischecked: true,
        count: 1,
        servings:this.servings
      };
      // 判断当缓存里没有保存购物车的属性时，直接添加至数组
      if (localStorage.getItem("shopcart") == undefined) {
        this.set_shopcart(pro);
      } else {
        // 如果有保存购物车的属性时,先判断购物车里是否有此商品的相同规格,如果有,则数量+1,如果没有,则追加至数组
        // 使用ES6 数组API  some筛选是否有相同商品相同属性
        let bool = this.$store.state.shopcart.some((item) => {
          return item.pid == pro.pid && item.servings == pro.servings;
        });
        if (bool) {
          for (let obj of this.$store.state.shopcart) {
            if (obj.pid == pro.pid && obj.servings == pro.servings) {
              obj.count++;
            }
          }
        } else {
          this.set_shopcart(pro);
        }
      }
      let shopcart = JSON.stringify(this.$store.state.shopcart);
      localStorage.setItem("shopcart", shopcart);

      this.$toast("加入成功");
    },
    // 按顺序执行的函数
    promise(pid) {
      return new Promise((resolve, reject) => {
        this.$axios.get("/detail/info?pid=" + pid).then((result) => {
          // 对请求回来的数据处理
          // 将详情页banner图切割成一个数组
          result.data[0].pbanner = result.data[0].pbanner.split("|");
          result.data[0].pro_text = result.data[0].pro_text.split("|");
          // 将商品对象内的JSON字符串格式的数据 介绍转为数组对象
          result.data[0].pspecs = JSON.parse(result.data[0].pspecs);
          if (result.data[0].f_id !== 60) {
            result.data[0].pedible = JSON.parse(result.data[0].pedible);
          }
          // 判断商品详情介绍是否包含文字
          let index = result.data[0].pdetail.indexOf("|");
          if (index == -1) {
            result.data[0].pdetail = JSON.parse(result.data[0].pdetail);
          } else {
            result.data[0].pdetail = result.data[0].pdetail.split("|");
          }
          this.pro_blurb = result.data[0];
          this.price = this.pro_blurb.pspecs[0].price;
          this.spec = this.pro_blurb.pspecs[0].spec;
          this.servings = this.pro_blurb.pspecs[0].servings;
          console.log(this.pro_blurb);
          resolve(this.pro_blurb.iscake);
        });
      }).then((iscake) => {
        this.$axios
          .get("/detail/rec?pid=" + pid + "&iscake=" + iscake)
          .then((result) => {
            result.data.forEach((e) => {
              // 图片展示路径前拼接  http://127.0.0.1:3000/public/img/details/
              e.img_show =
                "http://127.0.0.1:3000/public/img/details/" + e.img_show;
              // 将商品规格转为数组对象
              e.pspecs = JSON.parse(e.pspecs);
              this.products.push(e);
            });
          });
      });
    },
    valuepid(value) {
      this.pid = value;
      this.bool = true;
    },
    scrollToTop() {
      document.body.scrollTop = 0;
      document.documentElement.scrollTop = 0;
    },
    changeSpec(e) {
      if (e.target.nodeName == "A") {
        let aEle = e.target.parentNode.getElementsByClassName("active");
        if (aEle.length > 0) {
          aEle[0].className = "";
        }
        e.target.className = "active";
        this.price = e.target.dataset.price;
        this.spec = e.target.dataset.spec;
        this.servings = e.target.dataset.servings;
      }
    },
  },
  watch: {
    pid() {
      if (this.bool) {
        this.products = [];
        this.promise(this.pid);
        // setTimeout(()=>{
        this.scrollToTop();
        // },1000)
      }
    },
  },
  mounted() {
    this.pid = this.$route.query.pid;
    this.promise(this.pid);
  },
};
</script>

<style>
div.van-goods-action {
  height: 0.54rem;
  padding-right: 1.4rem;
  box-sizing: border-box;
  border-top: 1px solid #d1c6af;
}
div.van-goods-action-icon {
  flex: 1;
}
div.detail
  > div.van-goods-action
  > div.van-goods-action-icon
  > div.van-goods-action-icon__icon {
  width: 0.3rem;
  margin-bottom: 0;
}
div.detail
  > div.van-goods-action
  > div.van-goods-action-icon
  > div.van-goods-action-icon__icon
  img.van-icon__image {
  width: 0.3rem;
  height: 0.3rem;
}
button.van-goods-action-button {
  width: 1.4rem;
  height: 100%;
  background: #ff4001;
  font-size: 0.15rem;
  color: #ffffff;
  border-radius: 0;
  position: absolute;
  right: 0;
  margin: 0;
}
div.detail div.van-popup {
  padding: 0.16rem 0 0;
}
div.detail div.spec {
  max-height: 80vh;
  padding-bottom: 0.54rem;
}
div.detail div.spec > p {
  font-size: 0.14rem;
  padding: 0 0.16rem;
  margin-top: 0.05rem;
}
div.detail div.spec > div.price {
  padding: 0 0.16rem;
  align-items: center;
  display: flex;
}
div.detail div.spec > div.price > p.price_left {
  color: #9c9c9c;
  font-size: 0.12rem;
  flex: 1;
}
div.detail div.spec > div.price > p.price_right {
  color: #cea461;
  font-size: 0.24rem;
}

div.goods_switch {
  padding: 0 0.16rem;
  margin-bottom: 0.2rem;
}

div.goods_switch::after {
  content: "";
  display: block;
  clear: both;
}
div.goods_switch > a {
  align-items: center;
  margin-right: 2%;
  width: 23.5%;
  float: left;
  padding: 0.06rem 0.1rem;
  box-sizing: border-box;
  border: 1px solid #9c9c9c;
  color: #9c9c9c;
  text-align: center;
  font-size: 0.12rem;
}
div.goods_switch > a:nth-child(4) {
  margin: 0;
}
div.goods_switch > a:nth-child(5) {
  margin-top: 0.08rem;
}
div.goods_switch > a.active {
  border-color: #ff4001;
  background: #ff4001;
  color: #ffffff;
}

div.detail div.btn {
  position: absolute;
  width: 100%;
  height: 0.54rem;
  border-top: 1px solid #ff4001;
  left: 0;
  bottom: 0;
}
div.detail div.btn button {
  width: 50%;
  height: 100%;
  border: 0;
  outline: 0;
  font-size: 0.15rem;
  color: red;
}
div.detail div.btn button:last-child {
  background-color: #ff4001;
  color: #fff;
}

div.product-info {
  padding: 0.16rem 0.2rem;
}
div.product-info div.top {
  position: relative;
  padding: 0 0.22rem;
  text-align: center;
}
div.product-info div.top h2 {
  font-size: 0.18rem;
  margin-bottom: 0.04rem;
}
div.product-info div.top > div {
  font-size: 0.14rem;
}
div.product-info div.top > div > p {
  color: #cea461;
  font-size: 0.2rem;
}
div.product-info div.top > a {
  z-index: 2;
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  right: 0;
  top: 0;
  overflow: hidden;
}
div.product-info div.top > a > i {
  width: 0.3rem;
  height: 0.3rem;
  display: inline-block;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 3rem 3rem;
  background-position: 0 0;
}
div.aha_entrance {
  margin-top: 0.12rem;
  position: relative;
  background: #f9f9f9;
  padding: 0.06rem 0.2rem;
  border-bottom-right-radius: 3px;
  border-top-right-radius: 3px;
}
div.aha_entrance::before {
  content: "";
  position: absolute;
  width: 2px;
  height: 100%;
  background: #e8380d;
  z-index: 1;
  left: 0;
  top: 0;
}
div.aha_entrance > h3 {
  font-size: 0.14rem;
  color: #cea461;
}
div.aha_entrance > h4.desc_text {
  font-size: 0.11rem;
  color: #3e3e3e;
}
div.aha_entrance > strong.right {
  position: absolute;
  height: 0.2rem;
  line-height: 0.2rem;
  right: 0.14rem;
  top: 50%;
  margin-top: -0.1rem;
  color: #cea461;
  padding: 0 0.16rem;
}
div.aha_entrance > strong.right::before {
  content: "";
  position: absolute;
  width: 1px;
  height: 100%;
  background: #cea461;
  z-index: 1;
  top: 0;
  left: 0;
}
div.aha_entrance > strong.right::after {
  content: "";
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 3rem 3rem;
  top: 50%;
  margin-top: -0.15rem;
  background-position: -0.2rem 0;
  right: -2px;
}
div.spec_selected {
  margin-top: 0.16rem;
  font-size: 0.12rem;
}
div.spec_selected > h3 {
  position: relative;
  padding-left: 0.12rem;
}
div.spec_selected > h3::before {
  content: "";
  position: absolute;
  width: 2px;
  height: 100%;
  background: #e8380d;
  z-index: 1;
  left: 0;
  top: 0;
}
div.spec_selected > h3::after {
  content: "";
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 3rem 3rem;
  top: 50%;
  margin-top: -0.15rem;
  background-position: -0.6rem 0;
  right: 0;
}
div.spec_selected > div {
  padding-left: 0.12rem;
}
div.spec_selected > div > p {
  margin-top: 4px;
  position: relative;
}
div.spec_selected > div > p > i {
  position: absolute;
  content: "";
  width: 65px;
  height: 11px;
  top: 50%;
  margin-left: 4px;
  margin-top: -5px;
  background: url("../assets/detail/sweetIcons.png") no-repeat;
  background-size: 132px 11px;
  background-position: -40px 0;
}
div.promotion {
  padding: 0.16rem 0 0.16rem 0.2rem;
  font-size: 0.12rem;
}
div.promotion > div {
  position: relative;
}
div.promotion > div > div {
  padding-right: 0.2rem;
}
div.promotion > div > div > p:first-child {
  margin-bottom: 0.05rem;
}
div.promotion > div > div > p > b {
  background: #ff4001;
  color: #ffffff;
  padding: 2px 4px;
  border-radius: 2px;
  margin-right: 4px;
}
div.promotion > div > div > i {
  content: "";
  position: absolute;
  width: 0.3rem;
  height: 0.3rem;
  background: url("../assets/icons_5.png") no-repeat center;
  background-size: 3rem 3rem;
  top: 50%;
  margin-top: -0.15rem;
  background-position: -0.6rem 0;
  right: 0;
}
div.goods_comments {
  padding: 0.16rem 0 0.12rem;
}
div.goods_comments > p {
  text-align: center;
}
div.goods_comments > p > a {
  font-size: 0.12rem;
  color: #3e3e3e;
}

div.goodDesc {
  padding-bottom: 0.2rem;
  position: relative;
  background: #ffffff;
  margin-top: 10px;
  font-size: 0.12rem;
}

div.imgDesc_wrap > div > img {
  display: block;
}
div.desc_col {
  width: 93%;
  margin: 0 auto 20px;
}
div.desc_col > h2 {
  font-size: 0.15rem;
  padding-top: 0.2rem;
  margin: 0 0.16rem 0.2rem 0.16rem;
  text-align: center;
  color: #a6906c;
}
div.desc_col > div > p {
  text-align: center;
}
div.desc_col > div > p.goods_intro {
  width: 70%;
  margin: auto;
  text-align: justify;
}
div.desc_col_if {
  width: 93%;
  margin: 0 auto 20px;
  display: flex;
  align-items: center;
}
div.desc_col_if > div {
  flex: 1;
}

div.desc_col_if > div > p {
  text-align: center;
}
div.desc_col > div.text_wrap > p {
  width: 70%;
  margin: auto;
  line-height: 2;
  text-align: left;
  font-size: 0.12rem;
}
div.desc_col > div.text_wrap > p.orange {
  color: #ff4001;
}
div.desc_col > p {
  color: #5f5f5f;
  line-height: 2;
  font-size: 0.12rem;
  text-align: center;
}

div.recommend {
  padding-bottom: 0.54rem;
}
div.recommend > h2 {
  font-weight: bolder;
  text-align: center;
  margin-bottom: 0.05rem;
}
div.recommend > h2 > span {
  display: inline-block;
  position: relative;
  padding: 0 0.1rem;
}
div.recommend > h2 > span::after,
div.recommend > h2 > span::before {
  content: "-";
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
}
div.recommend > h2 > span::before {
  left: 0;
}
div.recommend > h2 > span::after {
  right: 0;
}
div.recommend > div {
  padding: 0 0.15rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
</style>