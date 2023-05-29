import { Router } from "express";
import { getHoteis, postHotel } from "../controllers/hoteis.controller.js";

const hoteisRouter = Router()

hoteisRouter.get("/hoteis/especificarCidade", getHoteis)
hoteisRouter.post("/hoteis",postHotel)


export default hoteisRouter