<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">แนบเอกสารการประเมินหรือคู่มือการประเมิน</h1>
                    <v-form @submit.prevent="saveMember">
                        <v-row class="mt-4">
                            <v-col cols="12" md="12">
                                <v-text-field v-model="name_doc" label="ชื่อเอกสาร"></v-text-field>
                            </v-col>
                            <v-col cols="12" md="12">
                                <v-file-input v-model="file" label="ไฟล์"  accept=".doc,.docx,.png,.pdf,.txt,image/*"/>
                            </v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="blue" type="submit">บันทึก</v-btn></v-col>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="error" type="reset">ยกเลิก</v-btn></v-col>
                        </v-row>
                    </v-form>

                    <br>

                    <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">ชื่อเอกสาร</th>
                                <th class="text-center border">วันที่เพิ่ม</th>
                                <th class="text-center border">ไฟล์</th>
                                <th class="text-center border">จัดการ</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(items,index) in result" :key="items.id_doc">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ items.name_doc }}</td>
                                <td class="text-center border">{{ items.day_doc }}</td>
                                <td class="text-center border">
                                    <v-btn class="text-white" color="warning" @click="view(items.file)">เปิดดู</v-btn>
                                </td>
                                <td class="text-center border">
                                    <!-- <v-btn color="warning" class="text-white" size="small"  @click="edit(items)">แก้ไข</v-btn>&nbsp; -->
                                    <v-btn color="error" class="text-white" size="small"  @click="del(items.id_doc)">ลบ</v-btn>
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
const name_doc = ref('')
const file = ref<File | null>(null)

const fetch = async () => {
    try{
       const res = await axios.get(`${api}/doc`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = res.data 
    }catch(err){
        console.error('Error Fetching',err)
    }
}


const saveMember = async () =>{
    try{
        const formData = new FormData()
        formData.append('name_doc',name_doc.value)
        formData.append("file",file.value)
        await axios.post(`${api}/doc`,formData,{headers:{Authorization: `Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await fetch()
    }catch(err){
        console.error('ทำรายการไม่สำเร็จ',err)
    }
}

const del = async (id_doc:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่')) return
        await axios.delete(`${api}/doc/${id_doc}`,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
    }catch(err){
        console.error('Error Delete',err)
    }
}

const view = (filename:string) => {
    const url = new URL (`/uploads/document/${filename}`,api).href
    window.open(url,'_blank')
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