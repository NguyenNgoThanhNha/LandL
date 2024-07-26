import { Button } from '@/components/atoms/ui/button.tsx'

const OptionFormFooter = () => {
  return (
    <div
      className='justify-center gap-4 grid md:grid-cols-3 sm:grid-cols-1 *:col-span-1 *:bg-transparent
      *:border *:border-orangeTheme *:p-2 '
    >
      <Button className={'hover:bg-slate-50'}>
        <img src={'/facebook.webp'} alt={'facebook-logo'} className='w-6' />
      </Button>
      <Button className={'hover:bg-slate-50'}>
        <img src={'/google.png'} alt={'google-logo'} className='w-6' />
      </Button>
      <Button className={'hover:bg-slate-50'}>
        <img src={'/apple.png'} alt={'apple-logo'} className='w-6' />
      </Button>
    </div>
  )
}

export default OptionFormFooter
