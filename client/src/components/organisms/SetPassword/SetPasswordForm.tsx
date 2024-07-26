import { useForm } from 'react-hook-form'
import { UserSetPasswordType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'

const SetPasswordForm = () => {
  const form = useForm<UserSetPasswordType>()
  return (
    <Form {...form}>
      <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
        <FormInput name={'newPassword'} form={form} type={'password'} classContent={'col-span-2'} autoFocus />
        <FormInput name={'confirmNewPassword'} form={form} type={'password'} classContent={'col-span-2'} />
      </div>
      <div className={'flex flex-col gap-2'}>
        <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
          Set password
        </Button>
      </div>
    </Form>
  )
}

export default SetPasswordForm
