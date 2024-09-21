import ProcessHeader from '@/components/organisms/MyOrder/ProcessHeader.tsx'
import WaitingConfirm from '@/components/organisms/MyOrder/WaitingConfirm.tsx'
import TruckInformation from '@/components/organisms/MyOrder/TruckInformation.tsx'
import { DeliveryProvider, useDelivery } from '@/context/deliveryContext.tsx'
import { useNavigate, useParams } from 'react-router-dom'
import { useEffect, useState } from 'react'
import Loading from '@/components/templates/Loading.tsx'
import { getOrderDetailByOrderId } from '@/services/deliveryService.ts'
import toast from 'react-hot-toast'
import { ROUTES } from '@/contants/routerEndpoint.ts'
import { processStateEnum, ProcessStateEnumType } from '@/contants/processState.ts'
import { TOrderDetail } from '@/types/OrderDetailType.ts'

const OrderDetailPage = () => {
  const [loading, setLoading] = useState<boolean>(false)
  const { id } = useParams()
  const navigate = useNavigate()
  const { status, setStatus } = useDelivery()
  const getInfo = async () => {
    if (id === '' || id === undefined) {
      toast.loading('Something went wrong. Please try again.')
      navigate(ROUTES.MY_ORDER)
      return
    }
    setLoading(true)
    const response = await getOrderDetailByOrderId({ id })

    setLoading(false)
    if (response.success) {
      const data: TOrderDetail = response?.result?.data[0]
      const currentStatus = data?.status as ProcessStateEnumType
      setStatus(processStateEnum[currentStatus])
    } else {
      toast.error(response?.result?.message as string)
    }
  }
  useEffect(() => {
    getInfo()
  }, [id])
  return (
    <DeliveryProvider>
      {loading && <Loading />}
      <div>
        <ProcessHeader />
        {status === 1 && <WaitingConfirm />}
        {status === 3 && <TruckInformation />}
        {/*<MapCustom />*/}
      </div>
    </DeliveryProvider>
  )
}

export default OrderDetailPage
