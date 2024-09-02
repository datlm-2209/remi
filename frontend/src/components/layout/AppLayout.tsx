
import { ReactNode } from "react"
import Header from "@/components/Header"
import Notifications from "../Notifications"

type Props = {
  children: ReactNode
}
function AppLayout({ children }: Props) {
  return (
    <div className="flex min-h-screen w-full flex-col">
      <Header />
      <Notifications />
      <main className="flex min-h-[calc(100vh_-_theme(spacing.16))] flex-1 flex-col gap-4 bg-muted/40 p-4 md:gap-8 md:p-10">
        <div className="mx-auto grid w-full max-w-5xl items-start gap-6">
          {children}
        </div>
      </main>
    </div>
  )
}

export default AppLayout
