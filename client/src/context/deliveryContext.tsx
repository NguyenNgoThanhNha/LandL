import { createContext, ReactNode, useContext, useState } from 'react'

interface DeliveryContextType {
  status: number
  setStatus: (status: number) => void
}

const DeliveryContext = createContext<DeliveryContextType | undefined>(undefined)

export const DeliveryProvider = ({ children }: { children: ReactNode }) => {
  const [status, setStatus] = useState<DeliveryContextType['status']>(1)
  return <DeliveryContext.Provider value={{ status, setStatus }}>{children}</DeliveryContext.Provider>
  
}
export const useDelivery = () => {
  const context = useContext(DeliveryContext)
  if (!context) {
    throw new Error('useDelivery must be used within an AuthProvider')
  }
  return context
}