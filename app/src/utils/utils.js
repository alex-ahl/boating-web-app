export const wait = number => new Promise(resolve => setTimeout(resolve, number))

export const formatTables = table => {
  table.className += 'table table-hover'
}
