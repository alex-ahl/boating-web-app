import React, { useEffect } from 'react'
import './Footer.scss'

const Footer = props => {
  useEffect(() => {})

  return (
    <>
      {props.show && (
        <>
          <hr />
          <footer>
            <div className="container">
              <div className="row">
                <div className="col-lg-8 col-md-10 mx-auto ">
                  <p className="copyright text-muted">&copy; App {new Date().getFullYear()}</p>
                </div>
              </div>
            </div>
          </footer>
        </>
      )}
    </>
  )
}

export default Footer
