import { useEffect } from 'react'

const useFormatTables = htmlReactRef => {
  useEffect(() => {
    if (htmlReactRef === undefined || htmlReactRef.current === '') return

    if (htmlReactRef.current.getElementsByTagName('table').length > 0) {
      let arr = Array.from(htmlReactRef.current.getElementsByTagName('table')).map((t, i) => {
        t.className += ' table table-hover'
        t.removeAttribute('border')

        let trs = Array.from(t.getElementsByTagName('tr'))
        if (trs !== undefined && trs.length > 0) {
          trs.map((tr, index) => {
            if (index === 0) Array.from(tr.getElementsByTagName('td')).map(td => (td.style.borderTop = '0'))
            return []
          })
        }

        return arr
      })
    }
  }, [htmlReactRef])

  return
}

const useNoIndex = (isPrivate, pageChange) => {
  useEffect(() => {
    const head = document.getElementsByTagName('head')[0]
    var link = document.createElement('meta')

    if (isPrivate) {
      link.setAttribute('name', 'robots')
      link.content = 'noindex'
      head.appendChild(link)
    }

    return () => {
      if (head.contains(link)) document.getElementsByTagName('head')[0].removeChild(link)
    }
  }, [pageChange, isPrivate])
}

export { useFormatTables, useNoIndex }
