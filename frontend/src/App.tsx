import { BrowserRouter, Routes, Route, Link, useParams, useSearchParams } from 'react-router-dom';
import { Api, type Producto } from './lib/api';
import { useEffect, useState } from 'react';
import './App.css';

function Home() {
  const [search, setSearch] = useState('');
  return (
    <div className="container">
      <h1>Cavallaro</h1>
      <div className="search">
        <input value={search} onChange={e=>setSearch(e.target.value)} placeholder="Buscar productos..." />
        <Link to={`/productos?search=${encodeURIComponent(search)}`} className="btn">Buscar</Link>
      </div>
      <Link to="/productos" className="btn">Ver Productos</Link>
    </div>
  );
}

function Products() {
  const [params] = useSearchParams();
  const [items, setItems] = useState<Producto[]>([]);
  useEffect(()=>{ (async()=>{
    const search = params.get('search') || undefined;
    const category_slug = params.get('categoria') || undefined;
    const data = await Api.listProductos({ search, category_slug });
    setItems(data);
  })() },[params]);
  return (
    <div className="container">
      <h1>Productos</h1>
      <div className="grid">
        {items.map(p=> (
          <Link key={p.id} to={`/producto/${p.slug}`} className="card">{p.nameEs}</Link>
        ))}
      </div>
    </div>
  );
}

function ProductDetail() {
  const { slug } = useParams();
  const [item, setItem] = useState<Producto | null>(null);
  useEffect(()=>{ (async()=>{ if (!slug) return; setItem(await Api.getProductoBySlug(slug)); })() },[slug]);
  if (!item) return <div className="container">Cargando...</div>;
  return (
    <div className="container">
      <h1>{item.nameEs}</h1>
      <p>{item.descriptionEs}</p>
    </div>
  );
}

export default function App() {
  return (
    <BrowserRouter>
      <nav className="container" style={{ display: 'flex', gap: 12 }}>
        <Link to="/">Inicio</Link>
        <Link to="/productos">Productos</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/productos" element={<Products />} />
        <Route path="/producto/:slug" element={<ProductDetail />} />
      </Routes>
    </BrowserRouter>
  );
}
