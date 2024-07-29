import BlogContent from '@/components/organisms/Blog/BlogContent.tsx'
import { BLOG } from '@/contants/blogContent.ts'
import RelatedBlog from '@/components/organisms/Blog/RelatedBlog.tsx'
import ReviewBlog from '@/components/organisms/Blog/ReviewBlog.tsx'
import SubscribeNewLetter from '@/components/organisms/Blog/SubscribeNewLetter.tsx'
import CommentLine from '@/components/molecules/CommentLine.tsx'

const BlogDetailPage = () => {
  return (
    <div className={'flex flex-col gap-6'}>
      <BlogContent blog={BLOG} />
      <RelatedBlog category={BLOG.category} />
      <SubscribeNewLetter />
      <CommentLine />
      <ReviewBlog blog={BLOG} />
    </div>
  )
}

export default BlogDetailPage
