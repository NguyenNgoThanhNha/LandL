import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow
} from '@/components/atoms/ui/table.tsx'
import { TOrder } from '@/types/OrderType.ts'
import { cn } from '@/utils/cn.ts'
import { ChevronRight } from 'lucide-react'
import { useNavigate } from 'react-router-dom'
import { ROUTES } from '@/contants/routerEndpoint.ts'
import { formatCurrency } from '@/utils/formatCurrency.ts'
import { formatDate } from '@/utils/formatDate.ts'

interface TableOrderProps {
  data: TOrder[]
}

const TableOrder = ({ data }: TableOrderProps) => {
  const navigate = useNavigate()
  return (
    <Table>
      <TableCaption className={'font-medium text-lg'}>A list of your orders.</TableCaption>
      <TableHeader>
        <TableRow>
          <TableHead className='w-[200px]'>Order</TableHead>
          <TableHead>Status</TableHead>
          <TableHead>Driver</TableHead>
          <TableHead>Publish Date</TableHead>
          <TableHead className='text-right'>Cost</TableHead>
          <TableHead></TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {data && data.length > 0 ? (
          data.map((order, index) => (
            <TableRow key={index}>
              <TableCell className={'font-medium '}>{order.orderCode}</TableCell>
              <TableCell>{order.status}</TableCell>
              <TableCell className={cn(order.orderDriver?.fullName !== null && 'text-orangeTheme font-medium')}>
                <p> {order.orderDriver?.fullName ?? 'Waiting...'}</p>
              </TableCell>
              <TableCell>{formatDate(order.orderDate)}</TableCell>
              <TableCell className={'text-right'}>{formatCurrency(order.totalAmount)}</TableCell>
              <TableCell>
                <span onClick={() => navigate(`${ROUTES.ORDER_DETAIL}/${order.orderId}`)}>
                  <ChevronRight strokeWidth={1} className={'text-right font-thin cursor-pointer ml-auto'} />
                </span>
              </TableCell>
            </TableRow>
          ))
        ) : (
          <TableRow className={'flex text-center w-full mx-auto py-2 text-orangeTheme font-medium'}>
            You don't have any order
          </TableRow>
        )}
      </TableBody>
    </Table>
  )
}

export default TableOrder
