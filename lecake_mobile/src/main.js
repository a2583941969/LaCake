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

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
