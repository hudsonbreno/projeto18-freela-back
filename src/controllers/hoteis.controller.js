import { db } from "../database/database.connection.js"

export async function getHoteis(req, res){
    try{
        const { cidadeNome, min, max } = req.query
        const dados = await db.query(`
        SELECT c."cidadeNome", h."nomeHotel", h."caracteristicas", h."comodidades", h."valor_dia"
        FROM cidades c
        JOIN hoteis h ON c."cidadeId" = h."cidadeId"
        WHERE c."cidadeNome" = '${cidadeNome}' AND h.valor_dia>=${min} AND h.valor_dia<=${max};
        `)

        res.status(200).send(dados.rows)
    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function postHotel(req, res){
    try{
        const { fotoId, cidadeId, nomeHotel, caracteristicas, comodidades, valor_dia} = req.body
        const dados = await db.query(`
        INSERT INTO "hoteis"("fotoId","cidadeId","nomeHotel","caracteristicas","comodidades","valor_dia") VALUES
        (${fotoId},${cidadeId}, ${nomeHotel}, ${caracteristicas},${comodidades}, ${valor_dia});
        `)

        res.send(201).send(dados)
    }
    catch(err){
        console.log(err.message)
    }
}
