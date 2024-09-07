import {
  APIProvider,
  Map,
  AdvancedMarker,
  Pin,
} from '@vis.gl/react-google-maps'
import { mapAPI } from '@/contants/mapContanst.ts'

const MapCustom = () => {
  const position = { lat: 53.54, lng: 10 }
  return (
    <APIProvider apiKey={mapAPI.apiKey}>
      <div className={'h-screen w-full'}>
        <Map zoom={9} center={position}
             mapId={mapAPI.mapId}>
          <AdvancedMarker position={position}>
            <Pin background={'grey'} borderColor={'green'} glyphColor={'purple'} />
          </AdvancedMarker>
        </Map>
      </div>
    </APIProvider>
  )
}

export default MapCustom