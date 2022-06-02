#! /usr/bin/bash

mkdir $1
cd $1

npm init -y
sed -i "2i \"type\": \"module\"," package.json
npm install express mongoose cors
touch index.js
cat >> index.js <<EOF
import express from "express"
import mongoose from "mongoose"
import cors from "cors"

const PORT = 5000
const app = express()
app.use(cors())
app.use(express.json())

app.get('/', (res, req) => {
    res.send("Hello")
})

app.listen(PORT, () => {
    console.log(\`Server listening on ${PORT}\`)
})
EOF

npx create-react-app client