const get = ((restService, baseUrl) => endpoint => {
  return restService(`${baseUrl}/${endpoint}`, {
    method: 'GET',
    headers: {
      Authorization: `Bearer ${process.env.REACT_APP_AUTH_TOKEN}`,
    },
  })
})(window.fetch, process.env.REACT_APP_BASE_API_URL)

const getWithToken = ((restService, baseUrl) => (endpoint, token) => {
  return restService(`${baseUrl}/${endpoint}`, {
    method: 'GET',
    headers: {
      Authorization: `Bearer ${token}`,
    },
  })
})(window.fetch, process.env.REACT_APP_BASE_API_URL)

export { get, getWithToken }
