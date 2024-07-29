import { Separator } from '@/components/atoms/ui/separator.tsx'
import { Clock, Mail, Phone } from 'lucide-react'

const Footer = () => {
  return (
    <div className={'bg-darkTheme text-white px-20 py-5 text-sm mt-10'}>
      <div className={'flex gap-8 justify-between flex-wrap'}>
        <div className={'flex gap-2 items-center px-8'}>
          <img src={'/logoLL.png'} alt={'logo'} className={'w-28 h-28'} />
          <div className={'flex flex-col'}>
            <span className={'font-black tracking-tight text-orangeTheme text-lg'}>L&L COMPANY</span>
            <span className={'text-wrap'}>L&L Tower, District 1, Ho Chi Minh City, Viet Nam.</span>
          </div>
        </div>
        <div className={'flex flex-col justify-center'}>
          <div className={'flex gap-8 text-center justify-center'}>
            <span>Home</span>
            <span>Service</span>
            <span>Infrastructure</span>
            <span>Contact</span>
          </div>
          <Separator className={'mb-4'} />
          <div className={'flex gap-2 justify-center'}>
            <div className={'py-2'}>
              <div className={'flex gap-2 py-1'}>
                <Phone className={'text-orangeTheme'} />
                <span>+91 9221212192</span>
              </div>
              <div className={'flex gap-2 py-1'}>
                <Mail className={'text-orangeTheme'} />
                <span>L&Lcompany@gmail.com</span>
              </div>
            </div>
            <Separator orientation={'vertical'} />
            <div className={'flex gap-2 py-1'}>
              <Clock className={'text-orangeTheme'} />
              <span>
                Mon to Sat <br />
                09:30am to 06:00pm
              </span>
            </div>
          </div>
        </div>
      </div>
      <Separator className={'mt-4'} />
      <div className={'text-center pt-3'}>
        <span className={'text-xl'}>&copy;</span> 2024 Copyrights Allrights reserved by{' '}
        <span className={'font-semibold text-orangeTheme'}> L&L company</span>
      </div>
    </div>
  )
}

export default Footer
