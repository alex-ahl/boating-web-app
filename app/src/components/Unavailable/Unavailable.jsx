import React, { useContext } from 'react'
import './Unavailable.scss'
import { Container } from 'react-bootstrap'
import ErrorContext from '../../context/error.context'

const Unavailable = () => {
  const { errorCount } = useContext(ErrorContext)
  return (
    <>
      {errorCount > 0 && (
        <Container fluid={true} id="error-wrapper">
          <div className="error-wrapper">
            <h2>Hemsidan är inte tillgänglig just nu.</h2>
          </div>
        </Container>
      )}
    </>
  )
}

export default Unavailable
