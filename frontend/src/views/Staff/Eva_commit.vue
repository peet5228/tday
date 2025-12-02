<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">ตั้งค่ากรรมการ</h1>
                    <v-form @submit.prevent="saveMember">
                        <v-row class="mt-4">
                            <v-col cols="12" md="6">
                                <v-text-field v-model="form.day_eva" type="date" label="วันที่ออกแบบการประเมิน" />
                            </v-col>
                            <v-col cols="12" md="6">
                                <v-select v-model="form.id_member" :items="member.map( m => ({title:`${m.first_name} ${m.last_name}`,value:m.id_member}))" label="เลือกผู้รับการประเมินผล" />
                            </v-col>
                            <v-col cols="12" md="12">
                                <v-select v-model="form.id_sys" :items="round.map( r => ({title:`รอบที่ ${r.round_sys} ปี ${r.year_sys}`,value:r.id_sys}))" label="เลือกรอบการประเมิน" />
                            </v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="blue" type="submit">{{ form.id_eva ? 'อัปเดต' : 'บันทึก' }}</v-btn></v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="error" type="reset">ยกเลิก</v-btn></v-col>
                        </v-row>
                    </v-form>

                    <br>

                    <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">กรรมการ</th>
                                <th class="text-center border">ตำแหน่ง</th>
                                <th class="text-center border">จัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(items,index) in result" :key="items.id_commit">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                <td class="text-center border">รอบที่ {{ items.round_sys }} ปี {{ items.year_sys }}</td>
                                <td class="text-center border">{{ items.day_eva }}</td>
                                <td class="text-center border">{{ items.status_eva === 1 ? 'ประเมินตนเอง' : items.status_eva === 2 ? 'กรรมการประเมิน' : 'ประเมินเสร็จสิ้น' }}</td>
                                <td class="text-center border">
                                    <v-btn color="warning" class="text-white" size="small"  @click="edit(items)">แก้ไข</v-btn>&nbsp;
                                    <v-btn color="error" class="text-white" size="small"  @click="del(items.id_eva)">ลบ</v-btn>
                                </td>
                                <td class="text-center border">
                                    <v-btn color="success" class="text-white" size="small"  @click="add(items.id_eva)">เพิ่มกรรมการ</v-btn>
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
const member = ref([])
const round = ref([])

const fetch = async () => {
    try{
       const m = await axios.get(`${api}/member/eva`,{headers:{Authorization: `Bearer ${token}`}})
       member.value = m.data 
       const r = await axios.get(`${api}/eva/round`,{headers:{Authorization: `Bearer ${token}`}})
       round.value = r.data 
       const res = await axios.get(`${api}/eva`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = res.data 
       console.log("Round : ",r.data)
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const saveMember = async () =>{
    try{
        if(form.value.id_eva){
            await axios.put(`${api}/eva/${form.value.id_eva}`,form.value,{headers:{Authorization: `Bearer ${token}`}})
        }else{
            await axios.post(`${api}/eva`,form.value,{headers:{Authorization: `Bearer ${token}`}})
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

const del = async (id_eva:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่')) return
        await axios.delete(`${api}/eva/${id_eva}`,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
        await reset()
    }catch(err){
        console.error('Error Delete',err)
    }
}

const add = (id_eva:number) => {
    router.push({path:`Eva_commt/${id_eva}`})
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