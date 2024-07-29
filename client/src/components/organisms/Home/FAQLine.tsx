import FrequentAskedQuestion from '@/components/organisms/Home/FrequentAskedQuestion.tsx'
import { Phone } from 'lucide-react'
import { Button } from '@/components/atoms/ui/button.tsx'

const FaqLine = () => {
  return (
    <div className={'grid md:grid-cols-2 sm:grid-cols-1 w-full py-8'}>
      <FrequentAskedQuestion />
      <div className={'items-center flex relative'}>
        <img src={'/home-5.png'} className={'w-96 object-cover ml-auto'} alt={'/home-5.png'} />
        <div className={'flex flex-col gap-4 bg-darkTheme text-white absolute left-12 p-6 w-[400px]'}>
          <div className={'bg-orangeTheme text-sm font-semibold px-2 w-fit py-1'}>Let's talk</div>
          <p className={'font-semibold text-lg'}>You need any help? Get Free Consultation</p>
          <div className={'flex gap-3'}>
            <span className={'flex items-center justify-center p-3 bg-white rounded-full'}>
              <Phone className={'text-orangeTheme'} strokeWidth={1} />
            </span>
            <p className={'font-light'}>
              Have Any Questions <br />
              (00) 112 365 489
            </p>
          </div>
          <Button
            className={
              'bg-orangeTheme hover:bg-orangeTheme/90 w-fit text-black rounded-none text-md p-6 relative overflow-hidden'
            }
          >
            Contact us
            <span
              className={
                'w-10 h-10 rounded-full bg-white absolute bottom-0 right-0 transform translate-x-1/2 translate-y-1/2'
              }
            ></span>
          </Button>
        </div>
      </div>
    </div>
  )
}

export default FaqLine
