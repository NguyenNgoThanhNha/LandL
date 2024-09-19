import { Button } from '@/components/atoms/ui/button.tsx'
import { useAuth0 } from '@auth0/auth0-react';

const OptionFormFooter = () => {
  const { loginWithRedirect } = useAuth0();
  return (
    <div
      className='justify-center mt-2 gap-4 items-center *:bg-transparent
      *:border *:border-orangeTheme *:p-2 w-full flex'
    >
      {/*<Button className={'hover:bg-slate-50'}>*/}
      {/*  <img src={'/facebook.webp'} alt={'facebook-logo'} className='w-6' />*/}
      {/*</Button>*/}
      <Button className={'hover:bg-slate-50 flex-1'} onClick={async () => await loginWithRedirect()}>
        <img src={'/google.png'} alt={'google-logo'} className='w-6 ' />
        <p className={'text-slate-700 text-sm px-6'}>Login with Google</p>
      </Button>
      {/*<Button className={'hover:bg-slate-50'}>*/}
      {/*  <img src={'/apple.png'} alt={'apple-logo'} className='w-6' />*/}
      {/*</Button>*/}
    </div>
  )
}

export default OptionFormFooter
