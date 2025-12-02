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
                   <v-row>
                    <v-col cols="12" md="6" v-for="b in box2" :key="b">
                        <v-card elevation="3" class="pa-4">
                            <div class="font-weight-bold">{{ b.label }}</div>
                            <div class="text-h3 font-weight-bold">{{ b.value }}</div>
                        </v-card>
                    </v-col>
                   </v-row>

                   <br>

                   <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">ผู้รับการประเมินผล</th>
                                <th class="text-center border">รอบการประเมิน</th>
                                <th class="text-center border">วันที่ออกแบบการประเมิน</th>
                                <th class="text-center border">สถานะการประเมิน</th>
                                <th class="text-center border">รายละเอียด</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(items,index) in result" :key="items.id_eva">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                <td class="text-center border">รอบที่ {{ items.round_sys }} ปี {{ items.year_sys }}</td>
                                <td class="text-center border">{{ items.day_eva }}</td>
                                <td class="text-center border">
                                    <v-btn :color="bg(items.status_eva)" class="text-white" size="small">{{ items.status_eva === 1 ? 'ประเมินตนเอง' : items.status_eva === 2 ? 'กรรมการประเมิน' : 'ประเมินเสร็จสิ้น' }}</v-btn>
                                </td>
                                <td class="text-center border">
                                    <v-btn color="success" class="text-white" size="small"  @click="add(items.id_eva)">รายละเอียด</v-btn>
                                </td>
                            </tr>
                            <tr v-if="result.length === 0">
                                <td class="text-center border text-gray-500" colspan="7">ไม่พบข้อมูล</td>
                            </tr>
                        </tbody>
                    </v-table>
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
       const res = await axios.get(`${api}/dashboard/staff`,{headers:{Authorization: `Bearer ${token}`}})
       box.value = res.data.box 
       box2.value = res.data.box2 
       const r = await axios.get(`${api}/Staff/eva/all`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = r.data 
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const bg = (status_eva:string) => {
    if(status_eva === 1) return 'blue'
    if(status_eva === 2) return 'warning'
    if(status_eva === 3) return 'success'
}

const add = (id_eva:number) => {
    router.push({path:`ScoreEva/${id_eva}`})
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