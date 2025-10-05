import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-cart',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss'],
})
export class CartComponent implements OnInit {
  cart: any = { items: [] };
  async ngOnInit() {
    const res = await fetch('/api/cart');
    if (res.ok) this.cart = await res.json();
  }
}
