const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  nombre: { type: String },
  rol: { type: String, default: 'admin' },
  fecha_creacion: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', userSchema);
