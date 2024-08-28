import { FieldValues, SubmitHandler, useForm } from 'react-hook-form'
import { UserSetPasswordSchema, UserSetPasswordType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { zodResolver } from '@hookform/resolvers/zod'

const SetPasswordForm = () => {
  const form = useForm<UserSetPasswordType>({
    resolver: zodResolver(UserSetPasswordSchema),
    defaultValues: {
      newPassword: '',
      confirmNewPassword: ''
    }
  })
  const onSubmit: SubmitHandler<FieldValues> = async (data) => {
    console.log(data)
  }
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
          <FormInput name={'newPassword'} form={form} type={'password'} classContent={'col-span-2'} autoFocus />
          <FormInput name={'confirmNewPassword'} form={form} type={'password'} classContent={'col-span-2'} />
        </div>
        <div className={'flex flex-col gap-2'}>
          <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
            Set password
          </Button>
        </div>
      </form>
    </Form>
  )
}

export default SetPasswordForm
