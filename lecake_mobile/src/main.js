import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Vant from 'vant';
import 'vant/lib/index.css';
import axios from 'axios';

import { Lazyload } from 'vant';


Vue.prototype.$axios = axios;
axios.defaults.baseURL = 'http://127.0.0.1:3000';
Vue.use(Vant);
Vue.use(Lazyload);
Vue.config.productionTip = false

// 设置路由守卫
router.beforeEach((to,from,next)=>{
  if(to.meta.guard){
    store.state.isLogin?next():next("/login")
  }else{
    next();
  }
});


new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
