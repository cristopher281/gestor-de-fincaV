const express = require('express');
const router = express.Router();
const Income = require('../models/income');

// Registrar ingreso
router.post('/', async (req, res) => {
  try {
    const income = new Income(req.body);
    await income.save();
    res.status(201).json(income);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar ingresos
router.get('/', async (req, res) => {
  const incomes = await Income.find();
  res.json(incomes);
});

module.exports = router;
