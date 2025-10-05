const { ShoppingCart, CartItem, InternalProduct } = require('../models');

async function ensureCart(req) {
  const uuid = req.headers['x-cart-uuid'] || req.query.cart_uuid || req.body?.cart_uuid;
  let cart = null;
  if (uuid) cart = await ShoppingCart.findOne({ where: { session_uuid: uuid } });
  if (!cart) cart = await ShoppingCart.create({});
  return cart;
}

async function getCart(req, res) {
  const cart = await ensureCart(req);
  const items = await CartItem.findAll({ where: { shopping_cart_id: cart.id } });
  res.json({ cart_uuid: cart.session_uuid, items });
}

async function addItem(req, res) {
  const cart = await ensureCart(req);
  const { internal_product_id, quantity = 1 } = req.body;
  const ip = await InternalProduct.findByPk(internal_product_id);
  if (!ip) return res.status(404).json({ message: 'Producto no encontrado' });
  let item = await CartItem.findOne({ where: { shopping_cart_id: cart.id, internal_product_id } });
  if (item) {
    await item.update({ quantity: item.quantity + Number(quantity) });
  } else {
    item = await CartItem.create({ shopping_cart_id: cart.id, internal_product_id, quantity, unit_price: ip.price, gross_total: Number(ip.price) * Number(quantity), net_total: Number(ip.price) * Number(quantity) });
  }
  res.status(201).json({ cart_uuid: cart.session_uuid, item });
}

async function updateItem(req, res) {
  const cart = await ensureCart(req);
  const { item_id, quantity } = req.body;
  const item = await CartItem.findOne({ where: { id: item_id, shopping_cart_id: cart.id } });
  if (!item) return res.status(404).json({ message: 'Item no encontrado' });
  await item.update({ quantity });
  res.json(item);
}

async function removeItem(req, res) {
  const cart = await ensureCart(req);
  const { item_id } = req.body;
  const item = await CartItem.findOne({ where: { id: item_id, shopping_cart_id: cart.id } });
  if (!item) return res.status(404).json({ message: 'Item no encontrado' });
  await item.destroy();
  res.status(204).send();
}

module.exports = { getCart, addItem, updateItem, removeItem };
