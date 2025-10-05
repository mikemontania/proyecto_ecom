import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, RouterModule, FormsModule],
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss'],
})
export class ProductsComponent implements OnInit {
  products: any[] = [];
  categorySlug: string | null = null;
  search = '';
  constructor(private route: ActivatedRoute) {}
  async ngOnInit() {
    this.categorySlug = this.route.snapshot.paramMap.get('slug');
    const qp = new URLSearchParams(location.search);
    this.search = qp.get('search') || '';
    const url = this.categorySlug ? `/api/products?category_slug=${this.categorySlug}&search=${encodeURIComponent(this.search)}` : `/api/products?search=${encodeURIComponent(this.search)}`;
    const res = await fetch(url);
    if (res.ok) this.products = await res.json();
  }
}
