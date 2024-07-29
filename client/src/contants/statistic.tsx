import { CalendarClock, FolderKanban, GlobeLock, Users } from 'lucide-react'

export const STATISTICS = [
  {
    id: 1,
    data: 2007,
    content: 'year of establishment',
    icon: <CalendarClock size={28} />,
    isMore: false
  },
  {
    id: 2,
    data: 1500,
    content: 'team members',
    icon: <Users size={28} />,
    isMore: true
  },
  {
    id: 3,
    data: 45,
    content: 'successfully project',
    icon: <FolderKanban size={28} />,
    isMore: true
  },
  {
    id: 4,
    data: 157,
    content: 'Global partners',
    icon: <GlobeLock size={28} />,
    isMore: true
  }
]
