import { createContext, ReactNode, useContext, useState } from 'react'
import { TUser } from '@/types/UserType.ts'

interface AuthContextType {
  auth: {
    user?: TUser
  }
  setAuth: (auth: { user: TUser }) => void
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [auth, setAuth] = useState<AuthContextType['auth']>({})

  return <AuthContext.Provider value={{ auth, setAuth }}>{children}</AuthContext.Provider>
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
