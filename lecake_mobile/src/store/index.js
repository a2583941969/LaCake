import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    isLogin:localStorage.getItem("isLogin")||false,
    phoneNum:localStorage.getItem("phoneNum")||'',
    shopcart:localStorage.getItem("shopcart")||[]
  },
  mutations: {
    set_isLogin(state,bool){
      state.isLogin=bool;
    },
    set_phoneNum(state,tel){
      state.phoneNum=tel;

    }
  },
  actions: {
  },
  modules: {
  }
})
