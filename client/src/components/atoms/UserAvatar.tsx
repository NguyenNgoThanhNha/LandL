import { Avatar, AvatarFallback, AvatarImage } from '@/components/atoms/ui/avatar.tsx'

interface AvatarProps {
  avatar: string
  classContent?: string
}
const UserAvatar = ({ avatar, classContent }: AvatarProps) => {
  return (
    <div>
      <Avatar>
        <AvatarImage src={avatar} className={classContent} />
        <AvatarFallback>CN</AvatarFallback>
      </Avatar>
    </div>
  )
}

export default UserAvatar
