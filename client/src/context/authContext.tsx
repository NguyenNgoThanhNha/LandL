import { createContext, ReactNode, useContext, useState } from "react"

interface AuthContextType {
  auth: {
    user: string | null
    isAdmin: boolean | null
    id: string | null
  }
  setAuth: (auth: { user: string | null; isAdmin: boolean | null; id: string | null }) => void
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [auth, setAuth] = useState<AuthContextType["auth"]>({ user: null, isAdmin: null, id: null })
  
  return <AuthContext.Provider value={{ auth, setAuth }}>{children}</AuthContext.Provider>
}

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider")
  }
  return context
}
