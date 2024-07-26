import { useForm } from 'react-hook-form'
import { UserForgotPasswordType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import OptionFormFooter from '@/components/molecules/OptionFormFooter.tsx'

const ForgotPasswordForm = () => {
  const form = useForm<UserForgotPasswordType>()
  return (
    <Form {...form}>
      <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
        <FormInput
          name={'email'}
          form={form}
          placeholder={'Ex:customer@gmail.com'}
          classContent={'col-span-2'}
          autoFocus={true}
        />
      </div>
      <div className={'flex flex-col gap-2'}>
        <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
          Submit
        </Button>
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

export default ForgotPasswordForm
