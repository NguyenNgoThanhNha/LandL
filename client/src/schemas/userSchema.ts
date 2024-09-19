import { z } from 'zod'
//signup
export const UserSignupSchema = z.object({
  email: z
    .string({
      required_error: 'Email is required'
    })
    .min(1, 'Email is required')
    .email({ message: 'Email is not a valid email' }),
  userName: z
    .string({
      required_error: 'Username is required'
    })
    .min(1, 'Username is required'),
  password: z
    .string({
      required_error: 'Password is required'
    })
    .min(1, 'Password is required'),
  confirmPassword: z
    .string({
      required_error: 'Confirm password is required'
    })
    .min(1, 'Confirm password is required'),
  phone: z
    .string()
    .min(1, 'Phone number is required')
    .length(10, 'Phone number must be exactly 10 digits')
    .regex(/^\d+$/, 'Phone number must contain only digits')
    .refine((val) => val.length === 10, { message: 'Phone number must be exactly 10 digits' }),
  policy: z.boolean()
})

export type UserSignupType = z.infer<typeof UserSignupSchema>
//login
export const UserLoginSchema = z.object({
  email: z
    .string({
      required_error: 'Email is required'
    })
    .min(1, 'Email is required')
    .email({ message: 'Email is not a valid email' }),
  password: z
    .string({
      required_error: 'Password is required'
    })
    .min(1, 'Password is required')
})
export type UserLoginType = z.infer<typeof UserLoginSchema>
//forgot-password
export const UserForgotPasswordSchema = z.object({
  email: z
    .string({
      required_error: 'Email is required'
    })
    .min(1, 'Email is required')
})
export type UserForgotPasswordType = z.infer<typeof UserForgotPasswordSchema>
//verify-code
export const UserVerifyCodeSchema = z.object({
  otp: z
    .string({
      required_error: 'Code is required'
    })
    .min(1, 'Code is required')
})
export type UserVerifyCodeType = z.infer<typeof UserVerifyCodeSchema>
//set password
export const UserSetPasswordSchema = z.object({
  newPassword: z
    .string({
      required_error: 'Password is required'
    })
    .min(1, 'Password is required'),
  confirmNewPassword: z
    .string({
      required_error: 'Confirm password is required'
    })
    .min(1, 'Confirm password is required')
})
export type UserSetPasswordType = z.infer<typeof UserSetPasswordSchema>
//get promote code
export const UserGetPromoteCodeSchema = z.object({
  email: z
    .string({
      required_error: 'Email is required'
    })
    .min(1, 'Email is required'),
  username: z
    .string({
      required_error: 'Username is required'
    })
    .min(1, 'Username is required'),
  phoneNumber: z
    .string()
    .min(1, 'Phone number is required')
    .length(10, 'Phone number must be exactly 10 digits')
    .regex(/^\d+$/, 'Phone number must contain only digits')
    .refine((val) => val.length === 10, { message: 'Phone number must be exactly 10 digits' })
})

export type UserGetPromoteCodeType = z.infer<typeof UserGetPromoteCodeSchema>
