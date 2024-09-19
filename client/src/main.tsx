import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import './index.css'
import { BrowserRouter as Router } from 'react-router-dom'
import { AuthProvider } from './context/authContext.tsx'
import Auth0ProviderWithNavigate from './auth/Auth0ProviderWithNavigate.tsx'
import AppRoutes from './router.tsx'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <Router>
    <AuthProvider>
      <Auth0ProviderWithNavigate>
        <AppRoutes />
        <App />
      </Auth0ProviderWithNavigate>
    </AuthProvider>
  </Router>
)
