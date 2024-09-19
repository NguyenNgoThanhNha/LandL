import { post, get, ResponseProps } from '@/services/root.ts'
import { ConfirmProductType, SearchProductWithDistanceType } from '@/schemas/productSchema.ts'

interface GetPriceProps {
  data: SearchProductWithDistanceType
}

export const getPrice = async ({ data }: GetPriceProps): Promise<ResponseProps> => {
  return await post('Product/Search', data)
}

interface CreateOrderProps {
  data: ConfirmProductType
  listCost: any
  //back to be store db
}

export const createOrder = async ({ data, listCost }: CreateOrderProps): Promise<ResponseProps> => {
  return await post('Order/Create_Order', { ...data, ...listCost })
}

export const getAllOrderByUserId = async (): Promise<ResponseProps> => {
  return await get('Order/GetAll')
}

interface GetOrderByOrderIdProps {
  id: string
}

export const getOrderByOrderId = async ({ id }: GetOrderByOrderIdProps): Promise<ResponseProps> => {
  return await get(`Order/GetOrderByOrderId?orderId=${id}`)
}

interface GetOrderDetailByOrderIdProps {
  id: string
}

export const getOrderDetailByOrderId = async ({ id }: GetOrderDetailByOrderIdProps): Promise<ResponseProps> => {
  return await get(`Order/GetOrderDetailByOrderId?orderId=${id}`)
}


