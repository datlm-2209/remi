export const isAuthenticated = () => {
  return localStorage.getItem('isAuthenticated') === 'true'
}

export const currentUser = {
  email: localStorage.getItem('email'),
  username: localStorage.getItem('username')
}
