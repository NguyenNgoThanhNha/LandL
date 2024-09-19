import { z } from 'zod'

export const SearchProductSchema = z.object({
  from: z
    .string({
      required_error: 'Address is required'
    })
    .min(1, 'Address is required'),
  to: z
    .string({
      required_error: 'Address is required'
    })
    .min(1, 'Address is required'),
  length: z
    .string({
      required_error: 'Length is required'
    })
    .min(1, 'Length is required'),
  width: z
    .string({
      required_error: 'Width is required'
    })
    .min(1, 'Width is required'),
  height: z
    .string({
      required_error: 'Height is required'
    })
    .min(1, 'Address is required'),
  weight: z
    .string({
      required_error: 'Weight is required'
    })
    .min(1, 'Weight is required'),
  type: z
    .string({
      required_error: 'Product Type is required'
    })
    .min(1, 'Address is required'),
  time: z.date({
    required_error: 'Product Type is required'
  })
})

export type SearchProductType = z.infer<typeof SearchProductSchema>
export type SearchProductWithDistanceType = {
  distance: number
  from: string
  to: string
  length: number
  width: number
  height: number
  weight: number
  type: string
  time: Date
}

export type ConfirmProductType = {
  distance: number
  from: string
  to: string
  length: number
  width: number
  height: number
  weight: number
  type: string
  pickupTime: Date
  longFrom: string
  latFrom: string
  longTo: string
  latTo: string
  email: string
  vehicleTypeId: string
  totalAmount: number
}
