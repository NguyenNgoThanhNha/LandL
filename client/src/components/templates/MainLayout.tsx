import { Outlet } from 'react-router-dom'
import Header from '@/components/organisms/Global/Header.tsx'
import Footer from '@/components/organisms/Global/Footer.tsx'

const MainLayout = () => {
  return (
    <div>
      <Header classContent={'bg-darkTheme'} />
      <Outlet />
      <Footer />
    </div>
  )
}

export default MainLayout
