import { TUser } from '@/types/UserType.ts'

export type TOrder = {
  orderId: number
  orderCode: number
  totalAmount: number
  orderCount: number
  status: string
  driverId?: number
  note?: string
  orderDate: string
  orderDriver?: TUser
}
