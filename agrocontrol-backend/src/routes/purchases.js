const express = require('express');
const router = express.Router();
const Purchase = require('../models/purchase');

// Registrar compra
router.post('/', async (req, res) => {
  try {
    const purchase = new Purchase(req.body);
    await purchase.save();
    res.status(201).json(purchase);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Listar compras
router.get('/', async (req, res) => {
  const purchases = await Purchase.find();
  res.json(purchases);
});

module.exports = router;
