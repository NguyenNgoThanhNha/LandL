import { Button } from '@/components/atoms/ui/button.tsx'
import { ArrowUpRight } from 'lucide-react'
import { useNavigate } from 'react-router-dom'
import { ROUTES } from '@/contants/routerEndpoint.ts'

const Slogan = () => {
  const navigate = useNavigate()
  return (
    <div className={'flex flex-col gap-10 md:w-1/3 sm:w-1/2 mr-auto text-white md:ml-20 mt-20'}>
      <div className={'flex flex-col gap-6'}>
        <p className={'uppercase text-4xl font-semibold tracking-tighter leading-normal'}>
          {' '}
          "Leopard Lorry: Leap and Lead"
        </p>
        <p>
          Welcome to Leopard Lorry - a groundbreaking sharing economy platform in the Vietnamese transportation
          industry. With 5 years of experience in the content field , we are confident to bring you a smart, efficient
          and economical transportation experience.{' '}
        </p>
      </div>
      <Button
        className={
          'w-fit text-lg font-semibold tracking-tight bg-orangeTheme hover:bg-orangeTheme/90 px-4 flex items-center space-x-2'
        }
        onClick={() => navigate(ROUTES.SERVICE)}
      >
        Try now
        <ArrowUpRight size={26} />
      </Button>
    </div>
  )
}

export default Slogan
