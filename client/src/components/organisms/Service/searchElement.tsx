import { useForm } from 'react-hook-form'
import { searchProductType } from '@/schemas/productSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'

const SearchElement = () => {
  const form = useForm<searchProductType>()
  return (
    <Form {...form}>
      <div className={'grid grid-cols-6  gap-x-4 gap-y-4 border rounded pt-6 pb-3 px-3 bg-slate-200'}>
        <FormInput name={'from'} form={form} placeholder={'Ex: 124 Hoang Huu Nam, Tan Phu'}
                   classContent={'col-span-3'}
                   autoFocus />
        <FormInput name={'to'} form={form} placeholder={'Ex: 143 Hoang Van Thu, Phu Nhuan'}
                   classContent={'col-span-3'} />
        
        <FormInput name={'width'} form={form} placeholder={'Ex: 1200cm'}
                   classContent={'col-span-2'} />
        <FormInput name={'length'} form={form} placeholder={'Ex: 120cm'}
                   classContent={'col-span-2'} />
        <FormInput name={'height'} form={form} placeholder={'Ex: 20cm'}
                   classContent={'col-span-2'} />
        
        <FormInput name={'number_of_products'} form={form} placeholder={'Ex: 12'}
                   classContent={'col-span-2'} />
        <FormInput name={'weight'} form={form} placeholder={'Ex: 10000g'}
                   classContent={'col-span-2'} />
        <FormInput name={'type'} form={form} placeholder={'Ex: Hang dong lanh'}
                   classContent={'col-span-2'} />
        <FormInput name={'time'} form={form} placeholder={'Ex: 12:00 AM 12/12/2024'}
                   classContent={'col-span-3'} />
        
        <div className={'col-span-6 flex justify-end '}><Button
          className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90 px-6 '}
          type={'submit'}>
          Search
        </Button></div>
      </div>
    </Form>
  )
}

export default SearchElement