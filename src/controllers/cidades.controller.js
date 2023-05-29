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

export async function postViagem(req, res){
    try{
        const { cidadeDestinoId, cidadeOrigemId, horarioPartida, horarioPrevista, preco, companhiaId} = req.body
        const dados = await db.query(`
        INSERT INTO viagem("cidadeDestinoId","cidadeOrigemId","horarioPartida","horarioPrevista","preco","companhiaId") VALUES
        (${cidadeDestinoId}, ${cidadeOrigemId}, ${horarioPartida}, ${horarioPrevista}, ${preco}, ${companhiaId})
        `)

        res.send(201).send(dados)
    }
    catch(err){
        console.log(err.message)
    }
}