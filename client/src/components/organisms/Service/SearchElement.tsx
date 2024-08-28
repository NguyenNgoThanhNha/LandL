import { FieldValues, SubmitHandler, useForm } from 'react-hook-form'
import { SearchProductSchema, SearchProductType } from '@/schemas/productSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import FormSelect from '@/components/molecules/FormSelect.tsx'
import FormDatePicker from '@/components/molecules/FormDatePicker.tsx'
import { zodResolver } from '@hookform/resolvers/zod'

const SearchElement = () => {
  const form = useForm<SearchProductType>({
    resolver: zodResolver(SearchProductSchema),
    defaultValues: {
      from: '',
      to: '',
      weight: 1000,
      height: 1000,
      width: 1000,
      length: 1000,
      type: '',
      date: ''
    }
  })
  const onSubmit: SubmitHandler<FieldValues> = async (data) => {
    console.log(data)
  }
  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        
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
          <FormSelect form={form} content={['Hang kho', 'Hang Dong Lanh', 'Thuc Pham']} name={'type'}
                      trigger={'Select type of product'} enableOther={true}
                      classContent={'col-span-2'} />
          <FormDatePicker name={'date'} form={form} addDay={3} subDay={1}
                          classContent={'col-span-3'} />
          
          <div className={'col-span-6 flex justify-end '}><Button
            className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90 px-6 '}
            type={'submit'}>
            Search
          </Button></div>
        </div>
      </form>
    </Form>
  )
}

export default SearchElement