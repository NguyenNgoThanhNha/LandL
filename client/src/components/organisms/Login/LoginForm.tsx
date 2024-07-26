import { useForm } from 'react-hook-form'
import { UserLoginType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import OptionFormFooter from '@/components/molecules/OptionFormFooter.tsx'
import { Link } from 'react-router-dom'

const LoginForm = () => {
  const form = useForm<UserLoginType>()
  return (
    <Form {...form}>
      <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
        <FormInput
          name={'email'}
          form={form}
          placeholder={'Ex:customer@gmail.com'}
          classContent={'col-span-2'}
          autoFocus
        />
        <FormInput name={'password'} form={form} classContent={'col-span-2'} type={'password'} />
      </div>
      <div className={'flex flex-col gap-2'}>
        <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
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
    </Form>
  )
}

export default LoginForm
