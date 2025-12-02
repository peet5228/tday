<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">จัดการตัวชี้วัด</h1>
                    <v-form @submit.prevent="saveMember">
                        <v-row class="mt-4">
                            <v-col cols="12" md="6">
                                <v-select v-model="form.id_topic" :items="topic.map(t => ({ title:t.name_topic,value:t.id_topic }))" label="เลือกหัวข้อการประเมิน" />
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-text-field v-model="form.name_indicate" label="ชื่อตัวชี้วัด" />
                            </v-col>
                            <v-col cols="12" md="12">
                                <v-textarea rows="3" v-model="form.detail_indicate" label="รายละเอียด" />
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-text-field v-model="form.point_indicate" type="number" label="น้ำหนักคะแนน" />
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-select v-model="form.check_indicate" :items="[{title:'มี',value:'y'},{title:'ไม่มี',value:'n'}]" label="ลักษณะตัวเลือกคะแนน" />
                            </v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="blue" type="submit">{{ form.id_indicate ? 'อัปเดต' : 'บันทึก' }}</v-btn></v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="error" type="reset">ยกเลิก</v-btn></v-col>
                        </v-row>
                    </v-form>

                    <br>

                    <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">หัวข้อ</th>
                                <th class="text-center border">ตัวชี้วัด</th>
                                <th class="text-center border">รายละเอียด</th>
                                <th class="text-center border">น้ำหนักคะแนน</th>
                                <th class="text-center border">ลักษณะตัวเลือกคะแนน</th>
                                <th class="text-center border">จัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(items,index) in result" :key="items.id_indicate">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ items.name_topic }}</td>
                                <td class="text-center border">{{ items.name_indicate }}</td>
                                <td class="text-center border">{{ items.detail_indicate }}</td>
                                <td class="text-center border">{{ items.point_indicate }}</td>
                                <td class="text-center border">{{ items.check_indicate === 'y' ? 'มี' : 'ไม่มี' }}</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"  @click="edit(items)">แก้ไข</v-btn>&nbsp;
                                    <v-btn color="error" class="text-white" size="small"  @click="del(items.id_indicate)">ลบ</v-btn>
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
const api = import.meta.env?.VITE_BASE_API || 'http://localhost:3001/api/Staff'
const token = localStorage.getItem('token')

const result = ref([])
const topic = ref([])

const form = ref({
    id_indicate:null,
    id_topic:'',
    name_indicate:'',
    detail_indicate:'',
    point_indicate:'',
    check_indicate:'',
})

const reset = () => {
    form.value = {
        id_indicate:null,
        id_topic:'',
        name_indicate:'',
        detail_indicate:'',
        point_indicate:'',
        check_indicate:'',
    }
}

const fetch = async () => {
    try{
       const t = await axios.get(`${api}/topic`,{headers:{Authorization: `Bearer ${token}`}})
       topic.value = t.data
       const res = await axios.get(`${api}/indicate`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = res.data 
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const saveMember = async () =>{
    try{
        if(form.value.id_indicate){
            await axios.put(`${api}/indicate/${form.value.id_indicate}`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        }else{
            await axios.post(`${api}/indicate`,form.value,{headers:{Authorization: `Bearer ${token}`}})
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

const del = async (id_indicate:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่')) return
        await axios.delete(`${api}/indicate/${id_indicate}`,{headers:{Authorization: `Bearer ${token}`}})
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