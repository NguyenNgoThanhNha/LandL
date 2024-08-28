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

interface Props {
  price: number
}

const OrderCompleteDialog = ({}: Props) => {
  return (
    <AlertDialog defaultOpen={true}>
      <AlertDialogContent>
        <AlertDialogHeader>
          <AlertDialogTitle className={'flex justify-center font-bold'}>Confirm Order Completed </AlertDialogTitle>
          <AlertDialogDescription className={'text-black flex flex-col gap-2'}>
            <p className={'text-orangeTheme font-semibold uppercase'}> Has your order been delivered successfully?</p>
            <span className={"text-sm"}>
              Please confirm the completion of your order if you have received your items in good condition
            </span>
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel
            className={'hover:bg-orangeTheme/10 text-orangeTheme hover:text-orangeTheme'}>Cancel</AlertDialogCancel>
          <AlertDialogAction className={'bg-orangeTheme w-fit hover:bg-orangeTheme/90'}>Yes, order has been
            completed</AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  )
}

export default OrderCompleteDialog