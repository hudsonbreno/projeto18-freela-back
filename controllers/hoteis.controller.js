import { db } from "../database/database.connection.js"

export async function getCidades(req, res){
    try{
        const { url } = req.body;

        const shortUrl = nanoid()

        const add = await db.query(`INSERT INTO urls(url,"shortUrl", "userId") VALUES ($1, $2, $3)`, [url, shortUrl, res.locals.session.rows[0].userId])
        if(!add) return res.send(412)

        const informId = await db.query(`SELECT * FROM urls WHERE url=$1`,[url])

        res.status(201).send({
            "id":informId.rows[0].id,
            "shortUrl":shortUrl,
            "userId": res.locals.session.rows[0].userId
        })
    }
    catch(err){
        res.status(500).send(err.message)
    }
}

export async function getPassagem(req, res){
    const { id } = req.params

    try{
        const inform = await db.query(`SELECT * FROM urls WHERE id=$1`,[id])
        if(inform.rowCount == 0) return res.sendStatus(404)

        res.status(201).send({
            "id":inform.rows[0].id,
            "shortUrl":inform.rows[0].shortUrl,
            "url":inform.rows[0].url
        })
    }
    catch(err){
        res.send(500).status(err.message)
    }
}
