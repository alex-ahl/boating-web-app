import React, { useRef, useState, useEffect } from 'react'
import { useFormatTables } from '../../utils/hooks'
import background from '../../assets/images/home-bg.jpg'
import { ListGroup } from 'react-bootstrap'
import Moment from 'react-moment'

import './NewsPost.scss'

const NewsPost = props => {
  const bodyRef = useRef('')
  useFormatTables(bodyRef)

  const [headerImage, setHeaderImage] = useState(background)
  useEffect(() => {
    setHeaderImage(
      props.content.data.header !== undefined &&
        props.content.data.header !== null &&
        props.content.data.header.private_hash !== undefined
        ? `${process.env.REACT_APP_BASE_API_URL}/_/assets/${props.content.data.header.private_hash}?w=2400&h=532&f=crop&q=50`
        : background
    )
  }, [props.content.data])

  return (
    <React.Fragment>
      {props.content.loaded && props.content.type === 'news' && (
        <>
          <header className="masthead" style={{ backgroundImage: `url(${headerImage})` }}>
            <div className="overlay"></div>
            <div className="container">
              <div className="row">
                <div className="col-lg-8 col-md-10 mx-auto">
                  <div className="post-heading">
                    <h1>{props.content.data.titel}</h1>
                    {props.content.data.ingress !== null &&
                      props.content.data.ingress !== undefined &&
                      props.content.data.ingress.length > 0 && (
                        <h2 className="subheading">{props.content.data.ingress}</h2>
                      )}

                    <span className="meta">
                      Postad av {props.content.data.created_by.first_name} den&nbsp;
                      <Moment format="LLL">{props.content.data.publish_date}</Moment>
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </header>

          <article>
            <div className="container">
              <div className="row">
                <div
                  className="col-lg-8 col-md-10 mx-auto"
                  dangerouslySetInnerHTML={{
                    __html: props.content.data.body,
                  }}
                  ref={bodyRef}
                ></div>
              </div>
              {props.content.data.files.length > 0 && (
                <div className="row">
                  <div className="col-lg-8 col-md-10 mx-auto">
                    <h4>Filer</h4>
                    <ListGroup>
                      {props.content.data.files.map((file, index) => (
                        <ListGroup.Item
                          action
                          target="_blank"
                          href={`${process.env.REACT_APP_BASE_API_URL}/_/assets/${file.directus_files_id.private_hash}`}
                          key={index}
                        >
                          <React.Fragment>{file.directus_files_id.title} </React.Fragment>
                          <React.Fragment>
                            {(() => {
                              switch (file.directus_files_id.type) {
                                case 'application/pdf':
                                  return <i className="fas fa-file-pdf"></i>
                                case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
                                  return <i className="fas fa-file-word"></i>
                                case 'application/msword':
                                  return <i className="fas fa-file-word"></i>
                                default:
                                  return <i className="fas fa-file"></i>
                              }
                            })()}
                          </React.Fragment>
                        </ListGroup.Item>
                      ))}
                    </ListGroup>
                  </div>
                </div>
              )}
            </div>
          </article>
        </>
      )}
    </React.Fragment>
  )
}

export default NewsPost
