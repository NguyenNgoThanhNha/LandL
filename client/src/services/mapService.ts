import axios from 'axios'
import { LngLat } from 'mapbox-gl'

const GOONG_API = import.meta.env.VITE_GOONG_API_KEY || ''
const BASE_SEARCH = import.meta.env.VITE_GOONG_URL_SEARCH || ''
const BASE_DIRECTION = import.meta.env.VITE_GOONG_URL_DIRECTION || ''
const BASE_GEOCODING = import.meta.env.VITE_GOONG_URL_GEOCODING || ''
const BASE_PLACE_DETAIL = import.meta.env.VITE_GOONG_URL_PLACE_DETAIL || ''

// export type LngLat = { lng: number, lat: number }
export const searchAddress = async ({ input }: { input: string }) => {
  try {
    const response = await axios.get(`${BASE_SEARCH}?api_key=${GOONG_API}&input=${input}`)
    console.log(input)
    return response.data
  } catch (e) {
    throw e
  }
}
export const getLocationByAddress = async ({ place }: { place: string }) => {
  try {
    const response = await axios.get(`${BASE_PLACE_DETAIL}?api_key=${GOONG_API}&address=${place}`)
    return response.data
  } catch (e) {
    throw e
  }
}

export const getLocationByPlaceId = async ({ placeId }: { placeId: string }) => {
  try {
    const response = await axios.get(`${BASE_GEOCODING}?api_key=${GOONG_API}&place_id=${placeId}`)
    return response.data
  } catch (e) {
    throw e
  }
}

export const getDirection = async ({ source, destination }: { source: LngLat; destination: LngLat }) => {
  try {
    const response = await axios.get(
      `${BASE_DIRECTION}?api_key=${GOONG_API}&origin=${source?.lat},${source.lng}&destination=${destination?.lat},${destination?.lng}`
    )
    return response.data
  } catch (e) {
    throw e
  }
}
