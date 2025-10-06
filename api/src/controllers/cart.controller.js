const { ShoppingCart, CartItem, InternalProduct, Discount } = require('../models');
const { Op } = require('sequelize');

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
  await recalcCart(cart.id);
  res.status(201).json({ cart_uuid: cart.session_uuid, item });
}

async function updateItem(req, res) {
  const cart = await ensureCart(req);
  const { item_id, quantity } = req.body;
  const item = await CartItem.findOne({ where: { id: item_id, shopping_cart_id: cart.id } });
  if (!item) return res.status(404).json({ message: 'Item no encontrado' });
  await item.update({ quantity });
  await recalcCart(cart.id);
  res.json(item);
}

async function removeItem(req, res) {
  const cart = await ensureCart(req);
  const { item_id } = req.body;
  const item = await CartItem.findOne({ where: { id: item_id, shopping_cart_id: cart.id } });
  if (!item) return res.status(404).json({ message: 'Item no encontrado' });
  await item.destroy();
  await recalcCart(cart.id);
  res.status(204).send();
}

async function recalcCart(cartId) {
  const items = await CartItem.findAll({ where: { shopping_cart_id: cartId }, include: [{ model: InternalProduct }] });
  const now = new Date();
  const dateStr = now.toISOString().slice(0, 10);

  // Determine discount by amount using sum of eligible lines
  let eligibleSum = 0;
  for (const it of items) {
    const ip = it.InternalProduct;
    // Product promo?
    const pd = await Discount.findOne({
      where: {
        type: 'PRODUCT',
        product_id: ip.id,
        qty_from: { [Op.lte]: it.quantity },
        qty_to: { [Op.gte]: it.quantity },
        start_date: { [Op.lte]: dateStr },
        end_date: { [Op.gte]: dateStr },
      }
    });
    const unit = Number(ip.price);
    const gross = unit * Number(it.quantity);
    if (pd) {
      const discountRate = Number(pd.discount_rate);
      const discountAmount = Math.round(gross * (discountRate / 100));
      const net = gross - discountAmount;
      await it.update({ unit_price: unit, gross_total: gross, discount_active: true, is_discount_import: false, discount_type: 'producto', discount_rate: discountRate, discount_amount: discountAmount, net_total: net });
    } else {
      await it.update({ unit_price: unit, gross_total: gross, discount_active: false, is_discount_import: false, discount_type: 'escala', discount_rate: 0, discount_amount: 0, net_total: gross });
      eligibleSum += gross;
    }
  }

  if (eligibleSum > 0) {
    const ad = await Discount.findOne({ where: { type: 'AMOUNT', qty_from: { [Op.lte]: eligibleSum }, qty_to: { [Op.gte]: eligibleSum } } });
    if (ad) {
      const percent = Number(ad.discount_rate);
      const totalDiscount = Math.round(eligibleSum * (percent / 100));
      // Prorate across eligible lines
      for (const it of items) {
        if (it.discount_active) continue; // skip product promos
        const weight = Number(it.gross_total) / eligibleSum;
        const lineDiscount = Math.round(totalDiscount * weight);
        const net = Number(it.gross_total) - lineDiscount;
        await it.update({ is_discount_import: true, discount_type: 'escala', discount_rate: percent, discount_amount: lineDiscount, net_total: net });
      }
    }
  }
}

module.exports = { getCart, addItem, updateItem, removeItem };
