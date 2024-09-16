// import { errorNotify } from "@/components/global/atoms/notify"
import axios, { AxiosError, AxiosResponse } from 'axios'

const api = axios.create({
  baseURL: import.meta.env.VITE_ORIGINAL_URL,
  headers: {
    'Content-Type': 'application/json'
  }
})
api.interceptors.request.use((config) => {
  const accessToken = ''
  if (accessToken) {
    config.headers.set('Authorization', `Bearer ${accessToken}`)
  }
  return config
})

interface errorDataProps {
  success: boolean
  message: string
}

const handleApiError = (error: AxiosError) => {
  const { response } = error
  const dataError = response?.data as errorDataProps
  console.log(dataError)
  // errorNotify(dataError.message)
  throw error
}

export interface ResponseProps<T = any> {
  success?: boolean
  result?: {
    message?: string
    data?: T,
    token?: string
  }
}

export const get = async <T>(url: string): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await api.get<T>(url)
    return response.data
  } catch (error: unknown) {
    if (error instanceof AxiosError) {
      handleApiError(error)
    }
    throw error
  }
}

export const post = async <T>(url: string, data?: unknown): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await api.post<T>(url, data)
    console.log(response)
    return response.data
  } catch (error) {
    if (error instanceof AxiosError) {
      handleApiError(error)
    }
    throw error
  }
}

export const put = async <T>(url: string, data: unknown): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await api.put<T>(url, data)
    return response.data
  } catch (error: unknown) {
    if (error instanceof AxiosError) {
      handleApiError(error)
    }
    throw error
  }
}

export const patch = async <T>(url: string, data: unknown): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await api.patch<T>(url, data)
    return response.data
  } catch (error: unknown) {
    if (error instanceof AxiosError) {
      handleApiError(error)
    }
    throw error
  }
}

export const del = async <T>(url: string): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await api.delete<T>(url)
    return response.data
  } catch (error: unknown) {
    if (error instanceof AxiosError) {
      handleApiError(error)
    }
    throw error
  }
}


