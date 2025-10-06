import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-product-detail',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './product-detail.component.html',
  styleUrls: ['./product-detail.component.scss']
})
export class ProductDetailComponent implements OnInit {
  product: any = null;
  constructor(private route: ActivatedRoute) {}
  async ngOnInit() {
    const slug = this.route.snapshot.paramMap.get('slug');
    const res = await fetch(`/api/products/slug/${slug}`);
    if (res.ok) this.product = await res.json();
  }
}
