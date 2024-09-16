import { post, ResponseProps } from '@/services/root.ts'
import { UserSignupType } from '@/schemas/userSchema.ts'

interface RegisterProps {
  data: UserSignupType
}

const register = async ({ data }: RegisterProps): Promise<ResponseProps> => {
  return await post('Auth/FirstStep', data)
}

interface VerifyProps {
  email: string
  otp: string
}

const verify = async ({ email, otp }: VerifyProps): Promise<ResponseProps> => {
  return await post('Auth/SubmitOTP', { email, otp })
}

interface LoginProps {
  email: string
  password: string
}

const login = async ({ email, password }: LoginProps): Promise<ResponseProps> => {
  return await post('Auth/login', { email, password })
}

interface ForgotPasswordProps {
  email: string
}

const forgotPassword = async ({ email }: ForgotPasswordProps): Promise<ResponseProps> => {
  return await post(`Auth/Forget-Password?email=${email}`, {})
}

interface ResendOTPProps {
  email: string
}

const resendOTP = async ({ email }: ResendOTPProps): Promise<ResponseProps> => {
  return await post(`Auth/ResendOTPProps?email=${email}`, {})
}

interface UpdatePasswordProps {
  email: string
  password: string
  confirmPassword: string
}

const updatePassword = async ({ email, password, confirmPassword }: UpdatePasswordProps): Promise<ResponseProps> => {
  return await post(`Auth/UpdatePassword?email=${email}`, { password, confirmPassword })
}

interface LoginWithGGProps {
  data: UserSignupType
}

const loginWithGG = async ({ data }: LoginWithGGProps): Promise<ResponseProps> => {
  return await post('Auth/login-google', data)
}
export default {
  register,
  verify,
  login,
  forgotPassword,
  resendOTP,
  updatePassword,
  loginWithGG
}