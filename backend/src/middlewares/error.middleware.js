function notFound(_req, res, _next) {
  res.status(404).json({ message: 'No Encontrado' });
}

// eslint-disable-next-line no-unused-vars
function errorHandler(err, _req, res, _next) {
  const status = err.status || 500;
  const message = err?.original?.detail || err.message || 'Error Interno del Servidor';
  res.status(status).json({ message });
}

module.exports = { notFound, errorHandler };
