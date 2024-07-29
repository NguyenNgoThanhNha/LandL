import AuthorBlog from '@/components/molecules/AuthorBlog.tsx'
import { SquareArrowUpRight } from 'lucide-react'
import { Button } from '@/components/atoms/ui/button.tsx'
import { TBlog } from '@/types/BlogType.ts'

interface BlogCoverProps {
  blog: TBlog
}
const BlogCover = ({ blog }: BlogCoverProps) => {
  return (
    <div className={'w-[550px] p-2'}>
      <div className={'flex flex-col justify-center items-center'}>
        <img src={'/blog-1.png'} alt='blog-1' className={'object-cover w-full h-[300px]  '} />
        <AuthorBlog name={blog.author} time={blog.postedAt} />
      </div>
      <div>
        <p className={'line-clamp-2 font-medium text-2xl'}>{blog.title}</p>
        <p className={'line-clamp-3'}> {blog.content}</p>
      </div>
      <Button className={'flex gap-2 rounded-none bg-white hover:bg-slate-50 w-fit text-black hover:scale-105'}>
        <span className={'font-semibold'}>Read more</span>
        <SquareArrowUpRight strokeWidth={1} />
      </Button>
    </div>
  )
}

export default BlogCover
