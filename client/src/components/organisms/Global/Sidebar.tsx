import { Maximize2Icon, Minimize2Icon } from 'lucide-react'

import { createContext, ReactNode, useContext, useState } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { cn } from '@/utils/cn.ts'
import navAdmin from '@/contants/sidebarItems.tsx'

const SidebarContext = createContext<{ expanded: boolean; setActiveItem: (item: string) => void } | null>(null)
const Sidebar = () => {
  // const { auth, setAuth } = useAuth()
  const activePath = useLocation()
  const [activeItem, setActiveItem] = useState<string>(activePath.pathname)
  const [expanded, setExpanded] = useState<boolean>(true)
  return (
    <aside className={'h-screen'}>
      <div className={'h-full flex flex-col bg-white border-r shadow-sm'}>
        <div className={'p-2 flex justify-between items-center'}>
          <button
            className={cn(
              'p-2 rounded-lg bg-gray-50 hover:bg-gray-100 text-blue-600 font-black overflow-hidden  transition-all',
              expanded ? 'w-40' : 'hidden'
            )}
          >
            IMA WATCH
          </button>
          <button onClick={() => setExpanded((curr) => !curr)} className={'flex justify-center items-center'}>
            {expanded ? (
              <Minimize2Icon size={20} />
            ) : (
              <span className={'py-2 px-3'}>
                <Maximize2Icon size={20} />
              </span>
            )}
          </button>
        </div>

        <SidebarContext.Provider value={{ expanded, setActiveItem }}>
          <ul className={'flex-1  px-3'}>
            {navAdmin.map((item) => (
              <SidebarItem
                key={item.id}
                title={item.title}
                path={item.path}
                icon={item.icon}
                active={activeItem === item.path}
              />
            ))}
          </ul>
        </SidebarContext.Provider>
        <div
          onClick={() => {
            localStorage.removeItem('accessToken')
            // setAuth({ user: null, isAdmin: null })
          }}
          className={cn(
            'font-semibold leading-4 overflow-hidden  transition-all cursor-pointer',
            expanded ? 'w-53 ml-3' : 'w-0'
          )}
        >
          Logout
        </div>
        <div className={'flex justify-start items-center py-4 px-4'}>
          {/*<img src={GenerateImage(auth?.user ?? "DRAFT")} alt='avatar' className={"w-10 h-10 rounded-md "} />*/}
          <h4 className={cn('font-semibold leading-4 overflow-hidden  transition-all', expanded ? 'w-53 ml-3' : 'w-0')}>
            {/*{auth.user}*/}
          </h4>
        </div>
      </div>
    </aside>
  )
}
const SidebarItem = ({
  title,
  active,
  icon,
  path
}: {
  title: string
  active: boolean
  icon: ReactNode
  path: string
}) => {
  const { expanded, setActiveItem } = useContext(SidebarContext)!
  return (
    <Link to={path}>
      <li
        className={cn(
          'relative flex items-center py-2 px-3 my-1 font-medium rounded-md cursor-pointer transition-colors group',
          active
            ? 'bg-gradient-to-tr from-indigo-200 to-indigo-100 text-indigo-800 '
            : 'hover:border-indigo-50 text-gray-600'
        )}
        onClick={() => setActiveItem(path)}
      >
        {icon}
        <span className={cn('overflow-hidden  transition-all', expanded ? 'w-52 ml-3 ' : 'hidden')}>{title}</span>
        {!expanded && (
          <div
            className={
              'absolute left-full rounded-md px-2 py-1 ml-6 bg-indigo-100 text-indigo-800 text-sm invisible opacity-20 -translate-x-3 transition-all group-hover:visible group-hover:opacity-100 group-hover:translate-x-0'
            }
          >
            {title}
          </div>
        )}
      </li>
    </Link>
  )
}
export default Sidebar
