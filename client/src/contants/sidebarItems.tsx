import { StoreIcon, Users2Icon, WatchIcon } from 'lucide-react'

const navAdmin = [
  // {
  //     id: 1,
  //     title: "Home",
  //     path: "/home",
  //     icon:
  // },
  {
    id: 2,
    title: 'Watch Management',
    path: '/watch-dashboard',
    icon: <WatchIcon />
  },
  {
    id: 3,
    title: 'Brand Management',
    path: '/brand-dashboard',
    icon: <StoreIcon />
  },
  {
    id: 4,
    title: 'Member Management',
    path: '/member-dashboard',
    icon: <Users2Icon />
  }
]

export default navAdmin
