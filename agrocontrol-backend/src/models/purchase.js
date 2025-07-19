const mongoose = require('mongoose');

const purchaseSchema = new mongoose.Schema({
  producto: { type: String, required: true },
  cantidad: { type: Number, required: true },
  costo_unitario: { type: Number, required: true },
  costo_total: { type: Number, required: true },
  proveedor: { type: String },
  fecha: { type: Date, required: true },
  documento_url: { type: String }
});

module.exports = mongoose.model('Purchase', purchaseSchema);
