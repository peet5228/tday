require('dotenv').config()
const express = require('express')
const fileupload = require('express-fileupload')
const cors = require('cors')
const path = require('path')
const app = express()

app.use(cors ({
    origin:'http://localhost:5173',
    credentials:true
}))

app.use(express.json())
app.use(fileupload())
app.use('/uploads',express.static(path.join('uploads')))

const auth = require('./routes/auth')
app.use('/api/auth',auth)

const profile = require('./routes/profile')
app.use('/api/profile',profile)


//Commit
const show_eva = require('./routes/Commit/show_eva')
app.use('/api/Commit/show_eva',show_eva)

const detail_eva = require('./routes/Commit/detail_eva')
app.use('/api/Commit/detail_eva',detail_eva)

const save_score = require('./routes/Commit/save_score')
app.use('/api/Commit/save_score',save_score)

const check_confirm = require('./routes/Commit/check_confirm')
app.use('/api/Commit/check_confirm',check_confirm)

const detail_commit = require('./routes/Commit/detail_commit')
app.use('/api/Commit/detail_commit',detail_commit)

//eva
const me = require('./routes/Eva/me')
app.use('/api/Eva/me',me)

const selfeva = require('./routes/Eva/selfeva')
app.use('/api/Eva/selfeva',selfeva)

const score_eva = require('./routes/Eva/score_eva')
app.use('/api/Eva/score_eva',score_eva)

const score_commit = require('./routes/Eva/score_commit')
app.use('/api/Eva/score_commit',score_commit)

// Staff
const member = require('./routes/Staff/member')
app.use('/api/Staff/member',member)

const topic = require('./routes/Staff/topic')
app.use('/api/Staff/topic',topic)

const indicate = require('./routes/Staff/indicate')
app.use('/api/Staff/indicate',indicate)

const round_eva = require('./routes/Staff/round_eva')
app.use('/api/Staff/round_eva',round_eva)

const eva = require('./routes/Staff/eva')
app.use('/api/Staff/eva',eva)

const commit = require('./routes/Staff/commit')
app.use('/api/Staff/commit',commit)

const status = require('./routes/Staff/status')
app.use('/api/Staff/status',status)

const doc = require('./routes/Staff/doc')
app.use('/api/Staff/doc',doc)



// 404
app.use((req,res) => res.status(404).json({message:'ปิดปรับปรุง'}))

app.use( (req,res) => res.status(404).json({message:'pppp'}))
app.listen(3001 , () => console.log('Server Running On Port 3001'))