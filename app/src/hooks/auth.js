import { useState, useEffect } from 'react'
import { useLocation } from 'react-router-dom'

const useIsPrivateRoute = routes => {
  const location = useLocation()

  const [isPrivateRoute, setIsPrivateRoute] = useState({ state: true, route: location.pathname, hash: '' })

  useEffect(() => {
    if (!routes || routes.pages === undefined) return

    const privateRoutes = routes.pages
      .filter(x => x.private === true)
      .map(x => {
        return `/${x.url}`
      })

    const hash = Math.random()
      .toString(36)
      .substr(2, 5)

    if (privateRoutes.includes(location.pathname)) {
      setIsPrivateRoute({ state: true, route: location.pathname, hash: hash })
    }
  }, [location, routes])

  return { isPrivateRoute }
}

export { useIsPrivateRoute }
