const mongoose = require('mongoose');

const investmentSchema = new mongoose.Schema({
  concepto: { type: String, required: true },
  monto: { type: Number, required: true },
  fecha: { type: Date, required: true }
});

module.exports = mongoose.model('Investment', investmentSchema);
