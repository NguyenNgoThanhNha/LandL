export const processState = [
  {
    id: 1,
    title: 'Processing'
  },
  {
    id: 2,
    title: 'Paid'
  },
  {
    id: 3,
    title: 'In Route'
  },
  {
    id: 4,
    title: 'Received'
  },
  {
    id: 5,
    title: 'Delivered'
  },
  {
    id: 6,
    title: 'Completed'
  }
]

export enum processStateEnum {
  'Processing' = 1,
  'Paid' = 2,
  'InRoute' = 3,
  'Received' = 4,
  'Delivered' = 5,
  'Completed' = 6
}
export type ProcessStateEnumType = keyof typeof processStateEnum
