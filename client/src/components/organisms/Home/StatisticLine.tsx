import { STATISTICS } from '@/contants/statistic.tsx'
import StatisticElement from '@/components/atoms/StatisticElement.tsx'

const StatisticLine = () => {
  return (
    <div className={'flex flex-wrap gap-10 w-full justify-center py-10'}>
      {STATISTICS.map((item) => (
        <StatisticElement content={item.content} icon={item.icon} data={item.data} isMore={item.isMore} key={item.id} />
      ))}
    </div>
  )
}

export default StatisticLine
