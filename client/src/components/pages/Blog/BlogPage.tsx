import BlogCover from '@/components/organisms/Blog/BlogCover.tsx'
import SubscribeNewLetter from '@/components/organisms/Blog/SubscribeNewLetter.tsx'
import { BLOG } from '@/contants/blogContent.ts'

const BlogPage = () => {
  return (
    <div className={'mt-6'}>
      <div>
        <p className={'font-semibold text-4xl px-20'}>Latest posts</p>
      </div>
      <div className={'flex flex-wrap justify-center md:gap-20  sm:gap-8 py-10'}>
        <BlogCover blog={BLOG} />
        <BlogCover blog={BLOG} />
      </div>
      <SubscribeNewLetter />
    </div>
  )
}

export default BlogPage
