import Banner from '@/components/molecules/Banner.tsx'
import { IMAGES_FORGOTPASSWORD } from '@/contants/imageBanner.ts'
import ForgotPasswordForm from '@/components/organisms/ForgotPassword/ForgotPasswordForm.tsx'
import { ChevronLeft } from 'lucide-react'
import { Link } from 'react-router-dom'

const ForgotPasswordPage = () => {
  return (
    <div className={'container grid md:grid-cols-2 sm:grid-cols-1 gap-14 items-center h-screen'}>
      <div className={'md:col-span-1 sm:col-span-1 flex flex-col gap-6 py-10'}>
        <div>
          <img src={'/logoLL.png'} alt={'logo'} className={'w-20 h-20'} />
        </div>
        <Link to={'/login'} className={'flex space-x-2 cursor-pointer items-center hover:text-black'}>
          <ChevronLeft />
          <span>Back to login</span>
        </Link>
        <div>
          <p className={'text-4xl tracking-wide font-bold py-2'}>Forgot your password? </p>
          <span>Don’t worry, happens to all of us. Enter your email below to recover your password.</span>
        </div>
        <ForgotPasswordForm />
      </div>
      <div className={'md:col-span-1 sm:col-span-1'}>
        <Banner classContent={'max-w-md sm:ml-8'} images={IMAGES_FORGOTPASSWORD} />
      </div>
    </div>
  )
}

export default ForgotPasswordPage
