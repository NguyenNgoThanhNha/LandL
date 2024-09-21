import './App.css'
import 'mapbox-gl/dist/mapbox-gl.css'
import { Toaster } from 'react-hot-toast'
import Auth0ProviderWithNavigate from '@/auth/Auth0ProviderWithNavigate.tsx'
import { AuthProvider } from '@/context/authContext.tsx'
import { DeliveryProvider } from '@/context/deliveryContext.tsx'
import AppRoutes from '@/router.tsx'
import { BrowserRouter as Router } from 'react-router-dom'

function App() {
  return (
    <Router>
      <Auth0ProviderWithNavigate>
        <AuthProvider>
          <DeliveryProvider>
            <AppRoutes />
            <Toaster
              position={'top-right'}
              reverseOrder={false}
              toastOptions={{ duration: 5000 }}
              containerClassName={'text-sm'}
            />
          </DeliveryProvider>
        </AuthProvider>
      </Auth0ProviderWithNavigate>
    </Router>
  )
}

export default App
