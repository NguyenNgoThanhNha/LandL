import {
  AlertDialog,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogDescription,
  AlertDialogTitle,
  AlertDialogCancel,
  AlertDialogAction
} from '@/components/atoms/ui/alert-dialog.tsx'
import { formatCurrency } from '@/utils/formatCurrency.ts'
import { useDelivery } from '@/context/deliveryContext.tsx'

interface Props {
  price: number
}

const PriceDialog = ({ price }: Props) => {
  // const { setStatus } = useDelivery()
  return (
    <AlertDialog defaultOpen={true}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle className={'flex justify-center text-orangeTheme font-bold text-2xl'}>COST OF YOUR
            ORDER </AlertDialogTitle>
          <AlertDialogDescription className={'text-black'}>
            <p className={'flex font-light items-center  py-3'}>Estimated cost: <span
              className={'px-3 py-2 bg-orangeTheme text-white ml-2 rounded '}>{formatCurrency(price)}</span></p>
            <p> Do you want to find shipper to delivery your package?</p>
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel
            className={'hover:bg-orangeTheme/10 text-orangeTheme hover:text-orangeTheme'}>Cancel</AlertDialogCancel>
          <AlertDialogAction className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90'}>Confirm</AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  )
}

export default PriceDialog