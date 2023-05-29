import { Router } from "express"
import cidadesRouter from "./cidades.routes.js"
import hoteisRouter from "./hoteis.routes.js"

const router = Router()
router.use(cidadesRouter)
router.use(hoteisRouter)

export default router