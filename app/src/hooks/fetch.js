import { get } from '../utils/rest'
import { useState, useEffect, useReducer, useContext } from 'react'
import LoadingContext from '../context/loading.context'

const dataFetchReducer = (state, action) => {
  switch (action.type) {
    case 'FETCH_INIT':
      return { ...state, isLoading: true, isError: false }
    case 'FETCH_SUCCESS':
      return {
        ...state,
        isLoading: false,
        isError: false,
        data: action.payload,
      }
    case 'FETCH_FAILURE':
      return {
        ...state,
        isLoading: false,
        isError: true,
      }
    default:
      throw new Error()
  }
}

const useDataApi = () => {
  const { hideLoading } = useContext(LoadingContext)

  const [url, setUrl] = useState()

  const [state, dispatch] = useReducer(dataFetchReducer, {
    isLoading: false,
    isError: false,
  })

  useEffect(() => {
    if (url === undefined) return

    let didCancel = false

    dispatch({ type: 'FETCH_INIT' })

    get(url)
      .then(res => {
        if (!didCancel) return res.json()
      })
      .then(res => {
        if (!didCancel) {
          dispatch({ type: 'FETCH_SUCCESS', payload: res.data })
        }
      })
      .catch(error => {
        if (!didCancel) {
          dispatch({ type: 'FETCH_FAILURE' })
        }
      })
      .finally(() => hideLoading(true))

    return () => {
      didCancel = true
    }
  }, [url])

  return [state, setUrl]
}

export { useDataApi }
