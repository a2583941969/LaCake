<template>
  <div class="shopcart">
    <div v-if="$store.state.shopcart.length==0">
      <div class="no-shop">
        <img src="../assets/cart/empty.png" alt />
        <p>您还没有选购您的商品</p>
      </div>
      <!-- 推荐 -->
      <div class="recommend">
        <div class="division">
          <h2>推荐商品</h2>
          <h3>Sincerely Recommend</h3>
        </div>
        <div class="pro-list">
          <pro-show
            v-for="(pro,i) of products"
            :key="i"
            :url="pro.img_show"
            :pname="pro.pname"
            :ptext="pro.ptext"
            :pid="pro.pid"
            :price="pro.pspecs[0].price"
          ></pro-show>
        </div>
      </div>
    </div>
    <div v-else>
      <div class="group_list_nav">
        <div>
          <label class="child">派对必备 欢喜加倍</label>
          <span class="child">加购超值组合专享礼</span>
          <a href="javascript:;" class="child">点击选购></a>
        </div>
      </div>
      <div class="cart-list">
        <div class="promotion_inner" @click="promotionShow">
          <span>赠品</span>
          <strong>即日起至2020.10.31，单笔正价购买此蛋糕并选择周五至周日配送，赠「盒子蛋糕」一个，口味随机。本活动不与其他优惠同享（如优惠券、蛋糕券、兑换券、储值卡、银行优惠等）。</strong>
        </div>
        <div class="goods_item">
          <p>
            <span>促销</span>
            <strong>周末庆生专享 赠盒子蛋糕</strong>
          </p>
          <div class="goods_info" v-for="(pro,i) of $store.state.shopcart" :key="i">
            <a href="javascript:;">
              <van-checkbox v-model="pro.ischecked" checked-color="#ff4001"></van-checkbox>
            </a>
            <div class="goods_message">
              <router-link :to="'/detail?pid='+pro.pid">
                <div>
                  <img v-lazy="pro.img" alt />
                </div>
              </router-link>
              <div class="goods_detail">
                <h2>{{pro.pname}}</h2>
                <div class="standard_fitting">
                  <p class="fork">每份含餐具5套</p>
                </div>
                <div class="price_wrap">
                  <p>
                    ￥
                    <strong>{{pro.price*pro.count}}</strong>
                  </p>
                </div>
                <div class="input_wrap" @click="calcCount">
                  <a href="javascript:;" :data-i="i" data-n="-1" v-if="pro.count>1"></a>
                  <a href="javascript:;" :data-i="i" class="del" v-else data-del="×"></a>
                  <input type="number" v-model="pro.count" />
                  <a href="javascript:;" :data-i="i" data-n="+1"></a>
                </div>
              </div>
            </div>
            <div class="more_info">
              <h4>
                <span>填写生日信息，免费赠送生日牌</span>
              </h4>
            </div>
          </div>
        </div>
      </div>
      <div class="amount">
        <div class="inner">
          <a href="javascript:;" @click="changeChecked">
            <van-checkbox v-model="ischeck" checked-color="#ff4001" >全选</van-checkbox>
          </a>
          <div class="clearing">
            <router-link to="#" @click.native="gotoLogin">结算</router-link>
          </div>
          <div class="total_price">
            <p>
              <span>
                应付：￥
                <strong>{{totalPrice}}</strong>
              </span>
            </p>
          </div>
        </div>
      </div>
    </div>
    <van-popup v-model="presentshow" position="bottom" closeable>
      <h4>即日起至2020.10.31，单笔正价购买此蛋糕并选择周五至周日配送，赠「盒子蛋糕」一个，口味随机。本活动不与其他优惠同享（如优惠券、蛋糕券、兑换券、储值卡、银行优惠等）。</h4>
    </van-popup>
    <tabber :active="'shopcart'"></tabber>
  </div>
</template>

<script>
import tabber from "../components/tabbar.vue";
import proShow from "../components/proShow.vue";
import { Dialog } from "vant";

export default {
  components: {
    tabber,
    proShow,
    [Dialog.Component.name]: Dialog.Component,
  },
  data() {
    return {
      // 推荐商品数组
      products: [],
      presentshow: false,
      bool:true
    };
  },
  methods: {
    promotionShow() {
      this.presentshow = true;
    },
    calcCount(e) {
      if (e.target.nodeName == "A") {
        if (e.target.dataset.del == "×") {
          Dialog.confirm({
            message: "确认删除该商品吗?",
          }).then(() => {
            this.$store.state.shopcart.splice(e.target.dataset.i, 1);
            let shopcartJson = JSON.stringify(this.$store.state.shopcart);
            localStorage.setItem("shopcart", shopcartJson);
          }).catch(()=>{

          });
        } else {
          let i = e.target.dataset.i;
          if (
            this.$store.state.shopcart[i].count > 1 ||
            e.target.dataset.n == 1
          ) {
            this.$store.state.shopcart[i].count += parseInt(e.target.dataset.n);
            let shopcartJson = JSON.stringify(this.$store.state.shopcart);
            localStorage.setItem("shopcart", shopcartJson);
          }
        }
      }
    },
    changeChecked(e){
      this.$store.state.shopcart.forEach(obj=>{
        if(this.bool){
          obj.ischecked=false;
        }else{
          obj.ischecked=true;
        }
      })
      this.bool=!this.bool;
    },
    gotoLogin(){
      if(!this.$store.state.isLogin){
        this.$router.push("/login")
      }
    }
  },

  computed: {
    totalPrice() {
      let sum = 0;
      for (let p of this.$store.state.shopcart) {
        if (p.ischecked) {
          sum += p.price * p.count;
        }
      }
      return sum;
    },
    ischeck(){
      return this.$store.state.shopcart.every(obj=>{
        return obj.ischecked && this.bool
      })
    }
  },
  mounted() {
    this.$axios.get("/detail/prolist?iscake=1&taste=").then((res) => {
      // 对请求到的商品信息数据做处理
      res.data.forEach((e) => {
        // 图片展示路径前拼接  http://127.0.0.1:3000/public/img/details/
        e.img_show = "http://127.0.0.1:3000/public/img/details/" + e.img_show;
        // 将商品规格转为数组对象
        e.pspecs = JSON.parse(e.pspecs);
        this.products.push(e);
      });
    });
  },
};
</script>

<style>
div.shopcart div.no-shop{
  position: relative;
  height: 2.2rem;
  text-align: center;
}
div.shopcart div.no-shop > img {
  width: 0.76rem;
  position: absolute;
  left: 50%;
  top: 0.6rem;
  margin-left: -0.42rem;
}
div.shopcart div.no-shop > p {
  position: absolute;
  width: 100%;
  top: 1.5rem;
  font-size: 0.1rem;
  color: #9c9c9c;
}
div.shopcart div.recommend > div.division {
  border-top: 1px solid #d1c6af;
  padding: 0.2rem 0 0;
  color: #a38d6b;
  text-align: center;
  margin: 0 0.16rem;
}
div.shopcart div.recommend > div.division>h2 {
  height: 0.5rem;
  line-height: 0.5rem;
  font-weight: bold;
  font-size: 0.15rem;
}
div.shopcart div.recommend > div.division>h3 {
  font-size: 0.12rem;
}
div.pro-list {
  padding: 0.15rem;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
div.group_list_nav {
  background: #ffffff;
  margin-bottom: 0.1rem;
}
div.group_list_nav > div {
  position: relative;
  padding: 0.15rem 0.2rem;
  font-size: 0.12rem;
}
div.group_list_nav > div::after {
  content: "";
  display: block;
  clear: both;
}
div.group_list_nav > div .child {
  float: left;
}
div.group_list_nav > div label {
  background: #ff4001;
  color: #ffffff;
  height: 0.16rem;
  line-height: 0.16rem;
  padding: 0 6px;
  border-radius: 2px;
  margin-right: 4px;
  font-size: 0.1rem;
}
div.group_list_nav > div > a.child {
  float: right;
  height: 0.16rem;
  line-height: 0.16rem;
  color: #ff4001;
  text-decoration: underline;
  position: relative;
}
div.cart-list {
  background-color: #fff;
}
div.cart-list div.promotion_inner {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 0.08rem 0.2rem;
  border-bottom: 1px solid #f4f4f4;
  position: relative;
}
div.cart-list div.promotion_inner span {
  font-size: 10px;
  padding: 1px 4px;
  color: #ffffff;
  background: #ff4001;
  display: block;
  border-radius: 2px;
  margin-right: 0.05rem;
}
div.cart-list div.promotion_inner strong {
  display: block;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 11px;
}
div.shopcart div.van-popup {
  padding-top: 0.3rem;
}
div.shopcart div.van-popup h4 {
  padding: 0.2rem 0.2rem 0.5rem;
  max-height: 56vh;
  overflow: hidden;
  overflow-y: auto;
  font-size: 0.12rem;
}
div.cart-list > div.goods_item > p {
  padding: 0.06rem 0.4rem 0.06rem 0.2rem;
  top: 0.04rem;
  display: flex;
  justify-content: center;
  align-items: center;
  position: relative;
}
div.cart-list div.goods_item > p > span {
  color: #af916d;
  position: relative;
  background: transparent;
  font-size: 10px;
  padding: 1px 4px;
  display: block;
  border-radius: 2px;
  margin-right: 0.05rem;
}
div.cart-list div.goods_item > p > span::before {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  left: 0;
  top: 0;
  border: 1px solid #af916d;
  border-radius: 2px;
  box-sizing: border-box;
}
div.cart-list > div.goods_item > p > strong {
  display: block;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  font-size: 11px;
}
div.cart-list div.goods_item > p::after {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -1.6rem -0.6rem;
  right: 0.18rem;
  transform: rotate(-90deg);
}
div.cart-list div.goods_item div.goods_info {
  padding: 0.1rem 0.2rem 0 0.5rem;
  position: relative;
  min-height: 1.1rem;
}
div.cart-list div.goods_item div.goods_info > a {
  position: absolute;
  width: 0.4rem;
  height: 0.9rem;
  left: 0.1rem;
  top: 0.1rem;
}
div.cart-list div.goods_item div.goods_info a div.van-checkbox {
  position: absolute;
  top: 50%;
  left: 50%;
  margin-top: -0.1rem;
  margin-left: -0.1rem;
}
div.cart-list div.goods_message {
  position: relative;
}
div.cart-list div.goods_message > a > div {
  position: relative;
  width: 0.9rem;
  height: 0.9rem;
  float: left;
}
div.cart-list div.goods_message > a > div > img {
  max-width: none;
  max-height: 100%;
  position: relative;
  left: 50%;
  top: 50%;

  transform: translate(-50%, -50%);
}
div.cart-list div.goods_message > div.goods_detail {
  position: relative;
  margin-left: 1rem;
  height: 0.9rem;
}
div.cart-list div.goods_message > div.goods_detail > h2 {
  height: 0.24rem;
  line-height: 0.24rem;
  font-size: 0.12rem;
  color: #ff4001;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
div.cart-list div.goods_message > div.goods_detail > div.standard_fitting {
  font-size: 0.11rem;
  color: #9c9c9c;
}
div.cart-list div.goods_message > div.goods_detail > div.standard_fitting > p {
  position: relative;
  height: 0.16rem;
  line-height: 0.16rem;
  padding-left: 0.12rem;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.standard_fitting
  > p::before {
  content: "";
  position: absolute;
  width: 0.12rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -0.44rem 0;
  left: -0.02rem;
}
div.cart-list div.goods_message > div.goods_detail > div.price_wrap {
  position: absolute;
  left: 0;
  bottom: 0;
  font-size: 0.09rem;
}
div.cart-list div.goods_message > div.goods_detail > div.price_wrap > p {
  display: inline-block;
  color: rgb(255, 64, 1);
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.price_wrap
  > p
  > strong {
  font-size: 0.12rem;
}
div.cart-list div.goods_message > div.goods_detail > div.input_wrap {
  position: absolute;
  width: 1.14rem;
  height: 0.25rem;
  bottom: 0;
  right: 0;
  z-index: 1;
  border-radius: 2px;
  overflow: hidden;
}
div.cart-list div.goods_message > div.goods_detail > div.input_wrap > input {
  position: absolute;
  width: 0.32rem;
  height: 0.25rem;
  background: #efefef;
  z-index: 1;
  top: 0;
  left: 50%;
  margin-left: -0.16rem;
  text-align: center;
  line-height: normal;
  border: 0;
  outline: 0;
  color: rgb(255, 64, 1);
  box-sizing: border-box;
}
div.cart-list div.goods_message > div.goods_detail > div.input_wrap > a {
  position: absolute;
  width: 0.38rem;
  height: 100%;
  z-index: 2;
  top: 0;
  background: #efefef;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.input_wrap
  > a:first-child {
  left: 0;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.input_wrap
  > a:last-child {
  right: 0;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.input_wrap
  > a::before {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: 0 0;
  left: 50%;
  margin-left: -0.1rem;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.input_wrap
  > a:last-child::before {
  background-position: -0.2rem 0;
}
div.cart-list
  div.goods_message
  > div.goods_detail
  > div.input_wrap
  > a.del::before {
  background: url("../assets/icons_1.png") no-repeat center;
  background-position: -1.4rem -0.4rem;
  background-size: 2rem 2rem;
}
div.cart-list div.more_info {
  margin-top: 0.1rem;
  min-height: 0.5rem;
}
div.cart-list div.more_info > h4 {
  background: #f9f9f9;
  position: relative;
  height: 0.4rem;
  line-height: 0.4rem;
}
div.cart-list div.more_info > h4 > span {
  display: inline-block;
  padding: 0 0.2rem 0 0.2rem;
  position: relative;
  font-size: 0.12rem;
  color: #9c9c9c;
}
div.cart-list div.more_info > h4 > span::before {
  content: "";
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  background: url("../assets/icons_1.png") no-repeat center;
  background-size: 2rem 2rem;
  top: 50%;
  margin-top: -0.1rem;
  background-position: -1.6rem -0.4rem;
  right: 0;
}
div.amount {
  height: 0.5rem;
  margin-top: 0.1rem;
  background: transparent;
}
div.amount div.inner {
  position: fixed;
  z-index: 100;
  height: 0.5rem;
  left: 0;
  bottom: 0.55rem;
  bottom: calc(0.55rem + env(safe-area-inset-bottom));
  width: 100%;
  background: #ffffff;
}
div.amount div.inner > a {
  height: 0.5rem;
  top: 0;
  position: absolute;
  width: 0.4rem;
  left: 0.1rem;
}
div.amount div.inner > a::after{
  content: '';
  display: block;
  width: 1rem;
  height: 0.5rem;
  position: absolute;
  top: 0;
  left: 0;
}
div.amount div.inner > div.clearing {
  float: right;
}
div.amount div.inner > div.total_price {
  float: right;
  text-align: right;
  margin-right: 0.08rem;
}
div.amount div.inner > a > div.van-checkbox > span.van-checkbox__label {
  position: absolute;
  top: 50%;
  margin-top: -0.08rem;
  left: 0.26rem;
  width: 0.4rem;
  height: 0.16rem;
  font-size: 0.12rem;
}
div.amount div.inner > a > div.van-checkbox > div.van-checkbox__icon {
  position: absolute;
  width: 0.2rem;
  height: 0.2rem;
  top: 50%;
  margin-top: -0.1rem;
  left: 50%;
  margin-left: -0.1rem;
}
div.amount div.inner > div.clearing > a {
  width: 0.9rem;
  background: #ff4001;
  float: left;
  height: 0.5rem;
  color: #ffffff;
  font-size: 0.11rem;
  display: table;
  text-align: center;
  line-height: 0.5rem;
}
div.amount div.inner > div.total_price > p {
  height: 0.5rem;
  display: table-cell;
  vertical-align: middle;
}
div.amount div.inner > div.total_price > p > span {
  font-size: 0.1rem;
  display: block;
}
div.amount div.inner > div.total_price > p > span > strong {
  font-size: 0.12rem;
  font-weight: bold;
  color: #ff4001;
}
</style>