import React, { useRef } from 'react'
import { ListGroup } from 'react-bootstrap'

import './Page.scss'
import { useFormatTables, useNoIndex } from '../../utils/hooks'

import Header from '../Header/Header'

const Page = props => {
  const isPrivate =
    props.content && props.content.data && props.content.data.medlemmar && props.content.data.medlemmar.length > 0

  useNoIndex(isPrivate, props.content.loaded)

  const bodyRef = useRef('')
  useFormatTables(bodyRef)

  return (
    <React.Fragment>
      {props.content.loaded && props.content.type === 'page' && (
        <React.Fragment>
          {props.content.data.header ? (
            <Header
              title={props.content.data.titel}
              ingress={props.content.data.ingress}
              image={props.content.data.header.private_hash}
            />
          ) : (
            <Header title={props.content.data.titel} ingress={props.content.data.ingress} />
          )}
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
            {props.content.data.files &&
              props.content.data.files.length > 0 &&
              props.content.data.files.some(x => x.directus_files_id !== null) && (
                <div className="row">
                  <div className="col-lg-8 col-md-10 mx-auto">
                    <h4>Filer</h4>
                    <ListGroup>
                      {props.content.data.files
                        .filter(x => x.directus_files_id !== null)
                        .map((file, index) => (
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
        </React.Fragment>
      )}
    </React.Fragment>
  )
}

export default Page
