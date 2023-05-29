import express from "express"
import cors from "cors"
import router from "./routes/index.routes.js"
import dotenv from "dotenv"

const app = express()
dotenv.config()

app.use(express.json())
app.use(cors())
app.use(router)

app.listen(process.env.PORT, console.log(`Servidor na porta ${process.env.PORT}`))