import React, { useReducer } from 'react'
import AuthContext from '../context/auth.context'

const reducer = (state, action) => {
  switch (action.type) {
    case 'LOGIN':
      localStorage.setItem('user', JSON.stringify(action.payload.data.user.email))
      localStorage.setItem('token', JSON.stringify(action.payload.data.token))

      return {
        ...state,
        isAuthenticated: true,
        user: action.payload.data.user.email,
        token: action.payload.data.token,
        waitingResolve: false,
      }
    case 'LOGOUT':
      localStorage.setItem('user', null)
      localStorage.setItem('token', null)

      return {
        ...state,
        isAuthenticated: false,
        user: null,
        waitingToResolve: false,
      }
    case 'INITIALIZE':
      return {
        ...state,
        isAuthenticated: true,
        waitingToResolve: false,
      }
    default:
      return state
  }
}

const AuthProvider = ({ children }) => {
  const [state, dispatch] = useReducer(reducer, null)

  return (
    <AuthContext.Provider
      value={{
        state,
        dispatch,
      }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export default AuthProvider
