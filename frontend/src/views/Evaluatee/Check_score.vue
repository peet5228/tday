<template>
    <v-container>
        <v-row>
            <v-col cols="12">
                <h1 class="text-h5 font-weight-bold">ตรวจสอบผลการประเมิน</h1>
                <div class="mt-4">
                    <div class="mt-4">
                        <router-link to="/Score_eva"><v-btn color="blue" type="submit">ตรวจสอบผลการประเมินตนเอง</v-btn></router-link>&nbsp;&nbsp;&nbsp;&nbsp;
                        <router-link to=""><v-btn color="blue" type="submit">ตรวจสอบผลการประเมินกรรมการ</v-btn></router-link>
                        <!-- <router-link to="/Score_commit"><v-btn color="blue" type="submit">ตรวจสอบผลการประเมินกรรมการ</v-btn></router-link> -->
                    </div>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup lang="ts">

</script>

<style scoped>

</style>