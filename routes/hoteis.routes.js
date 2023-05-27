import { Router } from "express";
import { } from "../controllers/urls.controller.js";

const hoteisRouter = Router()

hoteisRouter.post("/hoteis", getHoteis)
hoteisRouter.get("/hospedagem/:id", getHospegagem)


export default urlsRouter