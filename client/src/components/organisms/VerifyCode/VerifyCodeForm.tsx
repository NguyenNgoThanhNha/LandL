import { FieldValues, SubmitHandler, useForm } from 'react-hook-form'
import { UserVerifyCodeSchema, UserVerifyCodeType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { zodResolver } from '@hookform/resolvers/zod'

const VerifyCodeForm = () => {
  const form = useForm<UserVerifyCodeType>({
    resolver: zodResolver(UserVerifyCodeSchema)
  })
  const onSubmit: SubmitHandler<FieldValues> = async (data) => {
    console.log(data)
  }
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        <div className={'grid grid-cols-2  gap-x-2 gap-y-4'}>
          <FormInput name={'code'} form={form} placeholder={'Ex: 16538'} classContent={'col-span-2'} autoFocus />
        </div>
        <div className={'flex flex-col gap-2'}>
          <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
            Verify
          </Button>
          <div className={'text-sm justify-center flex gap-1'}>
            Didn't received any code? <span className={'text-orangeTheme font-semibold cursor-pointer'}> Resend</span>
          </div>
        </div>
      </form>
    </Form>
  )
}

export default VerifyCodeForm
