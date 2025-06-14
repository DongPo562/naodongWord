import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      redirect: '/app',
    },
    {
      path: '/app',
      name: 'app',
      component: () => import('../App.vue'),
    },
  ],
})

export default router
