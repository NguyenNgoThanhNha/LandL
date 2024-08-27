import { z } from 'zod'

export const searchProductSchema = z.object({
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
  number_of_products: z.number({
    required_error: 'Number of products is required'
  }),
  type: z.string({
    required_error: 'Product Type is required'
  }),
  time: z.string({
    required_error: 'Time is required'
  })
})

export type searchProductType = z.infer<typeof searchProductSchema>