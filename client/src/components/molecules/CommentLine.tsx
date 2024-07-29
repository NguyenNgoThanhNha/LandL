import { Input } from '@/components/atoms/ui/input.tsx'
import { Button } from '@/components/atoms/ui/button.tsx'

const CommentLine = () => {
  return (
    <div className={'flex flex-col md:mx-20 sm:mx-4 '}>
      <p className={'bg-black text-white w-fit mr-auto px-2 py-1 font-medium text-sm'}>Comment</p>
      <Input placeholder={'Your comment here'} className={'w-full rounded-none'} />
      <Button className={'rounded-none bg-orangeTheme text-white hover:bg-orangeTheme/95 w-fit ml-auto'}>Send</Button>
    </div>
  )
}

export default CommentLine
