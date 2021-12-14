import React, { useContext, useEffect } from 'react'
import { Switch, Route, withRouter, useHistory, Redirect } from 'react-router-dom'
import { TransitionGroup, CSSTransition } from 'react-transition-group'

import AuthContext from '../../context/auth.context'
import LoadingContext from '../../context/loading.context'
import ErrorContext from '../../context/error.context'
import * as directus from '../../hooks/directus'
import { useIsPrivateRoute } from '../../hooks/auth'
import './Router.scss'

import Login from '../Login/Login'
import Home from '../Home/Home'
import Page from '../Page/Page'
import NewsArchive from '../NewsArchive/NewsArchive'
import Navigation from '../Navbar/Navbar'
import NewsPost from '../NewsPost/NewsPost'

const RouterWrapper = () => {
  const history = useHistory()
  const { setSpinnerWithTimeout } = useContext(LoadingContext)
  const { state } = useContext(AuthContext)
  const { errorCount } = useContext(ErrorContext)

  const { menu, routes, initComplete } = directus.useInitialize()
  const data = directus.useContent(initComplete, routes)
  const { isPrivateRoute } = useIsPrivateRoute(routes)
  directus.useIsAuthenticated(isPrivateRoute)

  useEffect(() => {
    if (!data.content.loaded) setSpinnerWithTimeout(true)
    else setSpinnerWithTimeout(false)
    // eslint-disable-next-line
  }, [data.content.loaded])

  useEffect(() => {
    if (history.action === 'POP' || history.action === 'PUSH') data.content.setLoaded(false)
    // eslint-disable-next-line
  }, [history.location])

  const PrivateRoute = ({ children, ...rest }) => {
    if (!state || state.waitingToResolve) {
    } else {
      return (
        <Route
          {...rest}
          render={({ location }) =>
            state.isAuthenticated ? (
              children
            ) : (
              <Redirect
                to={{
                  pathname: '/login',
                  state: { from: location },
                }}
              />
            )
          }
        />
      )
    }
  }
  return (
    <React.Fragment>
      {(errorCount === undefined || errorCount === 0) && (
        <div className="router-wrapper">
          <TransitionGroup className="transition-group">
            <CSSTransition
              key={data.content.loaded}
              timeout={{ enter: 200, exit: 200 }}
              onExit={() => {}}
              onExiting={() => {}}
              onEntering={() => {}}
              onEnter={() => {}}
              classNames="fade"
            >
              <section className="route-section">
                {data.content.loaded && (
                  <>
                    <Navigation {...data} menu={menu} />

                    <Switch location={history.location}>
                      <Route exact path="/" render={props => <Home {...data} {...props} />} />

                      <Route exact path="/login" render={props => <Login {...props} />} />

                      <Route
                        exact
                        path={'/nyheter'}
                        render={props => {
                          return <NewsArchive {...data} {...props} />
                        }}
                      />
                      {routes.news.map((routes, index) => {
                        return (
                          <Route
                            key={index}
                            exact
                            path={`/nyheter/${routes}`}
                            render={props => {
                              return <NewsPost {...data} {...props} />
                            }}
                          />
                        )
                      })}
                      {routes.pages.map((route, index) => {
                        return route.private ? (
                          <PrivateRoute key={index} exact path={`/${route.url}`}>
                            <Page {...data} />
                          </PrivateRoute>
                        ) : (
                          <Route
                            key={index}
                            exact
                            path={`/${route.url}`}
                            render={props => {
                              return <Page {...props} {...data} />
                            }}
                          />
                        )
                      })}

                      <Route path="*">
                        <Page
                          data={{
                            data: { titel: 'SIDAN FINNS INTE', body: 'Sidan finns', header: { data: {} }, files: [] },
                            loaded: true,
                          }}
                        />
                      </Route>
                    </Switch>
                  </>
                )}
              </section>
            </CSSTransition>
          </TransitionGroup>
        </div>
      )}
    </React.Fragment>
  )
}
export default withRouter(RouterWrapper)
