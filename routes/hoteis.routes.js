import { Router } from "express";
import { getHoteis, getHospedagem } from "../controllers/hoteis.controller.js";

const hoteisRouter = Router()

hoteisRouter.get("/hoteis", getHoteis)
hoteisRouter.get("/hospedagem/especificar", getHospedagem)


export default hoteisRouter