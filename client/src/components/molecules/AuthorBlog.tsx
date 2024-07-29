import { Clock, User } from 'lucide-react'
import { cn } from '@/utils/cn.ts'

interface AuthorBlogProps {
  name: string
  time: string
  detail?: boolean
}
const AuthorBlog = ({ name, time, detail }: AuthorBlogProps) => {
  return (
    <div
      className={cn(
        'flex transform -translate-y-1/2 font-medium',
        detail ? 'md:w-[600px] sm: w-[400px]' : ' w-[400px]'
      )}
    >
      <div className={' flex gap-2 bg-orange-400 w-64  py-4 justify-center'}>
        <User />
        <p className={'truncate'}>{name}</p>
      </div>
      <div className={' flex gap-2 bg-orangeTheme w-64  py-4 justify-center'}>
        <Clock />
        <p>{time}</p>
      </div>
    </div>
  )
}

export default AuthorBlog
