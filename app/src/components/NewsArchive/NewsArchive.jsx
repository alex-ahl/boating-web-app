import React, { useReducer, useRef } from 'react'
import { useHistory } from 'react-router-dom'
import background from '../../assets/images/home-bg.jpg'
import { usePartialContent } from '../../hooks/directus'
import { useInfiniteScroll } from '../../hooks/infinite-scroll'
import { Spinner } from 'react-bootstrap'
import Moment from 'react-moment'

import './NewsArchive.scss'

const NewsArchive = props => {
  const history = useHistory()

  const dataReducer = (state, action) => {
    switch (action.type) {
      case 'STACK_DATA':
        return { ...state, news: state.news.concat(...action.news) }
      case 'FETCHING_DATA':
        return { ...state, fetching: action.fetching }
      default:
        return state
    }
  }

  const pageReducer = (state, action) => {
    switch (action.type) {
      case 'ADVANCE_PAGE':
        return { ...state, page: state.page + 5 }
      default:
        return state
    }
  }

  const [pager, pagerDispatch] = useReducer(pageReducer, { page: 0 })
  const [data, dataDispatch] = useReducer(dataReducer, { news: [], fetching: true })

  usePartialContent(pager.page, dataDispatch)
  let bottomBoundaryRef = useRef(null)
  useInfiniteScroll(bottomBoundaryRef, pagerDispatch)

  return (
    <>
      {props.content.loaded && props.content.type === 'newsArchive' && (
        <>
          <header className="masthead" style={{ backgroundImage: `url(${background})` }}>
            <div className="overlay"></div>
            <div className="container">
              <div className="row">
                <div className="col-lg-8 col-md-10 mx-auto">
                  <div className="site-heading">
                    <h1>Nyheter</h1>
                    <span className="subheading"></span>
                  </div>
                </div>
              </div>
            </div>
          </header>
          <div className="container">
            <div className="row">
              <div className="col-lg-8 col-md-10 mx-auto">
                {props.content.data.map((newsItem, index) => (
                  <div key={index}>
                    <div className="post-preview">
                      <a
                        href={`/nyheter/${newsItem.url}`}
                        onClick={e => {
                          e.preventDefault()
                          props.content.setLoaded(false)
                          history.push({
                            pathname: e.currentTarget.getAttribute('href'),
                            state: { prevPath: history.location.pathname },
                          })
                        }}
                      >
                        <h2 className="post-title">{newsItem.titel}</h2>
                        {newsItem.ingress !== null && newsItem.ingress !== undefined && newsItem.ingress.length > 0 && (
                          <h3 className="post-subtitle">{newsItem.ingress}</h3>
                        )}
                      </a>
                      <p className="post-meta">
                        Postad av {newsItem.created_by.first_name} den&nbsp;
                        <Moment format="LLL">{newsItem.publish_date}</Moment>
                      </p>
                    </div>
                    <hr />
                  </div>
                ))}

                {data.news && (
                  <>
                    {data.news.map((news, index) => {
                      const { titel, url, ingress, created_by, publish_date } = news
                      return (
                        <div key={index}>
                          <div className="post-preview">
                            <a
                              href={`/nyheter/${url}`}
                              onClick={e => {
                                e.preventDefault()
                                props.content.setLoaded(false)
                                history.push({
                                  pathname: e.currentTarget.getAttribute('href'),
                                  state: { prevPath: history.location.pathname },
                                })
                              }}
                            >
                              <h2 className="post-title">{titel}</h2>
                              {ingress !== null && ingress !== undefined && ingress.length > 0 && (
                                <h3 className="post-subtitle">{ingress}</h3>
                              )}
                            </a>
                            <p className="post-meta">
                              Postad av {created_by.first_name} den&nbsp;
                              <Moment format="LLL">{publish_date}</Moment>
                            </p>
                          </div>
                          <hr />
                        </div>
                      )
                    })}

                    {data.fetching && (
                      <div className="container">
                        <div className="row">
                          <div className="col-lg-8 col-md-10 mx-auto text-center">
                            <Spinner animation="border" role="status">
                              <span className="sr-only">Loading...</span>
                            </Spinner>
                          </div>
                        </div>
                      </div>
                    )}
                    <div id="page-bottom-boundary" ref={bottomBoundaryRef}></div>
                  </>
                )}
              </div>
            </div>
          </div>
        </>
      )}
    </>
  )
}

export default NewsArchive
