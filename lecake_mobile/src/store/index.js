import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    isLogin:localStorage.getItem("isLogin")||false,
    phoneNum:localStorage.getItem("phoneNum")||'',
    shopcart:JSON.parse(localStorage.getItem("shopcart"))||[]
  },
  mutations: {
    set_isLogin(state,bool){
      state.isLogin=bool;
    },
    set_phoneNum(state,tel){
      state.phoneNum=tel;
    },
    set_shopcart(state,obj){
      if(obj==undefined){
        state.shopcart.splice(0)
      }else{
        state.shopcart.unshift(obj)
      }
    }
  },
  actions: {
  },
  modules: {
  }
})
