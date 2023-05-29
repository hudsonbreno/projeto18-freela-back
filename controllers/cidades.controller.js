import { db } from "../database/database.connection.js"

export async function getListCidades(req, res){
    try{
        let list = ["Todas"]
        const add = await db.query(`SELECT * FROM cidades`)
        add.rows.map(item => {
            list = [...list, item.cidadeNome]
        })
        
        res.send(list).status(200)
    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function getCidades(req, res){
    try{
        const add = await db.query(`SELECT * FROM cidades`)
        add.rows.map(item => {
            console.log(item.cidadeNome)
        })
        
        res.send(add.rows).status(200)
    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function getCidadeEspecifica(req, res){
    try{
        const { cidadeNome, min, max } = req.query
        const dados = await db.query(`
        SELECT v."horarioPartida", v."horarioPrevista", v.preco, c1."cidadeNome" AS "cidadeOrigem", c2."cidadeNome" AS "cidadeDestino", v."companhiaId"
        FROM viagem v
        JOIN cidades c1 ON v."cidadeOrigemId" = c1."cidadeId"
        JOIN cidades c2 ON v."cidadeDestinoId" = c2."cidadeId"
        WHERE c2."cidadeNome" = '${cidadeNome}' AND v.preco>=${min} AND v.preco<=${max};
        `)

        res.status(200).send(dados.rows)
    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function getTodas(req, res){
    try{
        const { min, max } = req.query
        const dados = await db.query(`
        SELECT v."horarioPartida", v."horarioPrevista", v.preco, c1."cidadeNome" AS "cidadeOrigem", c2."cidadeNome" AS "cidadeDestino", v."companhiaId"
        FROM viagem v
        JOIN cidades c1 ON v."cidadeOrigemId" = c1."cidadeId"
        JOIN cidades c2 ON v."cidadeDestinoId" = c2."cidadeId"
        WHERE v.preco>=${min} AND v.preco<=${max};
        `)

        res.status(200).send(dados.rows)

    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function getPassagem(req, res){

    try{
        // const { id } = req.params
        // const inform = await db.query(`SELECT * FROM urls WHERE id=$1`,[id])
        // if(inform.rowCount == 0) return res.sendStatus(404)

        // res.status(201).send({
        //     "id":inform.rows[0].id,
        //     "shortUrl":inform.rows[0].shortUrl,
        //     "url":inform.rows[0].url
        // })
        res.sendStatus(301)
    }
    catch(err){
        res.send(500).status(err.message)
    }
}
