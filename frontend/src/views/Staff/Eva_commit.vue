<template>
    <v-container fluid class="py-10">
                <v-card class="pa-4">
                    <h1 class="text-center text-h5 font-weight-bold text-maroon">ตั้งค่ากรรมการ</h1>
                    <p class="text-gray-500 font-weight-bold">ข้อมูลผู้ถถูกประเมิน</p>
                    <p class="text-gray-500 font-weight-bold">ชื่อ : {{ header.first_name }} {{ header.last_name }}</p>
                    <p class="text-gray-500 font-weight-bold">รอบการประเมิน : รอบที่ {{ header.round_sys }} ปี {{ header.year_sys }}</p>
                    <v-form @submit.prevent="saveMember">
                        <v-row class="mt-4">
                            <template v-for="(c,index) in List" :key="index">
                                <v-col cols="12" md="6">
                                    <v-select v-model="c.id_member" :label="`กรรมการคนที่ ${index+1}`" :items="MEMBER(index).map(c => ({title:c.fullname_commit,value:c.id_member}))"></v-select>
                                </v-col>
                                <v-col cols="12" md="6">
                                    <v-select v-model="c.role" :label="`ตำแหน่งที่ ${index+1}`" :items="ROLE(index)"></v-select>
                                </v-col>
                            </template>
                            <v-col cols="12" md="6" class="text-center"><v-btn class="text-white w-full" color="blue" type="submit">บันทึก</v-btn></v-col>
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
                            <tr v-for="(items,index) in List" :key="items.id_commit">
                                <td class="text-center border">{{ index+1 }}</td>
                                <td class="text-center border">{{ nameOf(items.id_member) }}</td>
                                <td class="text-center border">{{ items.role }}</td>
                                <td class="text-center border">
                                    <!-- <v-btn color="warning" class="text-white" size="small"  @click="edit(items)">แก้ไข</v-btn>&nbsp; -->
                                    <v-btn color="error" class="text-white" size="small"  @click="del(items.id_commit)">ลบ</v-btn>
                                </td>
                            </tr>
                        </tbody>
                    </v-table>
                </v-card>
    </v-container>
</template>

<script setup lang="ts">
import axios from 'axios';
import { ref,onMounted,computed } from 'vue';
import { useRoute } from 'vue-router';

const id_eva = useRoute().params.id_eva
const api = import.meta.env?.VITE_BASE_API || 'http://localhost:3001/api/Staff'
const token = localStorage.getItem('token')

const header = ref([])
const role = ['ประธาน','กรรมการ','เลขา']
const people = ref([])
const List = ref([
    {id_commit:null,id_member:'',role:''},
    {id_commit:null,id_member:'',role:''},
    {id_commit:null,id_member:'',role:''},
])

const fetch = async () => {
    try{
        const h = await axios.get(`${api}/commit/header/${id_eva}`,{headers:{Authorization: `Bearer ${token}`}})
        header.value = h.data[0]
        const res = await axios.get(`${api}/commit/${id_eva}`,{headers:{Authorization: `Bearer ${token}`}})
        people.value = res.data.before 
        const useData = res.data.after
        if(useData.length === 0){
            List.value = [
                {id_commit:null,id_member:'',role:''},
                {id_commit:null,id_member:'',role:''},
                {id_commit:null,id_member:'',role:''},
            ]
        }else{
            List.value = useData.map(c => ({
                id_commit:c.id_commit,id_member:c.id_member,role:c.role
            }))
            while(List.value.length < 3){
                List.value.push({id_commit:null,id_member:'',role:''})
            }
        }
    }catch(err){
        console.error('Error Fetching',err)
    }
}

const nameMap = computed( () => Object.fromEntries(people.value.map(p => [p.id_member,p.fullname_commit])) )
const nameOf = (id:number) => nameMap.value[id]

const MEMBER = (idx:number) => {
    const picked = List.value.map( (c,i) => (i !== idx ? c.id_member : null) )
    return people.value.filter( (p) => !picked.includes(p.id_member))
}

const ROLE = (idx:number) => {
    const picked = List.value.map( (c,i) => (i !== idx ? c.role : null) )
    return role.filter( (p) => !picked.includes(p))
}


const saveMember = async () =>{
    try{
        await axios.post(`${api}/commit/${id_eva}`,List.value,{headers:{Authorization: `Bearer ${token}`}})
        alert('ทำรายการสำเร็จ')
        await fetch()
    }catch(err){
        console.error('ทำรายการไม่สำเร็จ',err)
    }
}

const del = async (id_commit:number) => {
    try{
        if(!confirm('ต้องการลบใช่หรือไม่')) return
        await axios.delete(`${api}/commit/${id_commit}`,{headers:{Authorization: `Bearer ${token}`}})
        await fetch()
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