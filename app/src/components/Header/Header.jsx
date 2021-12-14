import React from 'react'
import './Header.scss'
import background from '../../assets/images/home-bg.jpg'

const Header = ({ title, ingress, image }) => {
  const headerImage =
    image !== undefined
      ? `${process.env.REACT_APP_BASE_API_URL}/_/assets/${image}?w=2400&h=532&f=crop&q=50`
      : background
  return (
    <header className="masthead" style={{ backgroundImage: `url(${headerImage})` }}>
      <div className="overlay"></div>
      <div className="container">
        <div className="row">
          <div className="col-lg-8 col-md-10 mx-auto">
            <div className="site-heading">
              <h1>{title}</h1>
              {ingress !== null && ingress !== undefined && ingress.length > 0 && (
                <span className="subheading">{ingress}</span>
              )}
            </div>
          </div>
        </div>
      </div>
    </header>
  )
}

export default Header
