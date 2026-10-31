const day = 86400000;
function seed() {
  const now = Date.now();
  const products = [
    { id: 1, name: 'شمع لیوانی کوچک', price: 180000 },
    { id: 2, name: 'شمع لیوانی بزرگ', price: 420000 },
    { id: 3, name: 'شمع گل‌سنگی', price: 250000 },
    { id: 4, name: 'پک هدیه سه‌تایی', price: 690000 },
  ];
  const customers = [
    ['مریم احمدی', '09121111111', 'تهران، ونک، خ ملاصدرا، پ ۱۲'],
    ['سارا کریمی', '09122222222', 'اصفهان، چهارباغ بالا، کوچه ۸'],
    ['نگار رضایی', '09123333333', 'شیراز، معالی‌آباد، پ ۴'],
    ['الهام موسوی', '09124444444', 'مشهد، سجاد، بلوار جامی'],
    ['زهرا نوری', '09125555555', 'کرج، گوهردشت، فاز ۲'],
  ].map(([name, mobile, address], i) => ({ id: i + 1, name, mobile, address }));
  const spec = [ // [cust, items, status, daysAgo]
    [0, [[2, 1]], 'shipped', 45], [1, [[1, 2]], 'shipped', 40], [2, [[4, 1]], 'shipped', 35],
    [0, [[2, 1]], 'shipped', 10], [3, [[3, 1]], 'paid', 3], [4, [[1, 3]], 'paid', 2],
    [3, [[2, 2]], 'awaiting_confirm', 1], [4, [[3, 1]], 'awaiting_confirm', 1],
    [3, [[1, 1]], 'pending_payment', 0], [4, [[4, 1]], 'pending_payment', 0], [2, [[3, 2]], 'cancelled', 5],
  ];
  const orders = spec.map(([c, items, status, ago], i) => {
    const created = new Date(now - ago * day).toISOString();
    const its = items.map(([pid, qty]) => { const p = products.find(x => x.id === pid); return { productId: pid, name: p.name, price: p.price, qty }; });
    return { id: i + 1, code: 'NR' + (1000 + i), customerId: customers[c].id, name: customers[c].name, mobile: customers[c].mobile,
      address: customers[c].address, note: '', items: its, total: its.reduce((s, x) => s + x.price * x.qty, 0), status,
      payment: (status === 'pending_payment' || status === 'cancelled') ? null : { method: 'card', ref: String(4000 + i * 7), receipt: null, at: created },
      postalCode: status === 'shipped' ? '1234567890' + i : '', createdAt: created,
      history: [{ status: 'pending_payment', at: created }] };
  });
  return {
    sellers: [{ slug: 'noora', name: 'شمع نورا', pin: '1234', card: '6037-9975-1234-5678', cardOwner: 'نورا حسینی' }],
    products: products.map(p => ({ ...p, seller: 'noora', active: true })),
    customers: customers.map(c => ({ ...c, seller: 'noora' })),
    orders: orders.map(o => ({ ...o, seller: 'noora' })),
    tokens: {}, nextId: { product: 5, customer: 6, order: 12 },
  };
};
