import { TOrder } from '@/types/OrderType.ts'
import { useEffect, useState } from 'react'
import { getAllOrderByUserId } from '@/services/deliveryService.ts'
import toast from 'react-hot-toast'
import Loading from '@/components/templates/Loading.tsx'
import TableOrder from '@/components/organisms/OrderDetail/TableOrder.tsx'

const MyOrderPage = () => {
  const [loading, setLoading] = useState<boolean>(false)
  const [orderList, setOrderList] = useState<TOrder[]>([])
  const getOrder = async () => {
    setLoading(true)
    const response = await getAllOrderByUserId()
    setLoading(false)
    if (response.success) {
      setOrderList(response?.result?.data)
    } else {
      toast.error(response?.result?.message as string)
    }
  }
  useEffect(() => {
    getOrder()
  }, [])
  return loading ? (
    <Loading />
  ) : (
    <div className={'items-center justify-center flex mt-20 w-2/3 mx-auto '}>
      <TableOrder data={orderList} />
    </div>
  )
}

export default MyOrderPage
