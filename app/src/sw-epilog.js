importScripts('localforage.min.js')

// sw-epilog.js
// // Add a listener to receive messages from clients
// self.addEventListener('message', function(event) {
//   // Force SW upgrade (activation of new installed SW version)
//   if (event.data === 'skipWaiting') {
//     self.skipWaiting()
//   }
// })

self.addEventListener('install', event => {
  new Promise(function(resolve) {
    setTimeout(function() {
      resolve()
    }, 15000)
  }).then(function() {
    localforage.getItem('pagesUrl').then(function(url) {
      localforage.getItem('jwt').then(function(jwt) {
        fetch(url, {
          method: 'GET',
          headers: {
            Authorization: `Bearer ${jwt}`,
          },
        })
          .then(function(response) {
            console.log(response)
            return response.json()
          })
          .then(function(response) {
            console.log(response)
            response.data.map(function(item) {
              localforage.setItem(item.url, item)
            })
          })
      })
    })
  })
})

self.addEventListener('fetch', event => {
  console.log('INTERCEPTED REQUEST: ' + event.request)

  if (event.request.method === 'POST') return fetch(event.request)
  if (!event.request.url.includes('&filter[url]=')) return fetch(event.request)

  let data = event.request.url
  let url = data
    .split('&filter[url]=')
    .pop()
    .split('&')[0]

  console.log('Past first if in sw ')
  console.log('URL in sw: ' + url)

  const promiseChain = localforage
    .getItem(url, function(err, value) {
      console.log('value in sw: ' + value)
      return value
    })
    .then(function(res) {
      console.log('res in sw: ' + res)
      if (res !== null) return new Response(JSON.stringify(res))
      else fetch(event.request)
    })

  console.log(promiseChain)
  //   console.log(typeof promiseChain)
  event.respondWith(promiseChain)
  // Instead of fetch(), you could have called caches.match(),
  // or anything else that returns a promise for a Response.

  // Synchronously call event.respondWith(), passing in the
  // async promise chain.

  //   const promise = localforage
  //     .getItem(url, function(err, value) {
  //       console.log(err + value)

  //       if (value === null) return fetch(event.request)

  //       return new Promise(function(resolve, reject) {
  //         resolve(new Response(value))
  //       })
  //     })
  //     .catch(function() {
  //       fetch(event.request)
  //     })
  //   console.log(typeof promise)
  //   console.log(promise)

  //   event.respondWith(promise)
})

//   var response
//   event.respondWith(
//     localforage
//       .getItem(url, function(err, value) {})
//       .catch(function() {
//         return fetch(event.request)
//       })
//       .then(function(r) {
//         response = r
//         caches.open('v1').then(function(cache) {
//           cache.put(event.request, response)
//         })
//         return response.clone()
//       })
//       .catch(function() {})
//   )
// })
