<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">รายงานผล</h1>

                    <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">หัวข้อรายงาน</th>
                                <th class="text-center border">รายงาน</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-center border">1</td>
                                <td class="text-center border">ผู้รับการประเมินทั้งหมด</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"><router-link to="/Report_eva">รายงาน</router-link></v-btn>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center border">2</td>
                                <td class="text-center border">กรรมการประเมินทั้งหมด</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"><router-link to="/Report_commit">รายงาน</router-link></v-btn>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center border">3</td>
                                <td class="text-center border">ผู้รับการประเมินที่ประเมินสำเร็จ</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"><router-link to="/Report_Y">รายงาน</router-link></v-btn>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center border">4</td>
                                <td class="text-center border">ผู้รับการประเมินที่ประเมินไม่สำเร็จ</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"><router-link to="/Report_N">รายงาน</router-link></v-btn>
                                </td>
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
const api = import.meta.env?.VITE_BASE_API || 'http://localhost:3001/api/Staff'
const token = localStorage.getItem('token')

const result = ref([])

const form = ref({
    id_topic:null,
    name_topic:'',
})

const reset = () => {
    form.value = {
        id_topic:null,
        name_topic:'',
    }
}

const fetch = async () => {
    try{
       const res = await axios.get(`${api}/topic`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = res.data 
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const error = ref<Record<string,string>>({})

function vaildateForm(){
    error.value = {}
    const f = form.value
    if(!f.name_topic.trim())error.value.name_topic='กรุณากรอกชื่อหัวข้อการประเมิน'
    return Object.keys(error.value).length === 0
}
const saveMember = async () =>{
    if(!vaildateForm())return
    try{
        if(form.value.id_topic){
            await axios.put(`${api}/topic/${form.value.id_topic}`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        }else{
            await axios.post(`${api}/topic`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        }
        alert('ทำรายการสำเร็จ')
        await fetch()
        await reset()
    }catch(err){
        console.error('ทำรายการไม่สำเร็จ',err)
    }
}

const edit = (items:any) => {
    form.value = {...items}
}

const del = async (id_topic:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่')) return
        await axios.delete(`${api}/topic/${id_topic}`,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
        await reset()
    }catch(err){
        console.error('Error Delete',err)
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