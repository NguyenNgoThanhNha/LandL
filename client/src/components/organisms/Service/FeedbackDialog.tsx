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
import DriverFeedback from '@/components/molecules/DriverFeedback.tsx'
import { useState } from 'react'
import { Textarea } from '@/components/atoms/ui/textarea.tsx'

interface Props {
}

const FeedbackDialog = ({}: Props) => {
  const [feedback, setFeedback] = useState('')
  return (
    <AlertDialog defaultOpen={true}>
      <AlertDialogContent className={'bg-orangeTheme outline-none border-none !rounded-none'}>
        <AlertDialogHeader>
          <AlertDialogTitle className={'flex flex-col '}>
            <div className={'flex justify-between'}>
              <span className={'p-2 text-lg text-white uppercase font-black'}>Reviews</span>
              <div className={'bg-darkTheme font-normal w-fit h-fit p-2 text-sm text-white'}> Give your review</div>
            </div>
            <DriverFeedback name={'Nguyen Van A'} rating={4.2} numberOfReviews={324} />
          </AlertDialogTitle>
          <AlertDialogDescription className={'text-white'}>
            <Textarea className={'w-full text-darkTheme my-2'} placeholder={'Your feedback'} value={feedback}
                      onChange={(e) => setFeedback(e.target.value)}></Textarea>
          </AlertDialogDescription>
        </AlertDialogHeader>
        <AlertDialogFooter>
          <AlertDialogCancel
            className={'hover:bg-darkTheme/10 text-darkTheme hover:text-darkTheme rounded-none'}>Skip</AlertDialogCancel>
          <AlertDialogAction
            className={'bg-darkTheme w-fit hover:bg-darkTheme/90 rounded-none'}>Submit</AlertDialogAction>
        </AlertDialogFooter>
      </AlertDialogContent>
    </AlertDialog>
  )
}

export default FeedbackDialog