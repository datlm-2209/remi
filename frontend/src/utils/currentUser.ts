export const isAuthenticated = () => {
  return localStorage.getItem('isAuthenticated') === 'true'
}

export const currentUser = {
  token: localStorage.getItem('token'),
  email: localStorage.getItem('email'),
  username: localStorage.getItem('username')
}
