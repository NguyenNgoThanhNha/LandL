import {
  APIProvider,
  Map,
  AdvancedMarker,
  Pin,
  InfoWindow
} from '@vis.gl/react-google-maps'
import { mapAPI } from '@/contants/mapContanst.ts'

const MapCustom = () => {
  const position = { lat: 53.54, lng: 10 }
  return (
    <APIProvider apiKey={mapAPI.apiKey}>
      <div>
        <Map zoom={9} center={position}></Map>
      </div>
    </APIProvider>
  )
}

export default MapCustom