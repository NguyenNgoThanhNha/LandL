import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow
} from '@/components/atoms/ui/table.tsx'
import { TRANSPORTATION_PRICES } from '@/contants/transportationPrice.ts'

const TransportationPriceTable = () => {
  return (
    <Table className={'border collapse'}>
      <TableCaption className={'font-semibold'}>TRUCK TRANSPORTATION PRICE LIST (UNIT: VND)</TableCaption>
      <TableHeader>
        <TableRow>
          <TableHead>Type</TableHead>
          <TableHead>First 4 KM</TableHead>
          <TableHead>5 - 15KM</TableHead>
          <TableHead>16 - 100KM</TableHead>
          <TableHead>100KM more</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {TRANSPORTATION_PRICES.map((item) => (
          <TableRow key={item.id}>
            <TableCell className='font-medium uppercase'>{item.type} tons</TableCell>
            <TableCell className={'px-4'}>{item.firstDistance}.000 VND</TableCell>
            <TableCell>{item.secondDistance}.000 VND/KM</TableCell>
            <TableCell>{item.thirdDistance}.000 VND/KM</TableCell>
            <TableCell>{item.fourthDistance}.000 VND/KM</TableCell>
          </TableRow>
        ))}
      </TableBody>
    </Table>
  )
}

export default TransportationPriceTable
