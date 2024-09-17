import './App.css'
import { RouterProvider } from 'react-router-dom'
import router from '@/router.tsx'
import "mapbox-gl/dist/mapbox-gl.css"
import { Toaster } from 'react-hot-toast'

function App() {
  return (
    <>
      <RouterProvider router={router} />
      <Toaster position={"top-right"} reverseOrder={false} toastOptions={{duration: 5000}} />
    </>
  )
}

export default App
