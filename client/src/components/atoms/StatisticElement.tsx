import { ReactNode } from 'react'
import { Plus } from 'lucide-react'

interface StatisticElementProps {
  content: string
  icon: ReactNode
  data: number
  isMore: boolean
}
const StatisticElement = ({ content, icon, data, isMore }: StatisticElementProps) => {
  return (
    <div className={'flex flex-col gap-2'}>
      <div className={'flex gap-2 items-center justify-center'}>
        <span className={'text-orangeTheme'}>{icon}</span>
        <div className={'text-4xl font-black flex'}>
          {data}
          {isMore && (
            <span className={'transform -translate-y-2 '}>
              <Plus size={20} className={'font-black'} />
            </span>
          )}
        </div>
      </div>
      <p className={'uppercase text-lg tracking-tight font-semibold'}>{content}</p>
    </div>
  )
}

export default StatisticElement
