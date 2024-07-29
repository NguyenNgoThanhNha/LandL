import { Outlet } from 'react-router-dom'
import Header from '@/components/organisms/Global/Header.tsx'
import Footer from '@/components/organisms/Global/Footer.tsx'

const MainLayout = () => {
  return (
    <div className='min-h-screen flex flex-col'>
      <Header classContent='bg-darkTheme' />
      <div className='flex-1'>
        <Outlet />
      </div>
      <Footer />
    </div>
  )
}

export default MainLayout
