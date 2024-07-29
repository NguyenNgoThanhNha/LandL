import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger
} from '@/components/atoms/ui/dialog.tsx'
import { useForm } from 'react-hook-form'
import { UserGetPromoteCodeType } from '@/schemas/userSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'

const PromoteCodeForm = () => {
  const form = useForm<UserGetPromoteCodeType>()
  return (
    <Dialog>
      <DialogTrigger>Open</DialogTrigger>
      <DialogContent>
        <DialogHeader>
          <DialogTitle className={'uppercase pb-6 flex items-center'}>Get a Promote Code</DialogTitle>
          <DialogDescription>
            <Form {...form}>
              <div className={'flex flex-col gap-4 p-2 text-black'}>
                <FormInput name={'email'} form={form} placeholder={'Ex: customer@gmail.com'} />
                <FormInput name={'username'} form={form} placeholder={'Ex: customer'} />
                <FormInput name={'phoneNumber'} form={form} placeholder={'Ex: 0867 653 653'} />
              </div>
              <div className={'p-2'}>
                The discount code will be sent to your email. <br />
                Please enter this code before paying the bill.
              </div>
              <Button className={'bg-orangeTheme w-full hover:bg-orangeTheme/90'} type={'submit'}>
                Submit
              </Button>
            </Form>
          </DialogDescription>
        </DialogHeader>
      </DialogContent>
    </Dialog>
  )
}

export default PromoteCodeForm
