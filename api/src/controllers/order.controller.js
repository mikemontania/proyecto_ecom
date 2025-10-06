const { sequelize } = require('../../dbconfig');
const { Order, OrderItem, InternalProduct, CartItem, ShoppingCart } = require('../models');

async function create(req, res) {
  const { customer_id, customer_name, customer_email, customer_phone, shipping_address, items, cart_uuid } = req.body;
  if (!customer_name || !customer_email || !customer_phone || !shipping_address) {
    return res.status(400).json({ message: 'Datos de pedido incompletos' });
  }

  const tx = await sequelize.transaction();
  try {
    let subtotal = 0;
    const persistedItems = [];
    if (Array.isArray(items) && items.length > 0) {
      for (const line of items) {
        const ip = await InternalProduct.findByPk(line.internal_product_id, { transaction: tx });
        if (!ip) throw new Error(`Producto interno ${line.internal_product_id} inexistente`);
        const quantity = Math.max(1, Number(line.quantity || 1));
        const unit_price = Number(ip.price);
        const line_total = unit_price * quantity;
        subtotal += line_total;
        persistedItems.push({ internal_product_id: ip.id, quantity, unit_price, line_total });
      }
    } else if (cart_uuid) {
      const cart = await ShoppingCart.findOne({ where: { session_uuid: cart_uuid }, transaction: tx });
      if (!cart) throw new Error('Carrito no encontrado');
      const cartItems = await CartItem.findAll({ where: { shopping_cart_id: cart.id }, transaction: tx });
      for (const ci of cartItems) {
        const unit_price = Number(ci.unit_price);
        const line_total = Number(ci.net_total);
        subtotal += line_total;
        persistedItems.push({ internal_product_id: ci.internal_product_id, quantity: ci.quantity, unit_price, line_total });
      }
    } else {
      throw new Error('Debe enviar items o cart_uuid');
    }

    const importe_descuento = 0;
    const porcentaje_descuento = 0;
    const ivaPercent = 10;
    const importe_iva = (subtotal - importe_descuento) * (ivaPercent / 100);
    const total = subtotal - importe_descuento + importe_iva;

    const order = await Order.create({
      customer_id: customer_id ?? null,
      customer_name,
      customer_email,
      customer_phone,
      shipping_address,
      subtotal,
      importe_descuento,
      porcentaje_descuento,
      importe_iva,
      total,
      status: 'NEW',
    }, { transaction: tx });

    for (const it of persistedItems) {
      await OrderItem.create({ ...it, order_id: order.id }, { transaction: tx });
    }

    await tx.commit();
    res.status(201).json(order);
  } catch (err) {
    await tx.rollback();
    res.status(400).json({ message: err.message || 'No se pudo crear el pedido' });
  }
}

async function listMy(req, res) {
  const { customerId } = req.params;
  const items = await Order.findAll({ where: { customer_id: customerId }, order: [['created_at', 'DESC']] });
  res.json(items);
}

async function repeat(_req, res) {
  res.json({ ok: true });
}

module.exports = { create, listMy, repeat };
