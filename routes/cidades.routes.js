import { Router } from "express";
import { getListCidades, getCidades, getCidadeEspecifica, getTodas, getPassagem } from "../controllers/cidades.controller.js";

const cidadesRouter = Router()

cidadesRouter.get("/", getListCidades)
cidadesRouter.get("/cidades", getCidades)
cidadesRouter.get("/cidades/especificar", getCidadeEspecifica)
cidadesRouter.get("/cidades/todas", getTodas)
cidadesRouter.get("/passagem/:id", getPassagem)

export default cidadesRouter