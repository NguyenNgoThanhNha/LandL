import { createBrowserRouter, createRoutesFromElements, Route } from 'react-router-dom'
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

const router = createBrowserRouter(
  createRoutesFromElements([
    <Route path={ROUTES.SIGN_UP} element={<SignupPage />} />,
    <Route path={ROUTES.LOGIN} element={<LoginPage />} />,
    <Route path={ROUTES.FORGOT_PASSWORD} element={<ForgotPasswordPage />} />,
    <Route path={ROUTES.VERIFY_CODE} element={<VerifyCodePage />} />,
    <Route path={ROUTES.SET_PASSWORD} element={<SetPasswordPage />} />,
    <Route path={ROUTES.ROOT} element={<HomeLayout />}>
      <Route path={ROUTES.HOME} element={<HomePage />} />
    </Route>,
    <Route path={ROUTES.ROOT} element={<MainLayout />}>
      <Route path={ROUTES.SERVICE} element={<ServicePage />} />
    </Route>
  ])
)
export default router
