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

app.get('/', (req, res) => {
    res.send("Hello")
})

app.listen(PORT, () => {
    console.log(\`Server listening on \${PORT}\`)
})
EOF

npx create-react-app client
cd client
npm install react-router-dom node-sass bootstrap @fortawesome/fontawesome-free
cd src
mkdir scss
cd scss
mkdir vendors
mkdir base
mkdir abstracts
mkdir layout
mkdir components
mkdir pages
mkdir themes
cd vendors
touch _bootstrap.scss
touch _fontawesome.scss
cat >> _bootstrap.scss <<EOF
@import "../../../node_modules/bootstrap/scss/bootstrap";
EOF
cat >> _fontawesome.scss <<EOF
@import "../../../node_modules/@fortawesome/fontawesome-free/scss/fontawesome";
@import "../../../node_modules/@fortawesome/fontawesome-free/scss/regular";
@import "../../../node_modules/@fortawesome/fontawesome-free/scss/solid";
@import "../../../node_modules/@fortawesome/fontawesome-free/scss/brands";
EOF
cd ..
cd base
touch _reset.scss
touch _typography.scss
cd ..
cd abstracts
touch _variables.scss
touch _mixins.scss
cd ..
cd layout
touch _navigation.scss
touch _grid.scss
touch _header.scss
touch _footer.scss
cd ..
cd components
touch _buttons.scss
cd ..
touch main.scss
cat >> main.scss <<EOF
@import "base/reset";
@import "base/typography";
@import "abstracts/variables";
@import "abstracts/mixins";
@import "layout/navigation";
@import "layout/grid";
@import "layout/header";
@import "layout/footer";
@import "components/buttons";
@import "vendors/bootstrap";
@import "vendors/fontawesome";
EOF
cd ..
sed -i "3s#import './index.css';#import './scss/main.scss';#g" index.js
sed -i "6i import { BrowserRouter, Routes, Route } from 'react-router-dom'" index.js
sed -i '10,12d' index.js
sed -i "10i \\\t<BrowserRouter>\\n\\t\t<Routes>\\n\\t\t\t<Route path='/' element={<App />} />\\n\t\t</Routes>\\n\t</BrowserRouter>" index.js
sed -i '1,2d' App.js
sed -i '4,19d' App.js
sed -i '4i \\t\t<div><h1>Hello World!</h1></div>' App.js
rm App.css
rm index.css
rm logo.svg

cd ..
git add .
git commit -m "initial commit"
