import { useState, useEffect, useContext } from 'react'
import { useHistory } from 'react-router-dom'
import { get, getWithToken } from '../utils/rest'
import ErrorContext from '../context/error.context'
import AuthContext from '../context/auth.context'

const useInitialize = () => {
  const [routes, setRoutes] = useState({})
  const [menu, setMenu] = useState({})

  const [pageRoutesLoaded, setPageRoutesLoaded] = useState(false)
  const [newsRoutesLoaded, setNewsRoutesLoaded] = useState(false)
  const [menuLoaded, setMenuLoaded] = useState(false)

  useEffect(() => {
    get('_/items/meny?status=published&fields=*,menu_link.url,menu_link.titel,submenu.*,medlemmar')
      .then(res => {
        return res.json()
      })
      .then(res => {
        const menu = res.data.map(menuItem => ({
          label: menuItem.menu_item,
          link: menuItem.menu_link !== null ? menuItem.menu_link : null,
          private: (menuItem.medlemmar.length > 0 && menuItem.medlemmar.includes('members-only')) || false,
          submenu: menuItem.submenu.map(subMenuItem => ({
            name: subMenuItem.titel,
            url: subMenuItem.url,
            private: (subMenuItem.medlemmar.length > 0 && subMenuItem.medlemmar.includes('members-only')) || false,
          })),
        }))

        setMenu(menu)
        setMenuLoaded(true)

        return menu
      })

    get('_/items/nyheter?status=published&fields=url')
      .then(res => res.json())
      .then(res => {
        setNewsRoutesLoaded(true)
        return res.data.map(item => item.url)
      })
      .then(newsRoutes => {
        get('_/items/sidor?status=published&fields=url,medlemmar')
          .then(res => res.json())
          .then(res => {
            const pageRoutes = [
              ...new Set(
                res.data.map(page => ({
                  url: page.url,
                  private: (page.medlemmar.length > 0 && page.medlemmar.includes('members-only')) || false,
                }))
              ),
            ]
            setRoutes({ pages: pageRoutes, news: newsRoutes })
            setPageRoutesLoaded(true)
          })
      })
  }, [])

  return { menu: menu, routes: routes, initComplete: pageRoutesLoaded && newsRoutesLoaded && menuLoaded }
}

const getFetchUrl = (history, offset) => {
  const status = `status=published`

  const baseParams = `${status}`

  const files = `files.directus_files_id.private_hash,files.directus_files_id.title,files.directus_files_id.type`
  const header = `header.private_hash`
  const createdBy = `created_by.first_name`
  const current = 'single=1&filter[url]'
  const paging = `limit=5&offset=${offset ? offset : 0}`

  if (history.location.pathname === '/nyheter') {
    return {
      url: `_/items/nyheter?${baseParams}&${paging}&sort=-publish_date&fields=*,${createdBy}`,
      type: 'newsArchive',
    }
  } else if (history.location.pathname.includes('/nyheter')) {
    return {
      url: `_/items/nyheter?${baseParams}&${current}=${history.location.pathname
        .split('/nyheter/')
        .pop()}&fields=*,${header},${files},${createdBy}`,
      type: 'news',
    }
  } else {
    return {
      url: `_/items/sidor?${baseParams}&${current}=${history.location.pathname
        .split('/')
        .pop()}&fields=*,${header},${files},medlemmar`,
      type: 'page',
    }
  }
}

const useContent = (initComplete, routes) => {
  const history = useHistory()

  const { showError } = useContext(ErrorContext)

  const [content, setContent] = useState()
  const [loaded, setLoaded] = useState(false)

  const requestUrl = getFetchUrl(history)

  useEffect(() => {
    const isDirectusRoute = routes => {
      if (routes && routes.pages && routes.news) {
        return (
          routes.pages
            .map(x => {
              return `/${x.url}`
            })
            .includes(`${history.location.pathname}`) ||
          routes.news
            .map(url => {
              return `/nyheter/${url}`
            })
            .includes(`${history.location.pathname}`) ||
          history.location.pathname === '/nyheter'
        )
      } else return false
    }

    setContent(undefined)

    if (initComplete) {
      if (isDirectusRoute(routes)) {
        get(requestUrl.url)
          .then(res => {
            if (res.status !== 200) throw new Error()

            return res.json()
          })
          .then(res => {
            return new Promise(resolve => {
              setTimeout(() => {
                resolve(res)
              }, 0)
            })
          })
          .then(res => {
            setContent({ data: res.data, type: requestUrl.type })
            new Promise(() => {
              setTimeout(() => {
                setLoaded(true)
              }, 0)
            })
          })
          .catch(() => {
            showError()
          })
      } else {
        new Promise(resolve => {
          setTimeout(() => {
            setContent({})
            new Promise(() => {
              setTimeout(() => {
                setLoaded(true)
              }, 0)
            })
            resolve()
          }, 300)
        })
      }
    }
  }, [history.location, initComplete, requestUrl.type, requestUrl.url, routes, showError])

  return { content: { loaded: loaded, setLoaded: setLoaded, ...content } }
}

const usePartialContent = (offset, dataDispatch) => {
  const history = useHistory()
  const request = getFetchUrl(history, offset)

  useEffect(() => {
    if (offset !== 0) {
      dataDispatch({ type: 'FETCHING_DATA', fetching: true })

      get(request.url)
        .then(data => {
          return data.json()
        })
        .then(data => {
          const body = data.data
          dataDispatch({ type: 'STACK_DATA', news: body })
          dataDispatch({ type: 'FETCHING_DATA', fetching: false })
        })
        .catch(e => {
          dataDispatch({ type: 'FETCHING_DATA', fetching: false })
          return e
        })
    }
  }, [dataDispatch, offset, request.url])
}

const useIsAuthenticated = isPrivateRoute => {
  const { dispatch } = useContext(AuthContext)
  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const [waitingToResolve, setWaitingToResolve] = useState(false)

  useEffect(() => {
    if (isPrivateRoute.state) {
      setWaitingToResolve(true)

      const token = JSON.parse(localStorage.getItem('token')) || ''

      getWithToken('_/users/me', token)
        .then(res => {
          if (res.status === 200) {
            setIsAuthenticated(true)

            dispatch({
              type: 'LOGIN',
              payload: {
                data: { token: token, user: { email: JSON.parse(localStorage.getItem('user')) } },
              },
            })
          } else if (res.status === 401) {
            dispatch({
              type: 'LOGOUT',
            })
          }
        })

        .catch(error => {
          dispatch({
            type: 'LOGOUT',
          })
        })
        .finally(() => {})

      setWaitingToResolve(false)
    }
  }, [isPrivateRoute.hash, dispatch, isPrivateRoute.state])

  return { isAuthenticated: isAuthenticated, waitingToResolve: waitingToResolve }
}

export { useInitialize, useContent, useIsAuthenticated, usePartialContent }
