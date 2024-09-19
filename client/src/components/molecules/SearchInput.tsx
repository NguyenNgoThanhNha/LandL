import FormInput from '@/components/molecules/FormInput.tsx'
import { FieldValues, Path, PathValue, UseFormReturn } from 'react-hook-form'
import useDebounce from '@/hooks/useDebound.ts'
import { searchAddress } from '@/services/mapService.ts'
import { useEffect, useState } from 'react'
import { cn } from '@/utils/cn.ts'

interface SearchInputProps<T extends FieldValues> {
  classContent?: string
  name: Path<T>
  type?: 'text' | 'number' | 'checkbox' | 'password'
  placeholder?: string
  form: UseFormReturn<T>
  autoFocus?: boolean
  setPlaceId: (value: string) => void
}

const SearchInput = <T extends FieldValues>({
  classContent,
  name,
  type = 'text',
  placeholder,
  form,
  autoFocus = false,
  setPlaceId
}: SearchInputProps<T>) => {
  const input = form.watch(name)
  const debouncedValue = useDebounce(input, 300)
  const [call, setCall] = useState(true)

  const [listAddress, setListAddress] = useState<null | []>(null)
  const search = async (): Promise<void> => {
    const rs = await searchAddress({ input: debouncedValue })
    setListAddress(rs['predictions'])
  }
  useEffect(() => {
    if (call && debouncedValue) {
      search()
    }
  }, [debouncedValue, call])

  useEffect(() => {
    setCall(true)
  }, [input])

  const onChoose = (value: string, placeId: string) => {
    form.setValue(name, value as PathValue<T, Path<T>>)
    setListAddress(null)
    setCall(false)
    setPlaceId(placeId)
  }

  return (
    <div className={cn('relative', classContent)}>
      <FormInput name={name} form={form} placeholder={placeholder} autoFocus={autoFocus} type={type} />
      <div
        className={cn(
          'absolute bg-slate-50 rounded-sm z-20 p-2 transform -translate-y-2 w-full  ',
          listAddress === null && 'hidden'
        )}
      >
        {listAddress &&
          listAddress?.length > 0 &&
          listAddress?.map((address, index) => (
            <div
              className={cn('text-sm py-1 px-2 hover:bg-slate-100 rounded')}
              key={index}
              onClick={() => onChoose(address['description'], address['place_id'])}
            >
              {address['description']}
            </div>
          ))}
        {listAddress && listAddress?.length === 0 && <div>Not found any where</div>}
      </div>
    </div>
  )
}

export default SearchInput
