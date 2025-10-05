import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-cms-page',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './page.component.html',
  styleUrls: ['./page.component.scss'],
})
export class CmsPageComponent implements OnInit {
  html = '';
  title = '';
  constructor(private route: ActivatedRoute) {}
  async ngOnInit() {
    const slug = this.route.snapshot.paramMap.get('slug');
    const res = await fetch(`/api/pages/slug/${slug}`);
    if (res.ok) {
      const page = await res.json();
      this.title = page.title_es || '';
      this.html = page.content_es || '';
    }
  }
}
