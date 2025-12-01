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

app.listen(3001 , () => console.log('Server Running On Port 3001'))