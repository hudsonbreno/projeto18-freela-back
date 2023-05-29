import { Router } from "express";
import { getListCidades, getCidades, getCidadeEspecifica, getTodas } from "../controllers/cidades.controller.js";

const cidadesRouter = Router()

cidadesRouter.get("/", getListCidades)
cidadesRouter.get("/cidades", getCidades)
cidadesRouter.get("/cidades/especificar", getCidadeEspecifica)
cidadesRouter.get("/cidades/todas", getTodas)

export default cidadesRouter