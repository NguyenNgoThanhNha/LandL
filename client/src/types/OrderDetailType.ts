import { TPackage } from '@/types/PackageType.ts'
import { TOrder } from '@/types/OrderType.ts'
import { TDeliveryInfoDetail } from '@/types/DeliveryInfoDetailType.ts'
import { TTruck } from '@/types/TruckType.ts'

export type TOrderDetail = {
  deliveryInfoDetail?: TDeliveryInfoDetail
  deliveryInfoId: number
  endDate: string
  orderDetailId: number
  orderId: number
  orderInfo?: TOrder
  paymentMethod: string
  productId: number
  productInfo?: TPackage
  quantity: number
  senderId: number
  startDate: string
  status: string
  totalPrice: number
  truckId: number
  truckInfo?: TTruck
  unitPrice?: number
}
