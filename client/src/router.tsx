import { createBrowserRouter, createRoutesFromElements, Navigate, Route } from 'react-router-dom'
import { ROUTES } from '@/contants/routerEndpoint.ts'
import LoginPage from '@/components/pages/Login/LoginPage.tsx'
import SignupPage from '@/components/pages/Signup/SignupPage.tsx'
import ForgotPasswordPage from '@/components/pages/ForgotPassword/ForgotPasswordPage.tsx'
import VerifyCodePage from '@/components/pages/VerifyCode/VerifyCodePage.tsx'
import SetPasswordPage from '@/components/pages/SetPassword/SetPasswordPage.tsx'
import HomeLayout from '@/components/templates/HomeLayout.tsx'
import HomePage from '@/components/pages/Home/HomePage.tsx'
import MainLayout from '@/components/templates/MainLayout.tsx'
import ServicePage from '@/components/pages/Service/ServicePage.tsx'
import CostPage from '@/components/pages/Cost/CostPage.tsx'
import BlogPage from '@/components/pages/Blog/BlogPage.tsx'
import AboutUsPage from '@/components/pages/AboutUs/AboutUsPage.tsx'
import ProfilePage from '@/components/pages/Profile/ProfilePage.tsx'
import BlogDetailPage from '@/components/pages/Blog/BlogDetailPage.tsx'
import PaymentPage from './components/pages/PayOsPay/PaymentPage'
import AdminLayout from '@/components/templates/AdminLayout.tsx'

const router = createBrowserRouter(
  createRoutesFromElements([
    <Route path={ROUTES.PAY_OS} element={<PaymentPage />} />,
    <Route path={ROUTES.SIGN_UP} element={<SignupPage />} />,
    <Route path={ROUTES.LOGIN} element={<LoginPage />} />,
    <Route path={ROUTES.FORGOT_PASSWORD} element={<ForgotPasswordPage />} />,
    <Route path={ROUTES.VERIFY_CODE} element={<VerifyCodePage />} />,
    <Route path={ROUTES.SET_PASSWORD} element={<SetPasswordPage />} />,
    <Route path={ROUTES.ROOT} element={<HomeLayout />}>
      <Route index element={<Navigate to={ROUTES.HOME} />} />,
      <Route path={ROUTES.HOME} element={<HomePage />} />
    </Route>,
    <Route path={ROUTES.ROOT} element={<MainLayout />}>
      <Route path={ROUTES.CREATE_ORDER} element={<ServicePage />} />,
      <Route path={ROUTES.COST} element={<CostPage />} />,
      <Route path={ROUTES.BLOG} element={<BlogPage />} />,
      <Route path={ROUTES.ABOUT_US} element={<AboutUsPage />} />,
      <Route path={ROUTES.PROFILE} element={<ProfilePage />} />,
      <Route path={ROUTES.BLOG_DETAIL} element={<BlogDetailPage />} />,
    </Route>,
    <Route path={ROUTES.DASH_BOARD} element={<AdminLayout />}></Route>
  
  ])
)
export default router
