const express = require('express')
const db = require('../../db')
const router = express.Router()
const {verifyToken} = require('../../middleware/authMiddleware')
const path = require('path')
const uploadDir = path.join(__dirname,'../../uploads/evadetail')

router.get('/',verifyToken,async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [rows] = await db.query(`select * from tb_member m,tb_system s,tb_eva e where e.id_member=? and e.id_member=m.id_member and e.id_sys=s.id_sys order by e.id_eva desc`,
            [id_member]
        )
        res.json(rows[0])
    }catch(err){
        console.error("Error GET User",err)
        res.status(500).json({message:'Error GET User'})
    }
})

router.get('/detail',verifyToken,async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [rows] = await db.query(`select * from tb_member m,tb_system s,tb_eva e,tb_commit c where e.id_member=? and e.id_eva=c.id_eva and e.id_member=m.id_member and e.id_sys=s.id_sys order by e.id_eva desc`,
            [id_member]
        )
        res.json(rows)
    }catch(err){
        console.error("Error GET User",err)
        res.status(500).json({message:'Error GET User'})
    }
})

router.get('/indicate',verifyToken,async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [[evaRow]] = await db.query(`select * from tb_member m,tb_system s,tb_eva e where e.id_member=? and e.id_member=m.id_member and e.id_sys=s.id_sys order by e.id_eva desc`,
            [id_member]
        )
        const id_eva = evaRow.id_eva
        const [topics] = await db.query(`select * from tb_topic`)
        const [indicates] = await db.query(`select * from tb_indicate`)
        const result = topics.map(t => ({
            ...t,
            indicates:indicates.filter((i) => i.id_topic === t.id_topic)
        }))
        res.json(result)
    }catch(err){
        console.error("Error GET Topic and Indicate",err)
        res.status(500).json({message:'Error GET Topic and Indicate'})
    }
})

router.get('/score',verifyToken,async (req,res) => {
    try{
        const id_member = req.user.id_member
        const [[evaRow]] = await db.query(`select * from tb_member m,tb_system s,tb_eva e where e.id_member=? and e.id_member=m.id_member and e.id_sys=s.id_sys order by e.id_eva desc`,
            [id_member]
        )
        const id_eva = evaRow.id_eva
        const [rows] = await db.query(`select * from tb_indicate i,tb_evadetail d where i.id_indicate=d.id_indicate and d.id_eva=? and d.status_eva in (2,3,4)`,
            [id_eva]
        )
        const scores = {}
        var totalScore = 0
        rows.forEach(row =>{
            if(!scores[row.id_indicate]){
                scores[row.id_indicate] = {
                    a:null,
                    b:null,
                    c:null,
                }
            }
            if(row.status_eva === 2) scores[row.id_indicate].a = row.score_commit
            if(row.status_eva === 3) scores[row.id_indicate].b = row.score_commit
            if(row.status_eva === 4) scores[row.id_indicate].c = row.score_commit
            totalScore = (row.score_commit * row.point_indicate)/3
            
        })

        res.json({scores,totalScore})
    }catch(err){
        console.error("Error GET Topic and Indicate",err)
        res.status(500).json({message:'Error GET Topic and Indicate'})
    }
})

module.exports = router