<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_eva === 2 || user.status_eva === 3">
                    <h1 class="font-weight-bold text-h5">คะแนนประเมินตนเอง</h1>
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
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนประธาน</th>
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนกรรมการ</th>
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนเลขา</th>
                                        <th class="font-weight-bold text-center border w-1/10">คะแนนที่ได้</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="indicate in topic.indicates" :key="indicate.id_indicate">
                                        <td class="text-center border">{{ indicate.name_indicate }}</td>
                                        <td class="text-center border">{{ indicate.detail_indicate }}</td>
                                        <td class="text-center border">{{ indicate.point_indicate }}</td>
                                        <td class="text-center border">{{ indicate.point_indicate*4 }}</td>
                                        <td class="text-center border">{{ scores[indicate.id_indicate]?.a ?? 'รอประธานประเมิน' }}</td>
                                        <td class="text-center border">{{ scores[indicate.id_indicate]?.b ?? 'รอกรรมการประเมิน' }}</td>
                                        <td class="text-center border">{{ scores[indicate.id_indicate]?.c ?? 'รอเลขาประเมิน' }}</td>
                                        <td class="text-center border">
                                            {{ ((scores[indicate.id_indicate]?.a ?? 0)+(scores[indicate.id_indicate]?.b ?? 0)+(scores[indicate.id_indicate]?.c ?? 0)) }}
                                        </td>
                                    </tr>
                                </tbody>
                            </v-table>
                        </v-col>
                    </v-row>
                    <div class="text-center mt-4">
                        <v-alert type="success" class="pa-2 text-end">คะแนนรวมสุทธิ : {{ totalScore.toFixed(2) || 0 }} คะแนน</v-alert>
                    </div>
                    <div class="mt-4">
                        <v-card class="pa-4">
                            <label for="" class="font-weight-bold font-size">ข้อแสนอแนะของกรรมการ</label>
                            <v-row v-for="commit in commits" :key="commit.id_commit">
                                <v-col cols="12"><p>ประธาน : <span v-if="commit.level_commit ==='ประธาน'">{{ commit.detail_commit }}</span></p></v-col>
                                <v-col cols="12"><p>กรรมการ : <span v-if="commit.level_commit ==='กรรมการ'">{{ commit.detail_commit }}</span></p></v-col>
                                <v-col cols="12"><p>เลขา : <span v-if="commit.level_commit ==='เลขา'">{{ commit.detail_commit }}</span></p></v-col>
                            </v-row>
                        </v-card>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_eva === 1" type="info">คุณยังไม่ได้กรอกแบบประเมิน</v-alert>
                <v-alert v-else type="warning">คุณยังไม่มีแบบประเมิน</v-alert>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { onMounted, ref } from 'vue';
const totalScore = ref(0)
const token = localStorage.getItem('token')
const user = ref({})
const topics = ref([])
const scores = ref([])
const commits = ref([])
const fetchDetail = async () =>{
    try{
        const res = await axios.get('http://localhost:3001/api/Eva/score_commit/detail',{headers:{Authorization:`Bearer ${token}`}})
        commits.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลผู้รับประเมินไม่สำเร็จ',err)
    }
}
const fetchUser = async () =>{
    try{
        const res = await axios.get('http://localhost:3001/api/Eva/score_commit',{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลผู้รับประเมินไม่สำเร็จ',err)
    }
}
const fetchTopic = async () =>{
    try{
        const res = await axios.get('http://localhost:3001/api/Eva/score_commit/indicate',{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลตัวชี้วัดไม่สำเร็จ',err)
    }
}

const fetchScore = async () =>{
    try{
        const res = await axios.get('http://localhost:3001/api/Eva/score_commit/score',{headers:{Authorization:`Bearer ${token}`}})
        scores.value = res.data.scores
        totalScore.value = res.data.totalScore
    }catch(err){
        console.error('โหลดข้อมูลตัวชี้วัดไม่สำเร็จ',err)
    }
}
onMounted(async () =>{
    await Promise.all([fetchTopic(),fetchUser(),fetchDetail(),fetchScore()])
})

</script>

<style scoped>
.font-size{
    font-size: 18px;
}
</style>