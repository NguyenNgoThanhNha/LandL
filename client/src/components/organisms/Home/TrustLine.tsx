import { Button } from '@/components/atoms/ui/button.tsx'

const TrustLine = () => {
  return (
    <div
      className={
        'bg-[url(/home-6.png)] bg-cover w-full px-20  h-[400px] text-white py-10 flex flex-col gap-4 text-start justify-center'
      }
    >
      <p className={'text-4xl tracking-tight uppercase  font-semibold'}>Reach your destination 100% sure and safe</p>
      <p className={'text-lg'}>We will take care of your chemicals and deliver them safe and on time</p>
      <Button className={'bg-orangeTheme hover:bg-orangeTheme/90 uppercase tracking-tight rounded-none w-fit p-3 '}>
        Request a quote
      </Button>
    </div>
  )
}

export default TrustLine
