export const isAuthenticated = () => {
  return localStorage.getItem('loggedIn') === 'true'
}

export const currentUser = {
  email: localStorage.getItem('email'),
  name: localStorage.getItem('name')
}
