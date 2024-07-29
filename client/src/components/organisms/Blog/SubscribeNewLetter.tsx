import { Input } from '@/components/atoms/ui/input.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'
import { useState } from 'react'

const SubscribeNewLetter = () => {
  const [email, setEmail] = useState<string>('')
  console.log(email)
  return (
    <div className={'bg-orange-400 w-full h-[300px] flex px-20 flex-wrap'}>
      <div className={'flex flex-col justify-center  text-white'}>
        <p className={'font-bold text-4xl '}>Subscribe Our Newsletter</p>
        <p>Stay in touch with us to get latest news. </p>
      </div>
      <div className={'flex ml-auto justify-center items-center'}>
        <Input
          placeholder={'Enter your email here'}
          className={'rounded-none w-80'}
          onChange={(e) => setEmail(e.target.value)}
        />
        <Button className={'bg-slate-50  rounded-none text-black hover:text-white'}>Subscribe</Button>
      </div>
    </div>
  )
}

export default SubscribeNewLetter
