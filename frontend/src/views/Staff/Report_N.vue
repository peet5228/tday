<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <v-btn color="warning" prepend-icon="mdi-printer" @click="print()" class="no-print right">พิมพ์รายงาน</v-btn>
                    <h1 class="text-center text-h5 font-weight-bold">ผู้รับการประเมินที่ประเมินไม่สำเร็จ</h1><br>
                    <!-- <br> -->
                   <v-table class="table">
                        <thead>
                            <tr class="bg-gray-400">
                                <th class="text-center border">ลำดับ</th>
                                <th class="text-center border">ผู้รับการประเมินผล</th>
                                <th class="text-center border">รอบการประเมิน</th>
                                <th class="text-center border">วันที่ออกแบบการประเมิน</th>
                                <th class="text-center border">สถานะการประเมิน</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(items,index) in result" :key="items.id_eva">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ items.first_name }} {{ items.last_name }}</td>
                                <td class="text-center border">รอบที่ {{ items.round_sys }} ปี {{ items.year_sys }}</td>
                                <td class="text-center border">{{ items.day_eva }}</td>
                                <td class="text-center border">
                                   {{ items.status_eva === 1 ? 'ประเมินตนเอง' : items.status_eva === 2 ? 'กรรมการประเมิน' : 'ประเมินเสร็จสิ้น' }}
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

const api = import.meta.env?.VITE_BASE_API || 'http://localhost:3001/api/Staff'
const token = localStorage.getItem('token')

const result = ref([])


const fetch = async () => {
    try{
       const res = await axios.get(`${api}/report`,{headers:{Authorization: `Bearer ${token}`}})
       result.value = res.data.n
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const print = () => {
    window.print()
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
@media print {
    .no-print {
        display: none ;
    }
}

</style>