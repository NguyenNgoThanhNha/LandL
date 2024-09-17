import { post, ResponseProps } from '@/services/root.ts'
import { SearchProductWithDistanceType } from '@/schemas/productSchema.ts'

interface GetPriceProps {
  data: SearchProductWithDistanceType
}

export const getPrice = async ({ data }: GetPriceProps): Promise<ResponseProps> => {
  return await post('Product/Search', data)
}