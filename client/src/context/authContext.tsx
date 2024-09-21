import { createContext, ReactNode, useContext, useEffect, useState } from 'react'
import { TUser } from '@/types/UserType.ts'
import authService from '@/services/authService'
interface AuthContextType {
  auth: {
    user?: TUser
  }
  setAuth: (auth: { user: TUser }) => void
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [auth, setAuth] = useState<AuthContextType['auth']>({})
  const handleGetUserInfo = async () => {
    const response = await authService.getUserInfo()
    if (response.success) {
      setAuth({ user: response.result?.data })
    }
  }

  useEffect(() => {
    handleGetUserInfo()
  }, [])
  return <AuthContext.Provider value={{ auth, setAuth }}>{children}</AuthContext.Provider>
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
