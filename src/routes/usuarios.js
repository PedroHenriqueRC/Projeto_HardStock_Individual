var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/cadastrarFuncionario", function (req, res) {
    usuarioController.cadastrarFuncionario(req, res);
})


router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

router.get("/buscarFuncionario/:fkEmpresa", function (req, res) {
    usuarioController.buscarFuncionario(req, res);
})

router.get("/listarFuncionario/:idFuncionario", function (req, res) {
    usuarioController.listarFuncionario(req, res);
})

router.put("/editar/:idFuncionario", function (req, res) {
    usuarioController.editar(req, res);
});

router.delete("/deletar/:idFuncionario", function (req, res) {
    usuarioController.deletar(req, res);
});

module.exports = router;