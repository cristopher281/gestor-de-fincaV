const mongoose = require('mongoose');

const loanSchema = new mongoose.Schema({
  trabajador_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Worker', required: true },
  monto: { type: Number, required: true },
  fecha: { type: Date, required: true },
  abonos: [
    {
      fecha: Date,
      monto: Number
    }
  ],
  saldo_actual: { type: Number, required: true }
});

module.exports = mongoose.model('Loan', loanSchema);
