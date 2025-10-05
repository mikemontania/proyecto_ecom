import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-products',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss'],
})
export class ProductsComponent implements OnInit {
  products: any[] = [];
  categorySlug: string | null = null;
  constructor(private route: ActivatedRoute) {}
  async ngOnInit() {
    this.categorySlug = this.route.snapshot.paramMap.get('slug');
    const url = this.categorySlug ? `/api/products?category_slug=${this.categorySlug}` : '/api/products';
    const res = await fetch(url);
    if (res.ok) this.products = await res.json();
  }
}
