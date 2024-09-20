import './App.css'
import 'mapbox-gl/dist/mapbox-gl.css'
import { Toaster } from 'react-hot-toast'
import { DeliveryProvider } from '@/context/deliveryContext.tsx'

function App() {
  return (
    <DeliveryProvider>
      <Toaster
        position={'top-right'}
        reverseOrder={false}
        toastOptions={{ duration: 5000 }}
        containerClassName={'text-sm'}
      />
    </DeliveryProvider>
  )
}

export default App
