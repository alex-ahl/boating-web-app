import React, { useState } from 'react'
import ErrorContext from '../context/error.context'

const ErrorProvider = ({ children }) => {
  const showError = () => {
    toggleError(prevState => {
      return {
        ...prevState,
        errorCount: prevState.errorCount + 1,
      }
    })
  }

  const hideError = () => {
    toggleError(prevState => {
      return {
        ...prevState,
        errorCount: prevState.errorCount > 0 ? prevState.errorCount - 1 : 0,
      }
    })
  }

  const errorState = {
    errorCount: 0,
    showError,
    hideError,
  }

  const [error, toggleError] = useState(errorState)

  return <ErrorContext.Provider value={error}>{children}</ErrorContext.Provider>
}

export default ErrorProvider
