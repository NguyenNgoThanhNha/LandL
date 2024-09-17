import { SubmitHandler, useForm } from 'react-hook-form'
import { UserLoginSchema, UserLoginType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import OptionFormFooter from '@/components/molecules/OptionFormFooter.tsx'
import { Link, useNavigate } from 'react-router-dom'
import { zodResolver } from '@hookform/resolvers/zod'
import { useState } from 'react'
import auth from '@/services/authService.ts'
import toast from 'react-hot-toast'
import { ROUTES } from '@/contants/routerEndpoint.ts'
import Loading from '@/components/templates/Loading.tsx'

const LoginForm = () => {
  const [loading, setLoading] = useState<boolean>(false)
  const navigate = useNavigate()
  const form = useForm<UserLoginType>({
    resolver: zodResolver(UserLoginSchema),
    defaultValues: {
      email: '',
      password: ''
    }
  })
  const onSubmit: SubmitHandler<UserLoginType> = async (data: UserLoginType) => {
    setLoading(true)
    const response = await auth.login(data)
    setLoading(false)
    if (response.success) {
      localStorage.setItem('accessToken', response?.result?.token as string)
      toast.success(response?.result?.message as string)
      navigate(ROUTES.HOME)
    } else {
      toast.error(response?.result?.message as string)
    }
  }
  return (
    <Form {...form} >
      <form onSubmit={form.handleSubmit(onSubmit)}>
        <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
          <FormInput
            name={'email'}
            form={form}
            placeholder={'Ex:customer@gmail.com'}
            classContent={'col-span-2'}
            autoFocus
          />
          <FormInput name={'password'} form={form} classContent={'col-span-2'} type={'password'} />
          <div className={'justify-end flex text-orangeTheme text-sm col-span-2 -mt-4 font-semibold'}>
            <Link to={'/forgot-password'}>Forgot password</Link>
          </div>
        </div>
        <div className={'flex flex-col gap-2'}>
          <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}
                  disabled={form.formState.isSubmitting}>
            Login
          </Button>
          <div className={'text-sm justify-center flex gap-1'}>
            Don’t have an account?{' '}
            <Link to={'/sign-up'} className={'text-orangeTheme font-semibold'}>
              Sign up
            </Link>
          </div>
        </div>
        <div className={'text-sm font-extralight flex items-center justify-center gap-4'}>
          <Separator className={'w-1/3'} />
          <span> Or Login with</span>
          <Separator className={'w-1/3'} />
        </div>
        <OptionFormFooter />
      </form>
      {loading && <Loading />}
    </Form>
  )
}

export default LoginForm
