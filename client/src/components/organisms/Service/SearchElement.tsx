import { SubmitHandler, useForm } from 'react-hook-form'
import { SearchProductSchema, SearchProductType, SearchProductWithDistanceType } from '@/schemas/productSchema.ts'
import { Form } from '@/components/atoms/ui/form.tsx'
import FormInput from '@/components/molecules/FormInput.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import FormSelect from '@/components/molecules/FormSelect.tsx'
import FormDatePicker from '@/components/molecules/FormDatePicker.tsx'
import { zodResolver } from '@hookform/resolvers/zod'
import SearchInput from '@/components/molecules/SearchInput.tsx'
import { useState } from 'react'
import Loading from '@/components/templates/Loading.tsx'
import { getPrice } from '@/services/deliveryService.ts'
import toast from 'react-hot-toast'
import { useDelivery } from '@/context/deliveryContext.tsx'
import PriceDialog from '@/components/organisms/Service/PriceDialog.tsx'
import { getDirection, getLocationByPlaceId } from '@/services/mapService.ts'
import { LngLat } from 'mapbox-gl'

const SearchElement = () => {
  const { status } = useDelivery()
  const [price, setPrice] = useState<number>(0)
  const [openModelPrice, setOpenModelPrice] = useState<boolean>(false)
  const [loading, setLoading] = useState<boolean>(false)
  const [placeIdSource, setPlaceIdSource] = useState<string>('')
  const [placeIdDestination, setPlaceIdDestination] = useState<string>('')
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
      date: new Date().toDateString()
    }
  })
  const onSubmit: SubmitHandler<SearchProductType> = async (data: SearchProductType) => {
    setLoading(true)
    const sourceLocation = await getLocationByPlaceId({ placeId: placeIdSource })
    const destinationLocation = await getLocationByPlaceId({ placeId: placeIdDestination })
    const lngLatSource: LngLat = sourceLocation['results'][0]['geometry']['location']
    const lngLatDestination: LngLat = destinationLocation['results'][0]['geometry']['location']
    
    const distanceQuery = await getDirection({ source: lngLatSource, destination: lngLatDestination })
    const distance = distanceQuery['routes'][0]['legs'][0]['distance']['value'] as number
    const expectedData: SearchProductWithDistanceType = { ...data, distance }
    const response = await getPrice({ data: expectedData })
    setLoading(false)
    if (response.success) {
      toast.success(response?.result?.message as string)
      setPrice(response?.result?.data as number)
      setOpenModelPrice(true)
    } else {
      toast.error(response?.result?.message as string)
    }
  }
  return (
    
    status === 1 && <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)}>
        
        <div className={'grid grid-cols-6  gap-x-4 gap-y-4 border rounded pt-6 pb-3 px-3 bg-slate-200'}>
          <SearchInput name={'from'} form={form} placeholder={'Ex: 124 Hoang Huu Nam, Tan Phu'}
                       classContent={'col-span-3'}
                       setPlaceId={setPlaceIdSource}
                       autoFocus />
          <SearchInput name={'to'} form={form} placeholder={'Ex: 143 Hoang Van Thu, Phu Nhuan'}
                       classContent={'col-span-3'}
                       setPlaceId={setPlaceIdDestination} />
          
          <FormInput name={'width'} form={form} placeholder={'Ex: 1200cm'}
                     classContent={'col-span-2'} />
          <FormInput name={'length'} form={form} placeholder={'Ex: 120cm'}
                     classContent={'col-span-2'} />
          <FormInput name={'height'} form={form} placeholder={'Ex: 20cm'}
                     classContent={'col-span-2'} />
          
          {/*<FormInput name={'number_of_products'} form={form} placeholder={'Ex: 12'}*/}
          {/*           classContent={'col-span-2'} />*/}
          <FormInput name={'weight'} form={form} placeholder={'Ex: 10000g'}
                     classContent={'col-span-2'} />
          <FormSelect form={form} content={['Hang kho', 'Hang Dong Lanh', 'Thuc Pham']} name={'type'}
                      trigger={'Select type of product'} enableOther={true}
                      classContent={'col-span-2'} />
          <FormDatePicker name={'date'} form={form} addDay={3} subDay={1}
                          classContent={'col-span-2'} />
          
          <div className={'col-span-6 flex justify-end '}><Button
            className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90 px-6 '}
            type={'submit'}>
            Search
          </Button></div>
        </div>
      </form>
      {
        loading && <Loading />
      }
      {
        openModelPrice && (
          <PriceDialog price={price} />
        )
      }
    </Form>
  
  )
}

export default SearchElement