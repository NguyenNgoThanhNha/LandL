import TransportationPriceTable from '@/components/organisms/Cost/TransportationPriceTable.tsx'

const CostPage = () => {
  return (
    <div className='flex flex-col items-center gap-4'>
      <div className='w-full'>
        <img src='/cost-1.png' alt='cost-1' className='w-full object-cover' />
      </div>
      <div className='flex w-1/2'>
        <TransportationPriceTable />
      </div>
    </div>
  )
}

export default CostPage
