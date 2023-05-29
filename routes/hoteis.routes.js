import { Router } from "express";
import { getHoteis } from "../controllers/hoteis.controller.js";

const hoteisRouter = Router()

hoteisRouter.get("/hoteis/especificarCidade", getHoteis)


export default hoteisRouter