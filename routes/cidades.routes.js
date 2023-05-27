import { Router } from "express";
import {  } from "../controllers/cidades.controller.js";

const cidadesRouter = Router()

cidadesRouter.get("/cidades", getCidades)
cidadesRouter.get("/passagem/:id", getPassagem)

export default urlsRouter