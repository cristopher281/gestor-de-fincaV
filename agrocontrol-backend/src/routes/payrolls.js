const express = require('express');
const router = express.Router();
const Payroll = require('../models/payroll');

// Crear planilla
router.post('/', async (req, res) => {
  try {
    const payroll = new Payroll(req.body);
    await payroll.save();
    res.status(201).json(payroll);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar planillas
router.get('/', async (req, res) => {
  const payrolls = await Payroll.find();
  res.json(payrolls);
});

// Obtener planilla por ID
router.get('/:id', async (req, res) => {
  try {
    const payroll = await Payroll.findById(req.params.id);
    if (!payroll) return res.status(404).json({ error: 'No encontrado' });
    res.json(payroll);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

module.exports = router;
