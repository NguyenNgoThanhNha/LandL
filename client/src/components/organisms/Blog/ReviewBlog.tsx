import { TBlog } from '@/types/BlogType.ts'
import { formatReview } from '@/utils/formatReview.ts'
import { Separator } from '@/components/atoms/ui/separator.tsx'
import ReviewLine from '@/components/molecules/ReviewLine.tsx'
import { REVIEW } from '@/contants/reviewContent.ts'

interface ReviewBlogProps {
  blog: TBlog
}
const ReviewBlog = ({ blog }: ReviewBlogProps) => {
  return (
    <div className={'md:mx-20 sm:mx-4'}>
      <p className={'text-lg font-semibold text-center py-4'}>Reviews</p>
      <div className={'flex gap-2 items-center py-4'}>
        <p className={'font-black text-4xl'}>{blog.ratingAverage}</p>
        <div>
          <p className={'font-bold'}>{formatReview(blog.ratingAverage)}</p>
          <p>{blog.numberOfReviews} reviewers</p>
        </div>
      </div>
      <Separator />
      <div className={'flex flex-col gap-4 py-4'}>
        <ReviewLine review={REVIEW} />
        <ReviewLine review={REVIEW} />
        <ReviewLine review={REVIEW} />
        <ReviewLine review={REVIEW} />
      </div>
    </div>
  )
}

export default ReviewBlog
