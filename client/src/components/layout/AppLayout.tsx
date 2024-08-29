import { ReactNode } from "react"

type Props = {
  children: ReactNode
}

function AppLayout({ children }: Props) {
  return (
    <div className="flex items-center justify-center min-h-screen">
      {children}
    </div>
  )
}

export default AppLayout
