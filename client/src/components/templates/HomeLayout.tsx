import { Outlet } from 'react-router-dom'
import Header from '@/components/organisms/Global/Header.tsx'
import Footer from '@/components/organisms/Global/Footer.tsx'
import Slogan from '@/components/organisms/Home/Slogan.tsx'

const HomeLayout = () => {
  return (
    <div>
      <div className={"bg-[url('/bg-home.png')] bg-cover bg-center w-full h-[700px]"}>
        <Header />
        <Slogan />
      </div>
      <Outlet />
      <Footer />
    </div>
  )
}

export default HomeLayout
