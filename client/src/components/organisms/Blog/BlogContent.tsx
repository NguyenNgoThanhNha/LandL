import { TBlog } from '@/types/BlogType.ts'
import AuthorBlog from '@/components/molecules/AuthorBlog.tsx'

interface BlogContentProps {
  blog: TBlog
}
const BlogContent = ({ blog }: BlogContentProps) => {
  return (
    <div className={'md:mx-40 sm:mx-4 flex flex-col gap-4'}>
      <div className={'bg-orangeTheme text-white text-4xl font-semibold text-start px-4 flex justify-center py-10'}>
        <p>{blog.title}</p>
      </div>
      <div className={'flex flex-col  items-center'}>
        <img src={blog.thumbnail} alt={'blog-image'} className={'w-full object-cover'} />
        <AuthorBlog name={blog.author} time={blog.postedAt} detail />
      </div>
      <div>{blog.content}</div>
    </div>
  )
}

export default BlogContent
