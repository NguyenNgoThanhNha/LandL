import Map, {
  AttributionControl,
  FullscreenControl,
  GeolocateControl,
  Layer,
  Marker,
  NavigationControl,
  ScaleControl,
  Source
} from 'react-map-gl'
import { useState } from 'react'
import { search } from '@/services/mapService.ts'

const MAP_API = import.meta.env.VITE_MAPBOX_URL || ''
const MAP_STYLE = import.meta.env.VITE_MAP_STYLE || ''
const MapCustom = () => {
  const [map, setMap] = useState(null)

  const handleMapLoad = (event: any) => {
    const mapInstance = event.target
    setMap(mapInstance)
  }
  // const [position, setPosition] = useState({
  //   longitude: 106.8136,
  //   latitude: 10.8566
  // })
  // const style = {
  //   padding: '10px',
  //   color: '#fff',
  //   cursor: 'pointer',
  //   background: '#1978c8',
  //   borderRadius: '6px'
  // }

  const routeGeoJSON = {
    type: 'Feature',
    geometry: {
      type: 'LineString',
      coordinates: [
        [106.8136, 10.8566],
        [106.8136, 11]
      ]
    }
  }
  return (
    <div className={'w-full h-full'}>
      <Map
        mapboxAccessToken={MAP_API}
        initialViewState={{
          longitude: 106.8136,
          latitude: 10.8566,
          zoom: 14
        }}
        style={{ width: 1200, height: 550, borderRadius: 10 }}
        mapStyle={MAP_STYLE}
        boxZoom={true}
        antialias={true}
        optimizeForTerrain={true}
        trackResize={true}
        attributionControl={false}
        onLoad={handleMapLoad}
      >
        {map && (
          <>
            <Source id='maine' type='geojson' data={routeGeoJSON} />
            <Layer
              id='maine'
              type='line'
              source='maine'
              layout={{
                'line-join': 'round',
                'line-cap': 'round'
              }}
              paint={{
                'line-color': '#ec3111',
                'line-width': 6
              }}
            />

            {/*<Marker*/}
            {/*  longitude={position.longitude}*/}
            {/*  latitude={position.latitude}*/}
            {/*  // onDragEnd={onDragEnd}*/}
            {/*> <div style={style}>Click me! ✨</div>*/}
            {/*</Marker>*/}
            <ScaleControl unit='metric' position='bottom-right' />
            <GeolocateControl
              positionOptions={{ enableHighAccuracy: true }}
              trackUserLocation={true}
              position={'bottom-right'}
            />
            <NavigationControl showCompass showZoom position='top-right' />
            <FullscreenControl />
          </>
        )}
      </Map>
    </div>
  )
}

export default MapCustom
