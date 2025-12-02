<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">Dashboard - STAFF</h1>
                    <br>
                   <v-row>
                    <v-col cols="12" md="4" v-for="b in box" :key="b">
                        <v-card elevation="3" class="pa-4">
                            <div class="font-weight-bold">{{ b.label }}</div>
                            <div class="text-h3 font-weight-bold">{{ b.value }}</div>
                        </v-card>
                    </v-col>
                   </v-row>
                </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { ref,onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter()
const api = import.meta.env?.VITE_BASE_API || 'http://localhost:3001/api'
const token = localStorage.getItem('token')

const result = ref([])
const box = ref([])
const box2 = ref([])

const fetch = async () => {
    try{
       const res = await axios.get(`${api}/dashboard/eva`,{headers:{Authorization: `Bearer ${token}`}})
       box.value = res.data.box 
    }catch(err){
        console.error('Error Fetching',err)
    }
}

onMounted(fetch)
</script>

<style scoped>
.btn-maroon{
    background-color: #7d0c14;
}
.text-maroon{
    color: #7d0c14;
}
</style>