import FrequentAskedQuestion from '@/components/organisms/Home/FrequentAskedQuestion.tsx'
import PromoteCodeForm from '@/components/organisms/Home/PromoteCodeForm.tsx'
import UserAvatar from '@/components/atoms/UserAvatar.tsx'
import StatisticLine from '@/components/organisms/Home/StatisticLine.tsx'

const HomePage = () => {
  return (
    <div className={'flex flex-col gap-10 items-center justify-center'}>
      <FrequentAskedQuestion />
      <PromoteCodeForm />
      <UserAvatar avatar={'https://github.com/shadcn.png'} />
      <StatisticLine />
    </div>
  )
}

export default HomePage
