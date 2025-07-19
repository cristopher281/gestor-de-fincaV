const express = require('express');
const router = express.Router();
const Loan = require('../models/loan');

// Registrar préstamo
router.post('/', async (req, res) => {
  try {
    const loan = new Loan(req.body);
    await loan.save();
    res.status(201).json(loan);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Registrar abono
router.post('/:id/abono', async (req, res) => {
  try {
    const loan = await Loan.findById(req.params.id);
    if (!loan) return res.status(404).json({ error: 'No encontrado' });
    loan.abonos.push(req.body);
    loan.saldo_actual -= req.body.monto;
    await loan.save();
    res.json(loan);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar préstamos
router.get('/', async (req, res) => {
  const loans = await Loan.find();
  res.json(loans);
});

module.exports = router;
