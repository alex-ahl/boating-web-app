import React, { useContext } from 'react'
import { Container } from 'react-bootstrap'
import LoadingContext from '../../context/loading.context'
import './Preloader.scss'
import { TransitionGroup, CSSTransition } from 'react-transition-group'
import ErrorContext from '../../context/error.context'

const Preloader = () => {
  const { showSpinner } = useContext(LoadingContext)
  const { errorCount } = useContext(ErrorContext)
  return (
    <>
      {(errorCount === undefined || errorCount === 0) && (
        <div className="router-wrapper">
          <TransitionGroup className="transition-group">
            <CSSTransition key={showSpinner} timeout={{ enter: 200, exit: 200 }} classNames="fade">
              <section className="route-section">
                {showSpinner && (
                  <Container fluid={true} id="preload-wrapper">
                    <div className="ac-animated-svg-icon ac-svg-animated">
                      <div className="ac-animated-svg-icon-contents">
                        <div className="ac-animated-svg-boat">
                          <svg
                            className="svg-boat"
                            version="1.1"
                            id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg"
                            x="0px"
                            y="0px"
                            viewBox="0 0 160 192"
                            //   style={{marginRight: spacing + 'em'}}
                            // //   style="enable-background:new 0 0 160 192;"
                          >
                            <style
                              dangerouslySetInnerHTML={{
                                __html: `
                      .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#4f79bd;}
                      .st1{fill:#4f79bd;}
                         @media (max-width: 600px) {
                         `,
                              }}
                            ></style>
                            <g>
                              <path className="st0" d="M78,137h4c3.9,0,7,3.1,7,7v1H71v-1C71,140.1,74.1,137,78,137z" />
                              <path className="st0" d="M79,0h2c1.1,0,2,0.9,2,2v135h-6V2C77,0.9,77.9,0,79,0z" />
                              <path
                                className="st0"
                                d="M1.8,148h156.3c1,0,1.8,0.8,1.8,1.8l-23.8,26.2c0,20.1-8.1,15.5-28.4,15.5h-63c-20.2,0-23.8,2.8-23.8-17.3
                             L0,149.8C0,148.8,0.8,148,1.8,148z"
                              />
                              <path className="st1" d="M27,135l47.9-0.5L75,39L27,135z" />
                              <path className="st1" d="M133,135l-47.9-0.5L85,39L133,135z" />
                            </g>
                          </svg>
                          <svg
                            className="svg-flag"
                            version="1.1"
                            id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg"
                            x="0px"
                            y="0px"
                            viewBox="0 0 46 24"
                            //   style="enable-background:new 0 0 46 24;"
                          >
                            <style
                              dangerouslySetInnerHTML={{
                                __html: `
                         .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#4f79bd;}
                         @media (max-width: 600px) {
                         `,
                              }}
                            ></style>
                            <path className="st0" d="M0,0h41c2.8,0,5,2.2,5,5v14c0,2.8-2.2,5-5,5H0V0z" />
                          </svg>
                          <svg
                            className="svg-water svg-water-1"
                            version="1.1"
                            id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg"
                            x="0px"
                            y="0px"
                            viewBox="0 0 150 15"
                            //   style="enable-background:new 0 0 150 15;"
                          >
                            <style
                              dangerouslySetInnerHTML={{
                                __html: `
                           .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#4f79bd;}
                             @media (max-width: 600px) {
                         `,
                              }}
                            ></style>

                            <path
                              className="st0"
                              d="M0.2,10C23.4,3,48.2,8,74,10c25.7,2.4,52.1-0.9,75.5-10c0.2,0,0.3,0,0.5,0.3c-24.3,14.3-49.5,16.2-74.5,13.9
                         C50.4,11.2,26,9.4,0,11.7C0.1,11.5,0.1,10.9,0.2,10L0.2,10L0.2,10z"
                            />
                          </svg>
                          <svg
                            className="svg-water svg-water-2"
                            version="1.1"
                            id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg"
                            x="0px"
                            y="0px"
                            viewBox="0 0 150 15"
                            //   style="enable-background:new 0 0 150 15;"
                          >
                            <style type="text/css"></style>

                            <style
                              dangerouslySetInnerHTML={{
                                __html: `
                         .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#4f79bd;}
                             @media (max-width: 600px) {
                         `,
                              }}
                            ></style>
                            <path
                              className="st0"
                              d="M0.2,10C23.4,3,48.2,8,74,10c25.7,2.4,52.1-0.9,75.5-10c0.2,0,0.3,0,0.5,0.3c-24.3,14.3-49.5,16.2-74.5,13.9
                         C50.4,11.2,26,9.4,0,11.7C0.1,11.5,0.1,10.9,0.2,10L0.2,10L0.2,10z"
                            />
                          </svg>
                          <svg
                            className="svg-water svg-water-3"
                            version="1.1"
                            id="Layer_1"
                            xmlns="http://www.w3.org/2000/svg"
                            x="0px"
                            y="0px"
                            viewBox="0 0 150 15"
                            //   style="enable-background:new 0 0 150 15;"
                          >
                            <style type="text/css"></style>

                            <style
                              dangerouslySetInnerHTML={{
                                __html: `
                         .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#4f79bd;}
                         @media (max-width: 600px) {
                         `,
                              }}
                            ></style>
                            <path
                              className="st0"
                              d="M0.2,10C23.4,3,48.2,8,74,10c25.7,2.4,52.1-0.9,75.5-10c0.2,0,0.3,0,0.5,0.3c-24.3,14.3-49.5,16.2-74.5,13.9
                         C50.4,11.2,26,9.4,0,11.7C0.1,11.5,0.1,10.9,0.2,10L0.2,10L0.2,10z"
                            />
                          </svg>
                        </div>
                        <h3 style={{ color: '#4f79bd', marginTop: 20 }}>Laddar..</h3>
                      </div>
                    </div>
                  </Container>
                )}
              </section>
            </CSSTransition>
          </TransitionGroup>
        </div>
      )}
    </>
  )
}

export default Preloader
