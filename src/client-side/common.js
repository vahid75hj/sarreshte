// DEMO ONLY: no backend. All data lives in this browser's localStorage (seeded from seed.js).
const _t = new URLSearchParams(location.search).get('theme'); if (_t) document.documentElement.dataset.theme = _t; // optional ?theme=dark|light
const _q = new URLSearchParams(location.search);
if (_q.get('reset') === '1') localStorage.removeItem('noora-demo-db'); // ?reset=1 → fresh seed data
if (!/index\.html$|\/$/.test(location.pathname)) addEventListener('DOMContentLoaded', () => { const a = document.createElement('a'); a.href = 'index.html' + (_t ? '?theme=' + _t : ''); a.className = 'back-hub'; a.textContent = '← بازگشت به صفحه تست'; document.querySelector('main').prepend(a); });
const fa = n => Number(n).toLocaleString('fa-IR');
const toman = n => fa(n) + ' تومان';
const $ = s => document.querySelector(s);
const KEY = 'noora-demo-db';
const db = () => JSON.parse(localStorage.getItem(KEY) || 'null') || (save(seed()), JSON.parse(localStorage.getItem(KEY)));
function save(d) { localStorage.setItem(KEY, JSON.stringify(d)); }
const normMobile = m => String(m || '').replace(/[۰-۹]/g, d => '۰۱۲۳۴۵۶۷۸۹'.indexOf(d)).replace(/\D/g, '').replace(/^98/, '0');
const faDate = iso => new Date(iso).toLocaleString('fa-IR', { month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' });
// Pluggable payment providers: card = manual card-to-card; mock = DEMO gateway; zarinpal = placeholder.
const payments = {
  card: () => ({ status: 'awaiting_confirm' }),
  mock: () => ({ status: 'paid', ref: 'MOCK-' + Date.now() }),
  zarinpal: () => { throw new Error('زرین‌پال در نسخه دمو فعال نیست'); },
};
const routes = [
  [/^\/api\/public\/orders\/(\w+)\/pay$/, (d, [c], b) => { const o = d.orders.find(x => x.code === c); if (!o) throw 'سفارش پیدا نشد';
    if (o.status !== 'pending_payment') throw 'این سفارش قبلاً پرداخت شده'; if (b.method === 'card' && !b.ref) throw 'شماره پیگیری یا ۴ رقم آخر کارت را وارد کنید';
    const r = payments[b.method](o); o.payment = { method: b.method, ref: b.ref || r.ref, receipt: b.receipt, at: new Date().toISOString() };
    o.status = r.status; o.history.push({ status: r.status, at: o.payment.at }); return o; }],
  [/^\/api\/public\/orders\/(\w+)\/delivered$/, (d, [c]) => { const o = d.orders.find(x => x.code === c); if (!o) throw 'سفارش پیدا نشد';
    if (o.status !== 'shipped') throw 'این سفارش هنوز ارسال نشده'; o.status = 'delivered'; o.history.push({ status: 'delivered', at: new Date().toISOString() }); return o; }],
  [/^\/api\/public\/orders\/(\w+)\/review$/, (d, [c], b) => { const o = d.orders.find(x => x.code === c); if (!o) throw 'سفارش پیدا نشد';
    const r = +b.rating; if (!(r >= 1 && r <= 5)) throw 'لطفاً امتیاز بدهید'; o.review = { rating: r, comment: b.comment || '', private: r <= 3, at: new Date().toISOString() };
    const sl = d.sellers.find(x => x.slug === o.seller); return { ...o, shopInstagram: sl && sl.instagram }; }],
  [/^\/api\/public\/orders\/(\w+)$/, (d, [c]) => { const o = d.orders.find(x => x.code === c); if (!o) throw 'سفارش پیدا نشد'; return o; }],
  [/^\/api\/public\/(\w+)\/lookup\?mobile=(.*)$/, (d, [s, m]) => { const c = d.customers.find(x => x.seller === s && x.mobile === normMobile(m)); if (!c) return { found: false };
    const last = d.orders.filter(o => o.customerId === c.id).sort((a, b) => b.createdAt.localeCompare(a.createdAt))[0];
    return { found: true, name: c.name, address: c.address, instagram: c.instagram || '', lastItems: last ? last.items : [] }; }],
  [/^\/api\/public\/(\w+)\/orders$/, (d, [s], b) => { const mobile = normMobile(b.mobile);
    if (!b.name || !b.address || !/^09\d{9}$/.test(mobile)) throw 'نام، موبایل معتبر و آدرس لازم است';
    const items = b.items.filter(i => i.qty > 0).map(i => { const p = d.products.find(x => x.id === +i.productId); return { productId: p.id, name: p.name, price: p.price, qty: +i.qty }; });
    if (!items.length) throw 'حداقل یک محصول انتخاب کنید';
    const ig = String(b.instagram || '').trim().replace(/^@+/, '').replace(/[^\w.]/g, '');
    let c = d.customers.find(x => x.seller === s && x.mobile === mobile);
    if (!c) { c = { id: d.nextId.customer++, seller: s, name: b.name, mobile, address: b.address, instagram: ig }; d.customers.push(c); } else Object.assign(c, { name: b.name, address: b.address, instagram: ig });
    const at = new Date().toISOString(); const o = { id: d.nextId.order++, seller: s, code: 'NR' + Math.floor(100000 + Math.random() * 900000), customerId: c.id, name: b.name, mobile, address: b.address, instagram: ig, note: b.note,
      items, total: items.reduce((a, x) => a + x.price * x.qty, 0), status: 'pending_payment', payment: null, postalCode: '', createdAt: at, history: [{ status: 'pending_payment', at }] };
    d.orders.push(o); return o; }],
  [/^\/api\/public\/(\w+)$/, (d, [s]) => { const sl = d.sellers.find(x => x.slug === s); if (!sl) throw 'فروشگاه پیدا نشد'; return { ...sl, pin: undefined, products: d.products.filter(p => p.seller === s && p.active) }; }],
];
async function api(url, opt = {}) {
  const d = db();
  for (const [re, fn] of routes) { const m = url.match(re); if (m) { try { const r = fn(d, m.slice(1), opt.body || {}); save(d); return JSON.parse(JSON.stringify(r)); } catch (e) { throw new Error(e.message || e); } } }
  throw new Error('not found');
}
