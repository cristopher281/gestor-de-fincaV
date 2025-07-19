const mongoose = require('mongoose');

const payrollSchema = new mongoose.Schema({
  semana_inicio: { type: Date, required: true },
  semana_fin: { type: Date, required: true },
  trabajador_id: { type: mongoose.Schema.Types.ObjectId, ref: 'Worker', required: true },
  registros_pago: [
    {
      fecha: Date,
      actividad: String,
      produccion: Number,
      pago: Number,
      estado_pago: { type: String, enum: ['Pagado', 'Pendiente'], default: 'Pendiente' }
    }
  ]
});

module.exports = mongoose.model('Payroll', payrollSchema);
