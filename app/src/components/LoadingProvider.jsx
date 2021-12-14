import React, { useState, useEffect } from 'react'
import LoadingContext from '../context/loading.context'

const LoadingProvider = ({ children }) => {
  const [showSpinner, setShowSpinner] = useState(false)
  const [spinnerWithTimeout, setSpinnerWithTimeout] = useState(false)

  useEffect(() => {
    if (spinnerWithTimeout) {
      const timer = setTimeout(() => setShowSpinner(true), 750)
      return () => clearTimeout(timer)
    } else {
      setShowSpinner(false)
    }
  }, [spinnerWithTimeout])

  return <LoadingContext.Provider value={{ showSpinner, setSpinnerWithTimeout }}>{children}</LoadingContext.Provider>
}

export default LoadingProvider
