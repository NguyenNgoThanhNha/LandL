import { Star } from 'lucide-react'
import { Separator } from '@/components/atoms/ui/separator.tsx'

const TruckInformation = () => {
  return (
    <div className={'flex mx-14 flex-col'}>
      <p className={'uppercase font-semibold text-orangeTheme text-lg justify-start'}>Truck information</p>
      <div className={'grid grid-cols-2 gap-4'}>
        <div className={'cols-span-1'}>
          <img src='' alt='' className={'w-1/2 object-cover'} />
          <p>69GD-367328</p>
        </div>
        <div className={'cols-span-1'}>
          <div className={'flex justify-between'}>
            <p className={'font-medium text-xl'}>Ventom car</p>
            <div className={'flex gap-4 border border-1 border-orangeTheme px-2 py-1 rounded-full'}>
              <Star className={'text-orangeTheme '} size={24} strokeWidth={'2'} />
              <p className={'font-semibold'}>4.5</p>
            </div>
          </div>
          <Separator className={'my-3'} />

          <div className={'flex flex-col'}>
            <div className={'grid grid-cols-3'}>
              <p className={'col-span-1 font-medium'}>Payload Capacity</p>
              <p className={'col-span-2'}>3,000 pounds</p>
            </div>
            <div className={'grid grid-cols-3'}>
              <p className={'col-span-1  font-medium'}>Truck Dimensions</p>
              <p className={'col-span-2'}>130cm x 170cm x 130cm</p>
            </div>
            <div className={'grid grid-cols-3'}>
              <p className={'col-span-1  font-medium'}>Type of truck</p>
              <p className={'col-span-2'}>Box truck</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default TruckInformation
