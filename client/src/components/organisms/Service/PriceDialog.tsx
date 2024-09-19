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
import { ConfirmProductType } from '@/schemas/productSchema.ts'
import { useDelivery } from '@/context/deliveryContext.tsx'
import { createOrder } from '@/services/deliveryService.ts'
import { useState } from 'react'
import toast from 'react-hot-toast'
import Loading from '@/components/templates/Loading.tsx'
import { ROUTES } from '@/contants/routerEndpoint.ts'
import { useNavigate } from 'react-router-dom'

interface Props {
  price: number
  confirmData: ConfirmProductType | {}
  open: boolean
  onClose: () => void
  infoPriceList: any
}

const PriceDialog = ({ price, confirmData, open, onClose, infoPriceList }: Props) => {
  const [loading, setLoading] = useState<boolean>(false)
  const navigate = useNavigate()
  const { status, setStatus } = useDelivery()

  const handleConfirm = async () => {
    setLoading(true)
    const response = await createOrder({
      data: confirmData as ConfirmProductType,
      listCost: { listCost: infoPriceList }
    })
    setLoading(false)
    onClose()
    if (response.success) {
      setStatus(status + 1)
      toast.success(response?.result?.message as string)
      navigate(ROUTES.MY_ORDER)
    } else {
      toast.error(response?.result?.message as string)
    }
  }
  return (
    <>
      <AlertDialog open={open}>
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle className={'flex justify-center text-orangeTheme font-bold text-2xl'}>
              COST OF YOUR ORDER{' '}
            </AlertDialogTitle>
            <AlertDialogDescription className={'text-black'}>
              <span className={'flex font-light items-center  py-1'}>
                Estimated cost: <span className={'px-3 py-2  ml-2  font-medium'}>{formatCurrency(price)}</span>{' '}
                <span>(Recommend)</span>
              </span>
              <span className={'items-center block justify-center font-medium py-1'}>
                {' '}
                Do you want to find shipper to delivery your package?
              </span>

              <span className={'text-xs block'}>
                The cost can be higher if we can't looking for a driver properly with this package. If it has any
                change, we will send you an email!
              </span>
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel
              className={'hover:bg-orangeTheme/10 text-orangeTheme hover:text-orangeTheme'}
              onClick={() => onClose()}
            >
              Cancel
            </AlertDialogCancel>
            <AlertDialogAction className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90'} onClick={handleConfirm}>
              Confirm
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
      {loading && <Loading />}
    </>
  )
}

export default PriceDialog
