import { Form } from '@/components/atoms/ui/form.tsx'
import { useForm } from 'react-hook-form'
import FormInput from '@/components/molecules/FormInput.tsx'
import { UserSignupType } from '@/schemas/userSchema.ts'
import FormSwitch from '@/components/molecules/FormSwitch.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import OptionFormFooter from '@/components/molecules/OptionFormFooter.tsx'
import { Link } from 'react-router-dom'

const SignupForm = () => {
  const form = useForm<UserSignupType>()
  return (
    <Form {...form}>
      <div className={'grid md:grid-cols-6 sm:grid-cols-2 gap-x-2 gap-y-4'}>
        <FormInput
          name={'email'}
          form={form}
          placeholder={'Ex:customer@gmail.com'}
          classContent={'md:col-span-3'}
          autoFocus
        />
        <FormInput name={'username'} form={form} placeholder={'Ex:customer'} classContent={'md:col-span-3'} />
        <FormInput name={'phoneNumber'} form={form} placeholder={'Ex:0867 653 653'} classContent={'md:col-span-3'} />
        <FormInput name={'password'} form={form} type={'password'} classContent={'md:col-span-6'} />
        <FormInput name={'confirmPassword'} form={form} type={'password'} classContent={'md:col-span-6'} />
        <FormSwitch
          name={'policy'}
          content={'I agree to all Term and Policy'}
          form={form}
          classContent={'md:col-span-6'}
        />
      </div>
      <div className={'flex flex-col gap-2'}>
        <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
          Create account
        </Button>
        <div className={'text-sm justify-center flex gap-1'}>
          Already have an account?
          <Link to={'/login'} className={'text-orangeTheme font-semibold'}>
            Login
          </Link>
        </div>
      </div>
      <div className={'text-sm font-extralight flex items-center justify-center gap-4'}>
        <Separator className={'w-1/3'} />
        <span> Or Sign up with</span>
        <Separator className={'w-1/3'} />
      </div>
      <OptionFormFooter />
    </Form>
  )
}

export default SignupForm
