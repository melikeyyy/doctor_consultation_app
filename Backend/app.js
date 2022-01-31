const { json } = require('express');
const express = require('express');
const mysql = require('mysql');
const app = express();
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({'extended': true}))
 
app.get('/', (req,res) => {
    res.end("Node server running...\nYou can get the following tables by typing them in front of the url: \nDoktor \nUzmanlik \nanabilimdali \nHasta \n")
});


app.get('/:kategori', (req,res) => {
    console.log("Fetching user with id:" + req.params.kategori)


    const connection = getConnection()
    const param = req.params.kategori
    const query = "Select * from " + param

    connection.query(query, (err, rows, fields) => {
        console.log(err) 
        console.log("I think we fetched users succesfully")
        res.json(rows)
    })

    //res.end()
});
app.post('/doktor', (req,res) => {
    console.log("got doktor post request")
    console.log(req.body)

    const connection = getConnection()
    console.log(req.headers)
    const ad = req.body.Doktor_adi
    const soyad = req.body.Doktor_soyadi
    const sifre = req.body.Doktor_sifresi
    const anabilim = req.body.anabilim_dali

    const query = "insert into Doktor (Doktor_adi, Doktor_soyadi, Doktor_sifresi, anabilim_dali) values( ?, ?, ?, ? )"

    connection.query(query, [ad,soyad,sifre,anabilim],(err, rows, fields) => {
        console.log(err) 
        console.log("I think we inserted a doctor")
        res.json(rows)
    })
})

app.post('/uzmanlik', (req,res) => {
    console.log("got uzmanlik post request")
    console.log(req.body)

    const connection = getConnection()
    console.log(req.headers)
    const ad = req.body.Uzmanlik_adi


    const query = "insert into Uzmanlik (Uzmanlik_adi) values( ? )"

    connection.query(query, [ad],(err, rows, fields) => {
        console.log(err) 
        console.log("I think we inserted a anabilimdali")
        res.json(rows)
    })
})

app.post('/anabilim', (req,res) => {
    console.log("got anabilim post request")
    console.log(req.body)

    const connection = getConnection()
    console.log(req.headers)
    const ad = req.body.Anabilim_adi

    const query = "insert into Anabilimdali (Anabilim_adi) values( ? )"

    connection.query(query, [ad],(err, rows, fields) => {
        console.log(err) 
        console.log("I think we inserted a anabilim")
        res.json(rows)
    })
})


app.post('/hasta', (req,res) => {
    console.log("got hasta post request")
    console.log(req.body)

    const connection = getConnection()
    console.log(req.headers)
    const ad = req.body.Hasta_adi
    const soyad = req.body.Hasta_soyadadi
    const sifre = req.body.Hasta_sifresi

    const query = "insert into Hasta (Hasta_adi, Hasta_soyadi, Hasta_sifresi) values( ?, ?, ? )"

    connection.query(query, [ad,soyad,sifre],(err, rows, fields) => {
        console.log(err) 
        console.log("I think we inserted a hasta")
        res.json(rows)
    })
})


function getConnection(){
    return connection = mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'Asdfg1234..',
        database: 'hastanesistemi'
    })
}