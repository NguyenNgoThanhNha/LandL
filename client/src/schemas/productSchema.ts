import { z } from 'zod'

export const SearchProductSchema = z.object({
  from: z.string({
    required_error: 'Address is required'
  }),
  to: z.string({
    required_error: 'Address is required'
  }),
  length: z.number({
    required_error: 'Length is required'
  }),
  width: z.number({
    required_error: 'Width is required'
  }),
  height: z.number({
    required_error: 'Height is required'
  }),
  weight: z.number({
    required_error: 'Height is required'
  }),
  type: z.string({
    required_error: 'Product Type is required'
  }),
  date: z.string({
    required_error: 'Time is required'
  }),
})

export type SearchProductType = z.infer<typeof SearchProductSchema>
export type SearchProductWithDistanceType = z.infer<typeof SearchProductSchema> & { distance: number }