import { Button } from '@/components/atoms/ui/button.tsx'
import BlogCover from '@/components/organisms/Blog/BlogCover.tsx'
import { BLOG } from '@/contants/blogContent.ts'

interface RelatedBlogProps {
  category: string
}
const RelatedBlog = ({ category }: RelatedBlogProps) => {
  console.log(category)
  return (
    <div className={' md:mx-36 sm:mx-4'}>
      <div className={'flex justify-between py-6'}>
        <p className={'text-3xl font-semibold'}>Related Posts</p>
        <Button className={'rounded-none bg-orangeTheme hover:bg-orangeTheme/95 px-3'}>More Posts</Button>
      </div>
      <div className={'flex flex-wrap gap-8'}>
        <BlogCover blog={BLOG} />
        <BlogCover blog={BLOG} />
      </div>
    </div>
  )
}

export default RelatedBlog
