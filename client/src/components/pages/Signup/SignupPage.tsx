import SignupForm from '@/components/organisms/Signup/SignupForm.tsx'
import Banner from '@/components/molecules/Banner.tsx'
import { IMAGES_SIGNUP } from '@/contants/imageBanner.ts'

const SignupPage = () => {
  return (
    <div className={'container grid md:grid-cols-5 sm:grid-cols-1 gap-8 items-center h-screen'}>
      <div className={'md:col-span-2 sm:col-span-1'}>
        <Banner classContent={'md:max-w-xs ml-8 sm:max-w-md '} images={IMAGES_SIGNUP} />
      </div>
      <div className={'md:col-span-3 sm:col-span-1 flex flex-col gap-6 py-10'}>
        <div>
          <img src={'/logoLL.png'} alt={'logo'} className={'w-20 h-20'} />
        </div>
        <div>
          <p className={'text-4xl tracking-wide font-bold py-2'}>Sign up </p>
          <span>Let’s get you all st up so you can access your personal account.</span>
        </div>
        <SignupForm />
      </div>
    </div>
  )
}

export default SignupPage
