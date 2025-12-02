import { createRouter, createWebHistory } from 'vue-router'
import LoginForm from '../LoginForm.vue'
import RegisterForm from '@/RegisterForm.vue'
import UserLayout from '@/components/UserLayout.vue'

//
import Evaluatee from '@/views/Evaluatee/index.vue'
import DashboardStaff from '@/views/Staff/dashboardStaff.vue'
import ManageEva from '@/views/Staff/ManageEva.vue'
import ManageCommit from '@/views/Staff/ManageCommit.vue'
import Topic from '@/views/Staff/Topic.vue'

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
    //Staff
    {
      path: '/Staff',
      component: UserLayout,
      children:[
        {
          path: '/Staff',
          name: 'Staff',
          component: DashboardStaff,
        },
        {
          path: '/ManageEva',
          name: 'ManageEva',
          component: ManageEva,
        },
        {
          path: '/ManageCommit',
          name: 'ManageCommit',
          component: ManageCommit,
        },
        {
          path: '/Topic',
          name: 'Topic',
          component: Topic,
        },
      ]
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
      ]
    },
  ],
})

export default router
