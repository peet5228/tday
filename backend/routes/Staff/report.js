const express = require('express')
const db = require('../../db')
const router = express.Router()
const {verifyToken,requireRole} = require('../../middleware/authMiddleware')

// ============== DEMO ==============
// API สำหรับ Get ข้อมูล
router.get('/',verifyToken,requireRole('ฝ่ายบุคลากร'),async (req,res) => {
    try{
        const [n] = await db.query(`select * from tb_eva,tb_member,tb_system where tb_eva.id_member=tb_member.id_member and tb_system.id_sys=tb_eva.id_sys and status_eva!=3 order by id_eva desc`)
        const [y] = await db.query(`select * from tb_eva,tb_member,tb_system where tb_eva.id_member=tb_member.id_member and tb_system.id_sys=tb_eva.id_sys and status_eva=3 order by id_eva desc`)
        res.json({y,n})
    }catch(err){
        console.error('Error Get',err)
        res.status(500).json({message:'Error Get'})
    }
})

module.exports = router