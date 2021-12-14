import React, { useContext, useState, useEffect } from 'react'
import { useHistory } from 'react-router-dom'
import AuthContext from '../../context/auth.context'
import Header from '../Header/Header'
import './Login.scss'
import { Spinner } from 'react-bootstrap'

export const Login = props => {
  const { state, dispatch } = useContext(AuthContext)
  const history = useHistory()

  const initialState = {
    email: '',
    password: '',
    isSubmitting: false,
    errorMessage: null,
  }

  useEffect(() => {
    if (state !== null && state.isAuthenticated) {
      if (history.location.state.from) {
        const pathname = history.location.state.from.pathname

        history.push({
          pathname: pathname,
          state: { prevPath: history.location.pathname },
        })
      } else {
        history.push({
          pathname: '/',
          state: { prevPath: history.location.pathname },
        })
      }
    }
  }, [state, history])

  const [data, setData] = useState(initialState)

  const handleInputChange = event => {
    setData({
      ...data,
      [event.target.name]: event.target.value,
    })
  }

  const handleFormSubmit = event => {
    event.preventDefault()

    setData({
      ...data,
      isSubmitting: true,
      errorMessage: null,
    })

    fetch(`${process.env.REACT_APP_BASE_API_URL}/_/auth/authenticate`, {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email: data.email,
        password: data.password,
      }),
    })
      .then(res => {
        if (res.ok) {
          return res.json()
        }
        throw res
      })
      .then(resJson => {
        dispatch({
          type: 'LOGIN',
          payload: resJson,
        })
        props.content.setLoaded(false)
      })
      .catch(error => {
        setData({
          ...data,
          isSubmitting: false,
          errorMessage: 'Fel användarnamn eller lösenord',
        })
      })
  }

  return (
    <>
      <>
        <>
          <Header title={`LOGGA IN`} />
          <div className="container">
            <div className="row">
              <div className="col-lg-8 col-md-10 mx-auto">
                <div className="login-container">
                  <div className="card">
                    <div className="container">
                      <form onSubmit={handleFormSubmit}>
                        <div className="form-group">
                          <input
                            type="email"
                            className="form-control"
                            name="email"
                            id="email"
                            placeholder="E-postadress"
                            value={data.email}
                            onChange={handleInputChange}
                          />
                        </div>

                        <div className="form-group">
                          <input
                            type="password"
                            name="password"
                            id="password"
                            placeholder="Lösenord"
                            className="form-control"
                            value={data.password}
                            onChange={handleInputChange}
                          />
                        </div>

                        <button disabled={data.isSubmitting}>
                          {data.isSubmitting ? (
                            <Spinner animation="border" size="sm" role="status">
                              <span className="sr-only">Laddar...</span>
                            </Spinner>
                          ) : (
                            'LOGGA IN'
                          )}
                        </button>
                        {<span className="form-error">{data.errorMessage !== null ? data.errorMessage : ''}</span>}
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </>
      </>
    </>
  )
}

export default Login
