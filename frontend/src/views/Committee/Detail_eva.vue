<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 2 || user.status_eva === 3">
                    <h1 class="font-weight-bold text-h5">คะแนนประเมินของ ผู้รับการประเมิน</h1>
                    <v-card class="mt-2 pa-2">
                        <p>ชื่อ : {{ user.first_name }} {{ user.last_name }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,index1) in topics" :key="topic.id_topic" class="mt-4">
                        <v-col cols="12">
                            <h class="text-h6 font-weight-bold">{{ index1+1 }}.{{ topic.name_topic }}</h>
                            <v-table class="table">
                                <thead class="bg-grey">
                                    <tr>
                                        <th class="font-weight-bold text-center border w-1/10">ตัวชี้วัด</th>
                                        <th class="font-weight-bold text-center border w-1/10">รายละเอียดตัวชี้วัด</th>
                                        <th class="font-weight-bold text-center border w-1/10">น้ำหนักคะแนน</th>
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนเต็ม</th>
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนที่ได้</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="indicate in topic.indicates" :key="indicate.id_indicate">
                                        <td class="text-center border">{{ indicate.name_indicate }}</td>
                                        <td class="text-center border">{{ indicate.detail_indicate }}</td>
                                        <td class="text-center border">{{ indicate.point_indicate }}</td>
                                        <td class="text-center border">{{ indicate.point_indicate*4 }}</td>
                                        <td class="text-center border">{{ indicate.score_member*indicate.point_indicate }}</td>
                                    </tr>
                                </tbody>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="text-center mt-4">
                        <v-alert type="success" class="pa-2 text-end">คะแนนรวมสุทธิ : {{ totalScore || 0 }} คะแนน</v-alert>
                    </div>
                    <div class="text-center mt-4">
                        <v-btn v-if="user.status_commit === 'y'" color="success" class="text-white">ประเมินแล้ว</v-btn>
                        <v-btn v-else color="blue" class="text-white" @click="add(id_eva)">ประเมิน</v-btn>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_eva === 1" type="info">ผู้รับการประเมินยังไม่ได้กรอกแบบประเมิน</v-alert>
                <v-alert v-else type="warning">ยังไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { useRouter,useRoute } from 'vue-router';
const router = useRouter()
const id_eva = useRoute().params.id_eva
const totalScore = ref(0)
const token = localStorage.getItem('token')
const user = ref({})
const topics = ref([])
const add = (id_eva:number) => {
    router.push({path:`/Save_score/${id_eva}`})
}
const fetchUser = async () =>{
    try{
        const res = await axios.get(`http://localhost:3001/api/Commit/detail_eva/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลผู้รับประเมินไม่สำเร็จ',err)
    }
}
const fetchTopic = async () =>{
    try{
        const res = await axios.get(`http://localhost:3001/api/Commit/detail_eva/indicate/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
        res.data.forEach(score =>
            score.indicates.forEach((i) =>{
                totalScore.value += (i.score_member)*(i.point_indicate)
            })
        )
        // console.log("topic:",topics.value)
    }catch(err){
        console.error('โหลดข้อมูลตัวชี้วัดไม่สำเร็จ',err)
    }
}
onMounted(async () =>{
    await Promise.all([fetchTopic(),fetchUser()])
})

</script>

<style scoped>

</style>