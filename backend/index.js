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
app.use(('/uploads',express.static(path.join('uploads'))))

const auth = require('./routes/auth')
app.use('/api/auth',auth)

const profile = require('./routes/profile')
app.use('/api/profile',profile)


//eva
const me = require('./routes/Eva/me')
app.use('/api/Eva/me',me)

const selfeva = require('./routes/Eva/selfeva')
app.use('/api/Eva/selfeva',selfeva)

// Staff
const member = require('./routes/Staff/member')
app.use('/api/Staff/member',member)

const topic = require('./routes/Staff/topic')
app.use('/api/Staff/topic',topic)



// 404
app.use((req,res) => res.status(404).json({message:'ปิดปรับปรุง'}))

app.use( (req,res) => res.status(404).json({message:'pppp'}))
app.listen(3001 , () => console.log('Server Running On Port 3001'))