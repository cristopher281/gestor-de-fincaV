const express = require('express');
const router = express.Router();
const Worker = require('../models/worker');

// Crear trabajador
router.post('/', async (req, res) => {
  try {
    const worker = new Worker(req.body);
    await worker.save();
    res.status(201).json(worker);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar trabajadores
router.get('/', async (req, res) => {
  const workers = await Worker.find();
  res.json(workers);
});

// Obtener trabajador por ID
router.get('/:id', async (req, res) => {
  try {
    const worker = await Worker.findById(req.params.id);
    if (!worker) return res.status(404).json({ error: 'No encontrado' });
    res.json(worker);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
