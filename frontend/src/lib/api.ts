export type Categoria = { id: number; nameEs: string; slug: string };
export type Producto = { id: number; slug: string; nameEs: string; descriptionEs?: string };

async function j<T>(res: Response): Promise<T> { if (!res.ok) throw new Error(`HTTP ${res.status}`); return res.json() }

export const Api = {
  async listCategorias(): Promise<Categoria[]> { return fetch('/api/categories').then(j) },
  async listProductos(params?: { category_slug?: string; search?: string }): Promise<Producto[]> {
    const url = new URL('/api/products', window.location.origin);
    if (params) Object.entries(params).forEach(([k,v]) => { if (v!==undefined&&v!==null&&v!=='') url.searchParams.set(k, String(v)) });
    return fetch(url.toString()).then(j)
  },
  async getProductoBySlug(slug: string): Promise<Producto> { return fetch(`/api/products/slug/${slug}`).then(j) },
};
