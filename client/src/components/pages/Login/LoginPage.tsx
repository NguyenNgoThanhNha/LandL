import Banner from '@/components/molecules/Banner.tsx'
import LoginForm from '@/components/organisms/Login/LoginForm.tsx'
import { IMAGES_LOGIN } from '@/contants/imageBanner.ts'

const LoginPage = () => {
  return (
    <div className={'container grid md:grid-cols-2 sm:grid-cols-1 gap-14 items-center h-screen'}>
      <div className={'md:col-span-1 sm:col-span-1 flex flex-col gap-6 py-10'}>
        <div>Logo</div>
        <div>
          <p className={'text-4xl tracking-wide font-bold py-2'}>Login </p>
          <span>Login to access your L&L account.</span>
        </div>
        <LoginForm />
      </div>
      <div className={'md:col-span-1 sm:col-span-1'}>
        <Banner classContent={'max-w-md sm:ml-8'} images={IMAGES_LOGIN} />
      </div>
    </div>
  )
}

export default LoginPage
