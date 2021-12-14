import React, { useCallback, useEffect, useRef, useState, useContext } from 'react'
import { Container, Navbar, NavbarBrand, Nav, NavDropdown, NavItem } from 'react-bootstrap'
import './Navbar.scss'
import { useMediaQuery } from 'react-responsive'
import { useHistory } from 'react-router-dom'
import AuthContext from '../../context/auth.context'
import useOutsideClick from '../../hooks/dom'

const Navigation = props => {
  const { state, dispatch } = useContext(AuthContext)

  const [previousScrollPosition, setPreviousScrollPosition] = useState(0)
  const [isFixed, setIsFixed] = useState(false)
  const [isVisible, setIsVisible] = useState(false)
  const [logoColor, setLogoColor] = useState('#fff')

  const history = useHistory()
  const navBar = useRef(null)

  const getCurrentScrollPosition = (window => () => window.scrollY)(window)

  const handleScroll = useCallback(() => {
    let headerHeight = navBar.current.clientHeight
    let currentScrollPosition = getCurrentScrollPosition()

    if (currentScrollPosition < previousScrollPosition) {
      if (currentScrollPosition > 0 && isFixed) {
        setIsVisible(true)
      } else {
        setIsFixed(false)
        setIsVisible(false)
        setLogoColor('#fff')
      }
    } else if (currentScrollPosition > previousScrollPosition) {
      setIsVisible(false)
      if (currentScrollPosition > headerHeight && !isFixed) {
        setIsFixed(true)
        setLogoColor('#212529')
      }
    }

    setPreviousScrollPosition(currentScrollPosition)
  }, [navBar, getCurrentScrollPosition, previousScrollPosition, isFixed])

  useEffect(() => {
    let MQL = 992
    if (window.innerWidth > MQL) {
      window.addEventListener('scroll', handleScroll)

      return function cleanup() {
        window.removeEventListener('scroll', handleScroll)
      }
    }
  })

  const [isNavExpanded, setIsNavExpanded] = useState(false)

  useOutsideClick(navBar, () => {
    setIsNavExpanded(false)
  })

  const Logo = () => 'LOGO HERE'

  const logoStyle = {
    maxHeight: '55px',
  }

  const isLarge = useMediaQuery({
    query: '(min-device-width: 992px)',
  })

  const isTabletOrMobileDevice = useMediaQuery({
    query: '(max-device-width: 992px)',
  })

  return (
    <Navbar
      id="mainNav"
      expand="lg"
      fixed="top"
      ref={navBar}
      className={`${isFixed ? 'is-fixed' : ''} ${isVisible ? 'is-visible' : ''}`}
      onToggle={setIsNavExpanded}
      expanded={isNavExpanded}
    >
      <Container>
        <NavbarBrand
          href="/"
          onClick={e => {
            e.preventDefault()
            props.content.setLoaded(false)
            history.push({
              pathname: e.currentTarget.getAttribute('href'),
              state: { prevPath: history.location.pathname },
            })
          }}
        >
          {isLarge && (
            <>
              <Logo color={logoColor} style={logoStyle} alt="logo" />
            </>
          )}

          {isTabletOrMobileDevice && (
            <>
              <Logo color={'#000'} style={logoStyle} alt="logo" />
            </>
          )}
        </NavbarBrand>
        <Navbar.Toggle aria-controls="basic-navbar-nav">
          Meny&nbsp;
          <i className="fas fa-bars"></i>
        </Navbar.Toggle>
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="ml-auto">
            <NavItem>
              <Nav.Link
                href="/nyheter"
                onClick={e => {
                  e.preventDefault()
                  props.content.setLoaded(false)
                  history.push({
                    pathname: e.target.getAttribute('href'),
                    state: { prevPath: history.location.pathname },
                  })
                }}
              >
                Nyheter
              </Nav.Link>
            </NavItem>
            {props.menu.map((item, index) =>
              item.submenu.length === 0 ? (
                <NavItem key={item.link.url}>
                  <Nav.Link
                    href={`/${item.link.url}`}
                    onClick={e => {
                      e.preventDefault()
                      props.content.setLoaded(false)

                      history.push({
                        pathname: e.target.getAttribute('href'),
                        state: { prevPath: history.location.pathname },
                      })
                    }}
                  >
                    {item.link.titel}
                  </Nav.Link>
                </NavItem>
              ) : (
                <NavDropdown key={index} title={item.label} id="basic-nav-dropdown">
                  {item.submenu.map((subMenuItem, index) => (
                    <React.Fragment key={subMenuItem.url}>
                      <NavDropdown.Item
                        href={`/${subMenuItem.url}`}
                        onClick={e => {
                          e.preventDefault()
                          props.content.setLoaded(false)

                          history.push({
                            pathname: e.target.getAttribute('href'),
                            state: { prevPath: history.location.pathname },
                          })
                        }}
                      >
                        {subMenuItem.name}
                      </NavDropdown.Item>
                    </React.Fragment>
                  ))}
                </NavDropdown>
              )
            )}
            <NavItem>
              {state && !state.isAuthenticated ? (
                <Nav.Link
                  href="/login"
                  onClick={e => {
                    e.preventDefault()
                    props.content.setLoaded(false)
                    history.push({
                      pathname: e.target.getAttribute('href'),
                      state: { prevPath: history.location.pathname },
                    })
                  }}
                >
                  Logga in
                </Nav.Link>
              ) : (
                <Nav.Link
                  href="/logout"
                  onClick={e => {
                    e.preventDefault()
                    props.content.setLoaded(false)

                    dispatch({
                      type: 'LOGOUT',
                    })
                    history.push({
                      pathname: history.location.pathname,
                      state: { prevPath: history.location.pathname },
                    })
                  }}
                >
                  Logga ut
                </Nav.Link>
              )}
            </NavItem>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  )
}

export default Navigation
