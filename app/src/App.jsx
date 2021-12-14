import React from 'react'
import { BrowserRouter } from 'react-router-dom'

import LoadingProvider from './components/LoadingProvider'
import ErrorProvider from './components/ErrorProvider'
import AuthProvider from './components/AuthProvider'

import Preloader from './components/Preloader/Preloader'
import Unavailable from './components/Unavailable/Unavailable'

import Router from './components/Router/Router'

import moment from 'moment'
import 'moment/locale/sv'
import Moment from 'react-moment'

import CookieConsent from 'react-cookie-consent'

import './App.scss'

const App = () => {
  momentConfig()

  return (
    <>
      <BrowserRouter>
        <ErrorProvider>
          <LoadingProvider>
            <AuthProvider>
              <CookieConsent
                location="bottom"
                buttonText="OK"
                style={{ background: '#2B373B', fontSize: '14px' }}
                buttonStyle={{ color: '#4e503b', fontSize: '17px' }}
                expires={365}
              >
                På vår site använder vi cookies. Om du vill fortsätta antar vi att du accepterar detta.
              </CookieConsent>
              <Unavailable />
              <Preloader />
              <Router />
            </AuthProvider>
          </LoadingProvider>
        </ErrorProvider>
      </BrowserRouter>
    </>
  )
}

const momentConfig = () => {
  Moment.globalMoment = moment
  Moment.globalLocale = 'sv'
  Moment.globalFormat = 'D MMM YYYY'
  Moment.globalLocal = true
  Moment.globalElement = 'span'
}

export default App
