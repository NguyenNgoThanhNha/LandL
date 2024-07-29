import UserAvatar from '@/components/atoms/UserAvatar.tsx'
import { TReview } from '@/types/ReviewType.ts'
import { formatReview } from '@/utils/formatReview.ts'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import { formatDate } from '@/utils/formatDate.ts'

interface ReviewLineProps {
  review: TReview
}
const ReviewLine = ({ review }: ReviewLineProps) => {
  return (
    <div className={'flex flex-col gap-2'}>
      <div className={'flex gap-4 justify-center'}>
        <div>
          <UserAvatar avatar={review.avatar} />
        </div>
        <div className={'flex flex-col '}>
          <div className={'flex gap-2'}>
            <span className={'font-semibold'}>{formatReview(review.rating)}</span>
            <Separator orientation={'vertical'} />
            <span>{review.author}</span>
            <span className={'ml-auto font-medium text-sm'}>{formatDate(review.reviewedAt)}</span>
          </div>
          <p>{review.content}</p>
        </div>
      </div>
      <Separator />
    </div>
  )
}

export default ReviewLine
