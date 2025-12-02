import { createRouter, createWebHistory } from 'vue-router'
import LoginForm from '../LoginForm.vue'
import RegisterForm from '@/RegisterForm.vue'
import UserLayout from '@/components/UserLayout.vue'

//
import Evaluatee from '@/views/Evaluatee/index.vue'
import Edit_eva from '@/views/Evaluatee/Edit_eva.vue'
import Selfeva from '@/views/Evaluatee/Selfeva.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    
    {
      path: '/regis',
      name: 'RegisterForm',
      component: RegisterForm,
    },
    {
      path: '/login',
      name: 'LoginForm',
      component: LoginForm,
    },
    {
      path: '/',
      redirect: '/login',
    },

    //eva
    {
      path: '/Evaluatee',
      component: UserLayout,
      children:[
        {
          path: '/Evaluatee',
          name: 'Evaluatee',
          component: Evaluatee,
        },
        {
          path: '/Edit_eva',
          name: 'Edit_eva',
          component: Edit_eva,
        },
        {
          path: '/Selfeva',
          name: 'Selfeva',
          component: Selfeva,
        },
      ]
    },
  ],
})

export default router
