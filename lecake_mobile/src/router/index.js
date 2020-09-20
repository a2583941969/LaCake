import Vue from 'vue'
import VueRouter from 'vue-router'
import index from '../views/index.vue'

Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'index',
    component: index
  },
  {
    path: '/cake',
    name: 'cake',
    component: () => import('../views/cakeList.vue')
  },
  {
    path: '/dessert',
    name: 'dessert',
    component: () => import('../views/dessert.vue')
  },
  {
    path: '/detail',
    name: 'detail',

    component: () => import('../views/detail.vue')
  },
  {
    path: '/shopcart',
    name: 'shopcart',
    component: () => import('../views/shopCart.vue')
  },
  {
    path: '/mycenter',
    name: 'mycenter',
    component: () => import('../views/myCenter.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('../views/login.vue')
  },
  {
    path: '/personinfo',
    name: 'personinfo',
    component: () => import('../views/personInfo.vue'),
    meta:{guard:true}
  },
  {
    path: '/setpwd',
    name: 'setpwd',
    component: () => import('../views/setpwd.vue'),
  }
]

const router = new VueRouter({
  routes
})

export default router
