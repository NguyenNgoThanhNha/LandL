import { formatReview } from '@/utils/formatReview.ts'

interface Props {
  name: string
  rating: number
  numberOfReviews: number
}

const DriverFeedback = ({ name, rating, numberOfReviews }: Props) => {
  return (
    <div className={'flex flex-col text-white ml-4'}>
      <p className={'text-sm'}>{name}</p>
      <div className={'flex gap-1 justify-start items-center'}>
        <span className={'font-black text-[50px] tracking-wide'}>{rating}</span>
        <div className={'flex flex-col'}>
          <p className={'font-normal'}>{formatReview(rating)}</p>
          <span className={'text-sm font-light'}>{numberOfReviews} verified reviews</span>
        </div>
      </div>
    </div>
  )
}

export default DriverFeedback
