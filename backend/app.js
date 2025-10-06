require('dotenv').config();
const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const { sequelize } = require('./dbconfig');

const app = express();
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

app.get('/health', (_req, res) => res.json({ ok: true, service: 'backend' }));

// middlewares de error
const { notFound, errorHandler } = require('./src/middlewares/error.middleware');
app.use(notFound);
app.use(errorHandler);

(async () => {
  try {
    await sequelize.authenticate();
    await sequelize.sync();
    const port = process.env.PORT || 4000;
    app.listen(port, () => console.log('backend listening on ' + port));
  } catch (err) {
    console.error('backend failed to start', err);
    process.exit(1);
  }
})();
