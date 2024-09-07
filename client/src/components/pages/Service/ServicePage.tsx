import SearchElement from '@/components/organisms/Service/SearchElement.tsx'
import ProcessHeader from '@/components/organisms/Service/ProcessHeader.tsx'
// import OrderCompleteDialog from '@/components/organisms/Service/OrderCompleteDialog.tsx'
// import FeedbackDialog from '@/components/organisms/Service/FeedbackDialog.tsx'
import MapCustom from '@/components/organisms/Map/MapCustom.tsx'

const ServicePage = () => {
  return <div className={'py-10'}>
    <ProcessHeader />
    <div className={'md:w-3/4 sm:w-full mx-auto'}>
      
      <SearchElement />
      {/*<PriceDialog price={230000} />*/}
      {/*<OrderCompleteDialog price={23000}/>*/}
      {/*<FeedbackDialog />*/}
      <MapCustom />
    </div>
  </div>
}

export default ServicePage
