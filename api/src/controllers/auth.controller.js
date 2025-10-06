const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { Customer } = require('../models');

function sign(customer) {
  const payload = { sub: customer.id, email: customer.email };
  const token = jwt.sign(payload, process.env.JWT_SECRET || 'devsecret', { expiresIn: '7d' });
  return token;
}

async function register(req, res) {
  const { firstName, lastName, email, phone, password } = req.body;
  if (!firstName || !lastName || !email || !password) return res.status(400).json({ message: 'Datos incompletos' });
  const exists = await Customer.unscoped().findOne({ where: { email } });
  if (exists) return res.status(409).json({ message: 'Email ya registrado' });
  const password_hash = await bcrypt.hash(password, 10);
  const customer = await Customer.create({ firstName, lastName, email, phone, password_hash });
  const token = sign(customer);
  res.status(201).json({ token, customer });
}

async function login(req, res) {
  const { email, password } = req.body;
  const customer = await Customer.unscoped().findOne({ where: { email } });
  if (!customer) return res.status(401).json({ message: 'Credenciales inválidas' });
  const ok = await bcrypt.compare(password, customer.password_hash);
  if (!ok) return res.status(401).json({ message: 'Credenciales inválidas' });
  const token = sign(customer);
  res.json({ token, customer });
}

async function me(req, res) {
  // Simple echo - in real setup, decode JWT
  res.json({ ok: true });
}

module.exports = { register, login, me };
