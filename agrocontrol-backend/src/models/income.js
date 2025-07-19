const mongoose = require('mongoose');

const incomeSchema = new mongoose.Schema({
  concepto: { type: String, required: true },
  cantidad: { type: Number, required: true },
  monto: { type: Number, required: true },
  fecha: { type: Date, required: true },
  documento_url: { type: String }
});

module.exports = mongoose.model('Income', incomeSchema);
