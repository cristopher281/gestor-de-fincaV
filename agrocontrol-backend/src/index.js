require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
app.use(cors());
app.use(express.json());

// Conexión a MongoDB
mongoose.connect(process.env.MONGODB_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('MongoDB conectado'))
  .catch(err => console.error('Error de conexión:', err));

// Rutas base (ejemplo)

// Rutas de autenticación y trabajadores

const authRoutes = require('./routes/auth');
const workerRoutes = require('./routes/workers');
const payrollRoutes = require('./routes/payrolls');
const loanRoutes = require('./routes/loans');
const purchaseRoutes = require('./routes/purchases');
const investmentRoutes = require('./routes/investments');
const incomeRoutes = require('./routes/incomes');

app.use('/api/auth', authRoutes);
app.use('/api/trabajadores', workerRoutes);
app.use('/api/planillas', payrollRoutes);
app.use('/api/prestamos', loanRoutes);
app.use('/api/compras', purchaseRoutes);
app.use('/api/inversiones', investmentRoutes);
app.use('/api/ingresos', incomeRoutes);

// Ruta base
app.get('/', (req, res) => {
  res.send('API AgroControl funcionando');
});

// Puerto
const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en puerto ${PORT}`);
});
