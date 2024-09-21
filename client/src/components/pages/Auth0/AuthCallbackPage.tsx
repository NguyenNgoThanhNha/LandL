import Loading from '@/components/templates/Loading'
import { useAuth0 } from '@auth0/auth0-react'
import { useEffect, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import auth from '@/services/authService'
import { UserSignInGGType } from '@/schemas/userSchema.ts'
import toast from 'react-hot-toast'

const AuthCallbackPage = () => {
  const navigate = useNavigate()
  const { user } = useAuth0()
  const hasCreatedUser = useRef(false)

  const handleSignInWithGG = async (user: any) => {
    const data: UserSignInGGType = {
      email: user.email,
      userName: user.nickname!,
      fullName: user.given_name!,
      avatar: user.picture!,
      typeAccount: 'Customer'
    }
    const response = await auth.loginWithGG({ data })
    if (response.success) {
      localStorage.setItem('accessToken', response?.result?.data as string)
      localStorage.setItem('email', data.email);
      toast.success(response?.result?.message as string)
    } else {
      toast.error(response?.result?.message as string)
    }
  }

  useEffect(() => {
    if (user?.sub && user?.email && !hasCreatedUser.current) {
      handleSignInWithGG(user)
      hasCreatedUser.current = true
    }
    navigate('/')
  }, [user, navigate])
  return <Loading />
}

export default AuthCallbackPage
