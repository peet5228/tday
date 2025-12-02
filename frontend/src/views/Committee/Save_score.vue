<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <v-form v-if="user.status_commit === 'n'" @submit.prevent="saveScore">
                    <h1 class="font-weight-bold text-h5">แบบประเมินตนเอง</h1>
                    <v-card class="mt-2 pa-2">
                        <p>ชื่อ : {{ user.first_name }} {{ user.last_name }}</p>
                        <p>รอบประเมินที่ : {{ user.round_sys }} ปี {{ user.year_sys }}</p>
                    </v-card>
                    <v-row v-for="(topic,index1) in topics" :key="topic.id_topic" class="mt-4">
                        <v-col cols="12">
                            <h class="text-h6 font-weight-bold">{{ index1+1 }}.{{ topic.name_topic }}</h>
                            <v-card class="pa-2">
                                <v-row v-for="(indicate,index2) in topic.indicates" :key="indicate.id_indicate">
                                    <v-col cols="12">
                                        <p>
                                            {{ index1+1 }}.{{ index2+2 }} {{ indicate.name_indicate }} น้ำหนักคะแนน {{ indicate.point_indicate }} คะแนนเต็ม {{ indicate.point_indicate*4 }} รายละเอียดตัวชี้วัด {{ indicate.detail_indicate }}
                                        </p>
                                        <p v-if="indicate.detail_eva">คำอธิบายเพิ่มเติม : {{ indicate.detail_eva }}</p>
                                        <p v-else>คำอธิบายเพิ่มเติม : <strong class="text-red">ไม่มี</strong></p>
                                        <p v-if="indicate.file_eva">ไฟล์ที่แนบ : <v-btn color="blue" @click="openFile(indicate.file_eva)" size="small">ดูไฟล์</v-btn></p>
                                        <p v-else>ไฟล์ที่แนบ : <strong class="text-red">ไม่มี</strong></p>
                                        <v-select class="mt-4" label="ใส่คะแนนประเมิน 1-4" v-model="indicate.score" :items="[1,2,3,4]"></v-select>
                                    </v-col>
                                </v-row>
                            </v-card>
                        </v-col>
                    </v-row>
                    <div class="mt-4">
                        <label for="" class="font-weight-bold">ข้อเสนอแนะ(ถ้ามี)</label>
                        <v-textarea v-model="detail_commit" rows="2"></v-textarea>
                    </div>
                    <div class="text-center mt-4">
                        <v-btn type="submit" color="blue">บันทึกคะแนน</v-btn><br><br>
                    </div>
                </v-form>
                <v-alert v-else-if="user.status_commit === 'y'" type="success">กรอกแบบประเมินแล้ว</v-alert>
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
const token = localStorage.getItem('token')
const user = ref({})
const topics = ref([])
const detail_commit = ref('')
const openFile = (filename:string) =>{
    const url = `http://localhost:3001/uploads/evadetail/${filename}`
    window.open(url,'_blank')
}
const fetchUser = async () =>{
    try{
        const res = await axios.get(`http://localhost:3001/api/Commit/save_score/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        user.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลผู้รับประเมินไม่สำเร็จ',err)
    }
}
const fetchTopic = async () =>{
    try{
        const res = await axios.get(`http://localhost:3001/api/Commit/save_score/indicate/${id_eva}`,{headers:{Authorization:`Bearer ${token}`}})
        topics.value = res.data
    }catch(err){
        console.error('โหลดข้อมูลตัวชี้วัดไม่สำเร็จ',err)
    }
}
onMounted(async () =>{
    await Promise.all([fetchTopic(),fetchUser()])
})
const saveScore = async () =>{
    const formData = new FormData()
    const allScore = topics.value.flatMap(topic =>
        topic.indicates.map((i:any) =>{
            const key = `${topic.id_topic}-${i.id_indicate}`
            return{
                id_topic:topic.id_topic,
                id_indicate:i.id_indicate,
                score:i.score,
            }
        })
    )
    if(allScore.some((s) => !s.score)){
        alert('กรุณากรอกคะแนนให้ครบ')
        return
    }
    formData.append('scores',JSON.stringify(allScore))
    formData.append('detail_commit',detail_commit.value)
    try{
        await axios.post(`http://localhost:3001/api/Commit/save_score/${id_eva}`,formData,{headers:{Authorization:`Bearer ${token}`}})
        alert('บันทึกคะแนนสำเร็จ')
        await Promise.all([fetchTopic(),fetchUser()])
        router.push({path:'/Show_eva'})
    }catch(err){
        console.error('บันทึกคะแนนไม่สำเร็จ',err)
    }
}
</script>

<style scoped>

</style>