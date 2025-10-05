import { Routes } from '@angular/router';
import { AppComponent } from './app.component';

export const routes: Routes = [
  { path: '', component: AppComponent },
  {
    path: 'cms/:slug',
    loadComponent: () => import('./pages/cms/page/page.component').then(m => m.CmsPageComponent)
  },
];
