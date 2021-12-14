import { createContext } from 'react'

const ErrorContext = createContext({
  errorCount: 0,

  /**
   * Although it is possible to remove the following I like to keep them here
   * because they help anyone importing LoadingContext to understand what API (methods)
   * this particular context has available
   */
  showError: () => {},
  hideError: () => {},
})

export default ErrorContext
